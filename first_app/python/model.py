import pandas as pd
import csv
import numpy as np
import tensorflow as tf
from sklearn.metrics import accuracy_score
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import OneHotEncoder, StandardScaler, LabelEncoder

data = pd.read_csv('dataset.csv', skipinitialspace=True)
disease_file = pd.read_csv('diseases_precautions.csv', skipinitialspace=True)
severity_file = pd.read_csv('Symptom-severity.csv', skipinitialspace=True)

df = pd.DataFrame(data)
df.drop_duplicates(inplace=True)
df.fillna(0, inplace=True)

symptoms_unique = severity_file['Symptom']
symptoms_unique = symptoms_unique.tolist()

index = -1
for i in symptoms_unique:
    index +=1 
    print(f"Symptoms(index:{index}, name:'{i}'),")


#uhh for encoding X
new_data = pd.DataFrame({'Disease' : df['Disease']})
for symptom in symptoms_unique:
    new_data[symptom] = df.apply(lambda row: 1 if symptom in row.values else 0, axis=1)

y = new_data['Disease']
X = new_data.drop('Disease', axis=1)

#for encoding y
disease_unique = disease_file.iloc[:, 0]
print(disease_unique.to_list())

disease_to_int_mapping = {disease: idx for idx, disease in enumerate(disease_unique)}
y_labeled = y.map(disease_to_int_mapping)


# pd.set_option('display.max_columns', None)
# pd.set_option('display.max_rows', None)
# np.set_printoptions(threshold=np.inf)

X_train, X_test, y_train, y_test = train_test_split(X, y_labeled, test_size=0.2, random_state=42)

print(X_test.iloc[0].tolist())

model = tf.keras.Sequential([
    tf.keras.layers.Input(shape=(X.shape[1],)),
    tf.keras.layers.Dense(128, activation='relu'),
    tf.keras.layers.Dense(64, activation='relu'),
    # tf.keras.layers.Dense(len(disease_unique), activation='softmax')
    tf.keras.layers.Dense(41, activation='softmax')
])

model.compile(optimizer='adam', loss='sparse_categorical_crossentropy', metrics=['accuracy'])
model.fit(X_train, y_train, epochs=15, batch_size=32, verbose=2)


just_testing = [X_test.iloc[0].tolist()]
print(just_testing)
prediction = model.predict(just_testing)
print(prediction)

max = 0
max_index = -99
index = -1
for i in prediction[0]:
    index +=1
    if i > max:
        max_index = index
        max = i

print(max_index,max)

tflite_converter = tf.lite.TFLiteConverter.from_keras_model(model)
tflite_model = tflite_converter.convert()
tflite_model_path = 'knn_model.tflite'

with open(tflite_model_path, 'wb') as f:
    f.write(tflite_model)