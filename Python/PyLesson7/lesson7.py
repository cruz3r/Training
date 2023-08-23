
import os
import time
import random
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt


# Clear the screen
def cls():
    os.system('cls')

cls()

# Speed difference from the random module and numpy module
%timeit -r10 -n1000 [np.random.randint(0, 100, 100)]
%timeit -r10 -n1000 [random.sample(range(0, 100), 100)]

#Because this is so fast we are running it 10 times and looping it 1000 times

'''
Pandas Series and Dataframe
Series is like a key value pair
Dataframe is more like a dictionary 
'''

# Series Object
my_numpy_array = np.random.randint(0, 100, 3)
print(my_numpy_array)
print(type(my_numpy_array))

my_series = pd.Series(my_numpy_array)
my_series
print(type(my_series))

my_series2 = pd.Series(my_numpy_array, index=["first","second","third"])
print(my_series2)
print(type(my_series2))

# DataFrame Object
array_2d = np.random.rand(3, 2)
array_2d[0,1]
df = pd.DataFrame(array_2d)
print(df)
print(type(df))
print(df[0])
print(df.columns)
df.columns = ["Cola","Colb"]
df["Cola"]
df["Colb"]

'''
Using Pandas to read different file formats

What are some of the common file formats we use?
Text - CSV, JSON, HTML, etc.
Binary - you have to know what your Binary Format is in order to map it out
Relational DataBases - SQL, NoSql, etc.  
'''

# Importing a CSV into a Datafram Variable with Pandas
my_csv = pd.read_csv("proc2.csv", nrows= 2)
print(my_csv)
print(type(my_csv))

# Here I am adding the index column from an existing unique id column. 
my_csv2 = pd.read_csv(
    "proc2.csv", 
    nrows=5, 
    index_col="Id"
    )
print(my_csv2)
print(type(my_csv2))

# Read a Row .loc [*ID Number] or by the index_col [*"Id"]
my_csv_rowindexcount = pd.read_csv(
    "proc2.csv", 
    index_col="Id",
    )

print(type(my_csv_rowindexcount))
#my_csv_rowindexcount
print(my_csv_rowindexcount.loc[3048]) # Shows a row with all columns
print("-" * 100 ) 
print(my_csv_rowindexcount.loc[3048].at['Path']) # Shows an individual cell using index and a col
print("-" * 100 ) 
print(my_csv_rowindexcount['Name']) 
print("-" * 100 ) 
print(my_csv_rowindexcount.dropna()['Name']) 

# Read Excel
my_missingupd = pd.read_excel("file:/Temp/missing_updates.xlsx", sheet_name="Raw")
print(my_missingupd.loc[0])

# When can this be useful to you?
# Read HTML
st = pd.read_html('https://simple.wikipedia.org/wiki/List_of_U.S._states')[0]
print(type(st))

sttaxrates =pd.read_html('https://taxfoundation.org/2023-sales-taxes/')[0]
print(sttaxrates.columns)
print(sttaxrates.State.count())
print(sttaxrates[sttaxrates['State'] == 'Texas'])
print(sttaxrates.iloc[0])
print(sttaxrates.iloc[-1])