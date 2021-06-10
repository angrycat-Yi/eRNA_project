#!/usr/bin/python

import argparse,os

## set parser help
parser=argparse.ArgumentParser()
parser.add_argument("-b","--bam",required=True, help="input bam directory")
parser.add_argument("-r","--region",required=True, help="input the bed region file")
parser.add_argument("-o","--outpath",required=True, help="input the output path")
parser.add_argument("-g","--gff",required=True, help="the gff file")

args=parser.parse_args()

# use samtools to extract bed regions
def parse_bam(direct_path,bed,outpath):
	
	bed=os.path.abspath(bed)	
	path=os.path.abspath(direct_path)
	files=os.listdir(path)
	outpath=os.path.abspath(outpath)

	cmd = """module load samtools\n"""
	
	for file in files:
		if not os.path.isdir(file):
		
			filepath = path + '/' + file
			cmd += "samtools view -bh -L " + bed + " " + filepath + " > " + outpath + "/01.samtools/" + file + "\n"
	
	cmd = cmd +  "module unload samtools"		 
	sge_set = set_sge()
	
	cmd = sge_set + cmd
	write_script(outpath + "/shell/step1_samtools.sh",cmd)


# htseq read counts
def htseq(outpath,gff):
	
	outpath = os.path.abspath(outpath)
	path=os.path.abspath(outpath + "/01.samtools")
	files=os.listdir(path)

	#gtf="/data/BCI-Haemato/Refs/GRCh38/Annotation/hg38.gtf"
	cmd="source /data/home/hfx472/envs/htseq-count/bin/activate\n"

	for file in files:
		if not os.path.isdir(file):
			
			file_pr = file[:len(file)-4]
			
			filepath = path + "/" + file	
				
			cmd += "htseq-count -f bam -s reverse " + filepath + " " + gff + " >" + outpath + "/02.htseq/" + file_pr + "_Counts.txt" + "\n"
		
	sge_set = set_sge()

	cmd = sge_set + cmd + "deactivate"
	write_script(outpath + "/shell/step2_htseq.sh",cmd)
	

# set SGE options
def set_sge():
	
	opt = """#!/bin/sh
#$ -V                   # this makes it verbose
#$ -j y                 # and put all output (inc errors) into it
#$ -pe smp 1            # Request 4 CPU cores
#$ -l h_rt=120:0:0      # Request 12 hour runtime (upto 240 hours)
#$ -l h_vmem=16G                # Request 4GB RAM / core
#$ -N Hisat2-HiSat2_Align
"""
	return opt
	

# write cmds function
def write_script(file,cmd):

	with open(file,"w") as f:
		f.write(cmd)

# the main function
if __name__ == '__main__':
	
	if not os.path.exists(args.outpath + "/shell"):
		os.mkdir(args.outpath + "/shell")
	
	if not os.path.exists(args.outpath + "/01.samtools"):
		os.mkdir(args.outpath + "/01.samtools")

	if not os.path.exists(args.outpath + "/02.htseq"):
		os.mkdir(args.outpath + "/02.htseq") 

	parse_bam(args.bam,args.region,args.outpath)
	htseq(args.outpath,args.gff)
