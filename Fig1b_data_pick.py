import argparse
import os
import re
import pandas as pd

def select_20y_3y(infile, outfile):
    df_select = pd.read_table(infile, sep="\t")  ## Family	Year
    year_dict = {"20y": {}, "3y": {}}
    o = open(outfile, 'w')
    for index, row in df_select.iterrows():
        year = row["Year"]
        family = row["Family"]
        if year == "20y":
            if family in year_dict["20y"]:
                year_dict["20y"][family] += 1
            else:
                year_dict["20y"][family] = 1
        else:
            if family in year_dict["3y"]:
                year_dict["3y"][family] += 1
            else:
                year_dict["3y"][family] = 1
    for year, famil in year_dict.items():
        for fam, count in famil.items():
            o.write(str(year) + "\t" + str(fam) + "\t" + str(count) + "\n")

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('-i', '--input', help='infile', dest='input', required=True)
    parser.add_argument('-o', '--output', help='outfile', dest='output', required=True)
    args = parser.parse_args()
    select_20y_3y(args.input, args.output)

if __name__ == '__main__':
    main()
