import pandas as pd

df = pd.read_csv("DataCoSupplyChainDataset.csv", encoding="latin1")


print("Number of columns:", len(df.columns))
print("\nColumn names:")
print(df.columns.tolist())


print("\nFirst five rows:")
print(df)


#to check the missing and duplicate values
print("\nColumns with missing values:")
missing = df.isnull().sum()
#Only show me columns where the number of missing values is greater than 0
print(missing[missing > 0])     

print("\nDuplicate Values:")
print(df.duplicated().sum())

print("\nData Types:")
print(df.dtypes)
