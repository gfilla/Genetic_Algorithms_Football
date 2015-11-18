import pandas as pd

tables = []
for i in range(0,1000,40):
    u = 'http://games.espn.go.com/ffl/tools/projections?&startIndex='+str(i)
    raw_table = pd.io.html.read_html(u)[0]
    clean_data = raw_table.iloc[2:,0:14]
    tables.append(clean_data)
full_df = pd.concat(tables)

full_df.fillna(0,inplace = True)
full_df.replace(['\xa0'],[' '],inplace = True) 

full_df.to_csv('11102015espn.csv', encoding= 'utf-8')