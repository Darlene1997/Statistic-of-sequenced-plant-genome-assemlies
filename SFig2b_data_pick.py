import argparse
import pandas as pd

def pick_Fig3b_data(infile, outfile):
    df_all = pd.read_table(infile, sep="\t")  ## Year	Contig	Polishing	Scaffloding	Type
    contig = {"haplotype": {}, "pan-genome": {}, "T2T": {}}
    Polish = {"haplotype": {}, "pan-genome": {}, "T2T": {}}
    Scafflod = {"haplotype": {}, "pan-genome": {}, "T2T": {}}
    for index, row in df_all.iterrows():
        # year = row["Year"]
        type = row["Type"]
        if type == "haplotype":
            if not pd.isnull(row["Contig"]):
                contig_software_list = row["Contig"].split(";")
                for each in contig_software_list:
                    if each in contig["haplotype"]:
                        contig["haplotype"][each] += 1
                    else:
                        contig["haplotype"][each] = 1
            if not pd.isnull(row["Polishing"]):
                Polish_software_list = row["Polishing"].split(";")
                for each in Polish_software_list:
                    if each in Polish["haplotype"]:
                        Polish["haplotype"][each] += 1
                    else:
                        Polish["haplotype"][each] = 1
            if not pd.isnull(row["Scaffloding"]):
                Scafflod_software_list = row["Scaffloding"].split(";")
                for each in Scafflod_software_list:
                    if each in Scafflod["haplotype"]:
                        Scafflod["haplotype"][each] += 1
                    else:
                        Scafflod["haplotype"][each] = 1
        elif type == "pan_genome":
            if not pd.isnull(row["Contig"]):
                contig_software_list = row["Contig"].split(";")
                for each in contig_software_list:
                    if each in contig["pan-genome"]:
                        contig["pan-genome"][each] += 1
                    else:
                        contig["pan-genome"][each] = 1
            if not pd.isnull(row["Polishing"]):
                Polish_software_list = row["Polishing"].split(";")
                for each in Polish_software_list:
                    if each in Polish["pan-genome"]:
                        Polish["pan-genome"][each] += 1
                    else:
                        Polish["pan-genome"][each] = 1
            if not pd.isnull(row["Scaffloding"]):
                Scafflod_software_list = row["Scaffloding"].split(";")
                for each in Scafflod_software_list:
                    if each in Scafflod["pan-genome"]:
                        Scafflod["pan-genome"][each] += 1
                    else:
                        Scafflod["pan-genome"][each] = 1
        elif type == "T2T":
            if not pd.isnull(row["Contig"]):
                contig_software_list = row["Contig"].split(";")
                for each in contig_software_list:
                    if each in contig["T2T"]:
                        contig["T2T"][each] += 1
                    else:
                        contig["T2T"][each] = 1
            if not pd.isnull(row["Polishing"]):
                Polish_software_list = row["Polishing"].split(";")
                for each in Polish_software_list:
                    if each in Polish["T2T"]:
                        Polish["T2T"][each] += 1
                    else:
                        Polish["T2T"][each] = 1
            if not pd.isnull(row["Scaffloding"]):
                Scafflod_software_list = row["Scaffloding"].split(";")
                for each in Scafflod_software_list:
                    if each in Scafflod["T2T"]:
                        Scafflod["T2T"][each] += 1
                    else:
                        Scafflod["T2T"][each] = 1

    o = open(outfile, 'w')
    for type, contigs_s in contig.items():
        for software, count in contigs_s.items():
            o.write("Contig" + "\t" + str(type) + "\t" + str(software) + "\t" + str(count) + "\n")

    for type, Polish_s in Polish.items():
        for software, count in Polish_s.items():
            o.write("Polish" + "\t" + str(type) + "\t" + str(software) + "\t" + str(count) + "\n")

    for type, Scafflod_s in Scafflod.items():
        for software, count in Scafflod_s.items():
            o.write("Scafflod" + "\t" + str(type) + "\t" + str(software) + "\t" + str(count) + "\n")


def choose_topfive(outfile, outfile2):
    df_all = pd.read_table(outfile, sep="\t", header=None, names=["stage", "type", "software", "count"], encoding='latin-1')
    stage_list = df_all.drop_duplicates(subset=['stage'], keep='last', ignore_index=True)['stage'].tolist()
    type_list = df_all.drop_duplicates(subset=['type'], keep='last', ignore_index=True)['type'].tolist()
    for type in type_list:
        for stage in stage_list:
            df_all_select = df_all[(df_all["type"] == type) & (df_all["stage"] == stage)].reset_index(drop=True)
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
