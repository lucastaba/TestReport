import pandas as pd
import os

dirname = os.path.dirname(__file__)

df = pd.read_json (dirname +'jsonOutput.txt')

df.to_csv (dirname +'jsonOutput.csv', index = None)