import argparse
import os
import re
import pandas as pd

def pick_Fig3b_data(infile, outfile):
    df_all = pd.read_table(infile, sep="\t")  ## Year	Contig	Polishing	Scaffloding
    contig = {"2000-2010": {}, "2011-2015": {}, "2016-2020": {}, "2021-2023": {}}
    Polish = {"2000-2010": {}, "2011-2015": {}, "2016-2020": {}, "2021-2023": {}}
    Scafflod = {"2000-2010": {}, "2011-2015": {}, "2016-2020": {}, "2021-2023": {}}
    for index, row in df_all.iterrows():
        print(index)
        year = int(row["Year"].split("/")[0])
        if (year >= 2000) & (year <= 2010):
            if not pd.isnull(row["Contig"]):
                contig_software_list = row["Contig"].split(";")
                for each in contig_software_list:
                    if each in contig["2000-2010"]:
                        contig["2000-2010"][each] += 1
                    else:
                        contig["2000-2010"][each] = 1
            if not pd.isnull(row["Polishing"]):
                Polish_software_list = row["Polishing"].split(";")
                for each in Polish_software_list:
                    if each in Polish["2000-2010"]:
                        Polish["2000-2010"][each] += 1
                    else:
                        Polish["2000-2010"][each] = 1
            if not pd.isnull(row["Scaffloding"]):
                Scafflod_software_list = row["Scaffloding"].split(";")
                for each in Scafflod_software_list:
                    if each in Scafflod["2000-2010"]:
                        Scafflod["2000-2010"][each] += 1
                    else:
                        Scafflod["2000-2010"][each] = 1
        elif (year >= 2011) & (year <= 2015):
            if not pd.isnull(row["Contig"]):
                contig_software_list = row["Contig"].split(";")
                for each in contig_software_list:
                    if each in contig["2011-2015"]:
                        contig["2011-2015"][each] += 1
                    else:
                        contig["2011-2015"][each] = 1
            if not pd.isnull(row["Polishing"]):
                Polish_software_list = row["Polishing"].split(";")
                for each in Polish_software_list:
                    if each in Polish["2011-2015"]:
                        Polish["2011-2015"][each] += 1
                    else:
                        Polish["2011-2015"][each] = 1
            if not pd.isnull(row["Scaffloding"]):
                Scafflod_software_list = row["Scaffloding"].split(";")
                for each in Scafflod_software_list:
                    if each in Scafflod["2011-2015"]:
                        Scafflod["2011-2015"][each] += 1
                    else:
                        Scafflod["2011-2015"][each] = 1
        elif (year >= 2016) & (year <= 2020):
            if not pd.isnull(row["Contig"]):
                contig_software_list = row["Contig"].split(";")
                for each in contig_software_list:
                    if each in contig["2016-2020"]:
                        contig["2016-2020"][each] += 1
                    else:
                        contig["2016-2020"][each] = 1
            if not pd.isnull(row["Polishing"]):
                Polish_software_list = row["Polishing"].split(";")
                for each in Polish_software_list:
                    if each in Polish["2016-2020"]:
                        Polish["2016-2020"][each] += 1
                    else:
                        Polish["2016-2020"][each] = 1
            if not pd.isnull(row["Scaffloding"]):
                Scafflod_software_list = row["Scaffloding"].split(";")
                for each in Scafflod_software_list:
                    if each in Scafflod["2016-2020"]:
                        Scafflod["2016-2020"][each] += 1
                    else:
                        Scafflod["2016-2020"][each] = 1
        else:
            if not pd.isnull(row["Contig"]):
                contig_software_list = row["Contig"].split(";")
                for each in contig_software_list:
                    if each in contig["2021-2023"]:
                        contig["2021-2023"][each] += 1
                    else:
                        contig["2021-2023"][each] = 1
            if not pd.isnull(row["Polishing"]):
                Polish_software_list = row["Polishing"].split(";")
                for each in Polish_software_list:
                    if each in Polish["2021-2023"]:
                        Polish["2021-2023"][each] += 1
                    else:
                        Polish["2021-2023"][each] = 1
            if not pd.isnull(row["Scaffloding"]):
                Scafflod_software_list = row["Scaffloding"].split(";")
                for each in Scafflod_software_list:
                    if each in Scafflod["2021-2023"]:
                        Scafflod["2021-2023"][each] += 1
                    else:
                        Scafflod["2021-2023"][each] = 1
    o = open(outfile, 'w')
    for year, contigs_s in contig.items():
        for software, count in contigs_s.items():
            o.write("Contig" + "\t" + str(year) + "\t" + str(software) + "\t" + str(count) + "\n")
    for year, Polish_s in Polish.items():
        for software, count in Polish_s.items():
            o.write("Polish" + "\t" + str(year) + "\t" + str(software) + "\t" + str(count) + "\n")
    for year, Scafflod_s in Scafflod.items():
        for software, count in Scafflod_s.items():
            o.write("Scafflod" + "\t" + str(year) + "\t" + str(software) + "\t" + str(count) + "\n")

def choose_topfive(outfile, outfile2):
    df_all = pd.read_table(outfile, sep="\t", header=None, names=["stage", "year", "software", "count"], encoding='latin-1')
    stage_list = df_all.drop_duplicates(subset=['stage'], keep='last', ignore_index=True)['stage'].tolist()
    year_list = df_all.drop_duplicates(subset=['year'], keep='last', ignore_index=True)['year'].tolist()
    for year in year_list:
        for stage in stage_list:
            df_all_select = df_all[(df_all["year"] == year) & (df_all["stage"] == stage)].reset_index(drop=True)
            df_sort_s = df_all_select.sort_values(by="count", ascending=False).reset_index(drop=True)
            df_pick = df_sort_s.iloc[0:5, :]
            df_pick.to_csv(outfile2, sep="\t", index=False, header=False, mode='a')

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('-i', '--input', help='TRASH_centromere', dest='input', required=True)
    parser.add_argument('-o', '--output', help='region_choose', dest='output', required=True)
    parser.add_argument('-o2', '--output2', help='region_choose2', dest='output2', required=True)
    args = parser.parse_args()
    pick_Fig3b_data(args.input, args.output)
    choose_topfive(args.output, args.output2)


if __name__ == '__main__':
    main()
