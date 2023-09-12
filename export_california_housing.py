import os
import sklearn
import numpy as np
import pandas as pd
from sklearn.datasets import fetch_california_housing

calihouses_dataset = fetch_california_housing()
x,y = calihouses_dataset.data, calihouses_dataset.target
x,y = np.array(x), np.array(y)
y = y.reshape(y.shape[0],1)

print(x.shape," ",y.shape)

full_data = np.hstack((x,y))
full_data[:,x.shape[1]:] *= 100000
full_data = np.delete(full_data,[5],axis=1)


#add id column
id = []
for m in range(1,full_data.shape[0]+1):
    id.append(m)

id = np.array(id).reshape((20640, 1))
ind_full_data = np.hstack((id,full_data))

print("\n",full_data.shape," ",full_data[0], "\n\n", ind_full_data.shape, " ", ind_full_data[0])



np.savetxt("full_data.txt", ind_full_data, header ="id, income, house_age, house_size, rooms, bedrooms, latitude, longitude, house_price", delimiter=',')
os.system("cp full_data.txt full_data.csv")

#check if data was exported correctly
"""data = pd.read_csv("/home/kali/Desktop/database_manipulation/full_data.txt")
print(data.shape)"""
