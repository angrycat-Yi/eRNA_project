#!/usr/bin/python

import argparse
import os

def getparser():
	parser = argparse.ArgumentParser()
	parser.add_argument("-b", "--bed", required = True, help="input the bed file")
	parser.add_argument("-s", "--size", required = True, type=int, help="extending size around middle loci")
	parser.add_argument("-o", "--out", required = True, help="output the bed file")
	args = parser.parse_args()
	return args


def change_bed(bed,size,out):

	import re
	
	lst = []
	result = ""

	try: 	
		with open(bed,"r") as f:
			for lines in f:
				lines = lines.rstrip()
				lst = lines.split()
				
				if re.match('[A-Za-z]+',lst[1]) or re.match('[A-Za-z]+',lst[2]):
					next
				else:	
					len = int(lst[2]) - int(lst[1])
					start = int(lst[1]) + len//2 - size
					end = int(lst[1]) + len//2 + size
					result += lst[0] + "\t" + str(start) + "\t" + str(end) + "\t" + lst[3] + "\n"
	
		with open(out,"wb") as f:
			f.write(result)

	except IOError:
		print("Cannot find the file")	


if __name__ == "__main__":
	
	args = getparser()
	change_bed(args.bed,args.size,args.out)	
