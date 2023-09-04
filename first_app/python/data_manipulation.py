import pandas as pd
import csv

df = pd.read_csv('diseases_precautions_description.csv', delimiter='+', skipinitialspace = True, header = None, skiprows=1)

# Split each row into 5 columns based on the first 5 commas
split_df = df[0].str.split(',', expand=True, n=5)

# Rename the first 4 columns as needed
split_df.columns = ['Disease', 'Precaution_1','Precaution_2','Precaution_3','Precaution_4','Description']

dfDisease = split_df['Disease']
dfDescription = split_df['Description']
dfPrecautions = split_df.drop(['Disease', 'Description'], axis=1)

dfDataset= pd.read_csv('dataset.csv',skipinitialspace = True)
dfDataset.drop_duplicates(inplace = True)
dfDataset.fillna('None', inplace = True)
# Group the DataFrame by the 'Name' column and aggregate unique non-empty values
result_df = dfDataset.groupby('Disease').agg(lambda x: list(set(filter(None, x)))).reset_index()

#index, name, precautions, symptoms, description
for i in range (41):
    list1 = result_df.loc[result_df['Disease'] == dfDisease[i]].iloc[0, 1:]
    list1 = list(list1)
    #symptoms
    cleaned_lists1 = [[item for item in sublist if item != 'None'] for sublist in list1]
    flat_list1 = [item for sublist in cleaned_lists1 if sublist for item in sublist]
    #precautions
    row_as_list = [item for item in dfPrecautions.iloc[i].tolist() if item != '']
    
    nameDisease = '\'' + dfDisease[i] + '\''
    descriptionDisease =  '\'' + dfDescription[i] + '\''
    
    #symptoms
    flat_list1 = [x for i, x in enumerate(flat_list1) if x not in flat_list1[:i]]
    #precautions
    row_as_list = [x for i, x in enumerate(row_as_list) if x not in row_as_list[:i]]
    
    
    #print(i, nameDisease, row_as_list,flat_list1, descriptionDisease)
    print(f"Diseases(index:{i}, name:{nameDisease}, precautions:{row_as_list}, symptoms:{flat_list1}, description:{descriptionDisease}),")






