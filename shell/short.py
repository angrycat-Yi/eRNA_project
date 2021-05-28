#!/usr/bin/python

def parser():

	import argparse
	parser = argparse.ArgumentParser()

	parser.add_argument("-f","--file",required=True,help="input the bed file")
	parser.add_argument("-g","--group",required=False,help="input the file name")
	parser.add_argument("-o","--out",required=True,help="output file")

	args = parser.parse_args()
	return args

def short_to_middle(file,out,group):
	
	import os
	file_path = os.path.abspath(file)
	content = ""
	
	with open(file_path,"rt") as f:
		
		for lines in f:
			
			lines = lines.rstrip()
			temp = lines.split()

			start = int(temp[1]) + (int(temp[2]) - int(temp[1]))//2
			end = start + 1
			content += temp[0] + "\t" + str(start) + "\t" + str(end) + "\t" + group + "_" + str(start) + "\n"

	write_cmd(content,out) 		
			
def write_cmd(cmd,out):
	
	with open(out,"wb") as w:
		w.write(cmd)	
		
	
if __name__ == '__main__':

	args = parser()
	short_to_middle(args.file,args.out,args.group)
