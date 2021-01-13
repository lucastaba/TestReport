import pandas as pd
import os

dirname = os.path.dirname(__file__)

with open(dirname +'jsonOutput.txt', 'r') as file:
    df = file.read()
tmp01 = df.split("idapp=", 1)
tmp02 = str(tmp01[1]).split("&")

df = pd.DataFrame(tmp02)
df.to_csv (dirname +'jsonOutput.csv', index =False)