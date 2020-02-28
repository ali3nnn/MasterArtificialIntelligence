#!/usr/bin/env python
# coding: utf-8

# In[59]:


from sklearn import datasets  
import matplotlib.pyplot as plt  
# import pandas as pd  
#importing the necessary packages  
from sklearn.model_selection import train_test_split  
from sklearn.naive_bayes import GaussianNB  
from sklearn import metrics
import numpy as np
import cv2
import sys


# In[13]:


train_data = np.load('train_data.npy')


# In[14]:


rangeImg = 25000

labels_aux = np.zeros([rangeImg,1], dtype='uint8')

for i in range(rangeImg):
    labels_aux[i] = np.argmax(train_data[i][1])

labels = labels_aux.flatten()
# print(labels[:20])


# In[15]:


images = np.zeros([rangeImg,2500], dtype='uint8')
# print(images)
for i in range(rangeImg):
    images[i] = train_data[i][0].flatten()


# In[16]:


xTrain, xTest, yTrain, yTest = train_test_split(images, labels, test_size = 0.2, random_state = 1)


# In[18]:


NB = GaussianNB()  
NB.fit(xTrain, yTrain)   


# In[43]:


img = cv2.resize(cv2.imread(sys.argv[1], cv2.IMREAD_GRAYSCALE),(50, 50))
# img = cv2.resize(cv2.imread('./cat.jpg', cv2.IMREAD_GRAYSCALE),(50, 50))
img = np.array(img).flatten()
if NB.predict([img])==0:
    print("Cat")
else: 
    print("Dog")


# In[68]:


# print(score(xTest,yTest))
predicts = NB.predict(xTest)


# In[67]:


print("Loss: %f" % metrics.log_loss(yTest, predicts))
print(metrics.classification_report(yTest, predicts))


# In[54]:


# print(predicts[:30])
# print(yTest[:30])

