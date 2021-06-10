#!/usr/bin/python

import argparse
parser = argparse.ArgumentParser()

parser.add_argument("-d", "--dir", required=True, help="input directory")
parser.add_argument("-o", "--out", required=True, help="output file name")

args=parser.parse_args()

def merge(path,out):
        import os
        import pandas as pd
        import numpy as np
        path = os.path.abspath(path)
        files = os.listdir(path)

        df=pd.DataFrame()
        row=[]

        for file in files:

                file_name = file[0:len(file)-4]
                file_name = file_name.split("_")[0]
                if file[-3:] != "txt":
                        next
                else:
                        content = []
                        with open(path + "/" + file,"rb") as f:
                                        for lines in f:
                                                lines = lines.rstrip()
                                                temp = lines.split()
                                                row.append(temp[0].decode('utf-8'))
                                                content.append(int(temp[1]))
                        df[file_name] = content
       
       	df.index = np.unique(row)
        df = pd.DataFrame(df).rename_axis("ID",axis=1)
        df.to_csv(out)


if __name__ == '__main__':
        args=parser.parse_args()
        merge(args.dir,args.out)
