import pandas as pd
import argparse
from pyecharts.charts import Sankey
from pyecharts import options as opts

def get_format_for_sankey(infile, outfile):
    df_all = pd.read_table(infile, sep='\t')  # Publication,Country,Year
    df_all["Year"] = df_all["Year"].astype(int)
    Country_list = df_all.drop_duplicates(subset=["Country"], keep='last')['Country'].tolist()
    Publication_list = df_all.drop_duplicates(subset=["Publication"], keep='last')['Publication'].tolist()
    Year_list = df_all.drop_duplicates(subset=["Year"], keep='last')['Year'].tolist()
    o = open(outfile, 'w')

    for con in Country_list:
        for y in Year_list:
            other_num = 0
            for pub in Publication_list:
                df_select = df_all[(df_all["Publication"] == str(pub)) & (df_all["Country"] == str(con)) & (df_all["Year"] == int(y))].reset_index(drop=True)
                num = df_select.shape[0]
                if num >= 10:
                    o.write(str(con) + ",Year" + str(y) + "," + str(pub) + "," + str(int(num)) + "\n")
                else:
                    other_num += num
            if other_num > 50:
                o.write(str(con) + ",Year" + str(y) + ",other_publication," + str(int(other_num)) + "\n")


def sankey_plot_used(outfile):
    dic_color = {"China": "#6DAB30", "USA": "#3BA738", "Japan": "#B1D79C", "Germany": "#BFE06F", "Australia": "#6DAB30",
                 "France": "#3BA738", "Austria": "#B1D79C", "Israel": "#BFE06F", "UK": "#6DAB30", "Philippines": "#6DAB30",
                 "Russia": "#3BA738", "Canada": "#B1D79C", "India": "#BFE06F",
                 "Year2023": "#F2AE2C", "Year2022": "#D0AF62", "Year2021": "#ffe38c", "Year2020": "#F2AE2C", "Year2019": "#D0AF62",
                 "Year2018": "#F2AE2C", "Year2017": "#D0AF62", "Year2016": "#ffe38c", "Year2014": "#F2AE2C", "Year2013": "#ffe38c",

                 }
    df_all = pd.read_table(outfile, sep=',', header=None, names=["Country",  "Year", "Publication", "num"]) #Country,Publication,Year,num
    # df_all = df_all.sort_values(by='num').reset_index(drop=True)
    nodes = []
    for i in range(3):
        values = df_all.iloc[:, i].unique()
        for value in values:
            dic = {}
            dic['name'] = value
            if value in dic_color:
                dic['itemStyle'] = {'color': dic_color[value]}
            nodes.append(dic)
    print(nodes)
    first = df_all.groupby(["Country", "Year"])["num"].sum().reset_index()
    second = df_all.iloc[:, 1:]
    first.columns = ["source", "target", "value"]
    second.columns = ["source", "target", "value"]
    result = pd.concat([second, first])
    print(result.head(10))
    links = []
    for i in result.values:
        dic2 = {}
        dic2['source'] = i[0]
        dic2['target'] = i[1]
        dic2['value'] = i[2]
        links.append(dic2)
    print(links)
    pic = (Sankey()
           # .set_colors(colors)
           .add('', nodes, links,
             itemstyle_opts=opts.ItemStyleOpts(border_width=1, border_color="black"),
             linestyle_opt=opts.LineStyleOpts(opacity=0.2, color="source", curve=0.5),
             # label_opts=opts.LabelOpts(position="right", font_size=10, font_family="Arial"),
             label_opts=opts.LabelOpts(is_show=True),
             node_gap=5,
             levels=[opts.SankeyLevelsOpts(depth=2, itemstyle_opts=opts.ItemStyleOpts(color="#4E84C3"),
                                           linestyle_opts=opts.LineStyleOpts(color="source", opacity=0.2, curve=0.5))]
             #orient="vertical"
             )
    )
    pic.render('test.html')

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('-i', '--input', help='prefix', dest='input', required=True)
    parser.add_argument('-o', '--output', help='output', dest='output', required=True)
    args = parser.parse_args()
    # get_format_for_sankey(args.input, args.output)
    sankey_plot_used(args.output)

if __name__ == '__main__':
    main()