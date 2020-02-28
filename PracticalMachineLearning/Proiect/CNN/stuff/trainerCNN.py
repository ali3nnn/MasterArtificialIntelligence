#!/usr/bin/env python
# coding: utf-8

import cv2 #resize image
import numpy as np
import os #for directories
from random import shuffle
from tqdm import tqdm #progress bar

TRAIN_DIR = './Data/Kaggle/train'
IMG_SIZE = 50
LR = 1e-3

def label_img(img):
    word_label = img.split('.')[0]
    if word_label == 'cat': return [1,0]
    elif word_label == 'dog': return [0,1]

training_data = []
def create_train_data():
    for img in tqdm(os.listdir(TRAIN_DIR)):
        label = label_img(img)
        path = os.path.join(TRAIN_DIR,img)
        img = cv2.resize(cv2.imread(path, cv2.IMREAD_GRAYSCALE),(IMG_SIZE, IMG_SIZE))
        training_data.append([np.array(img), np.array(label)])
    shuffle(training_data)
    np.save('train_data.npy',training_data)
    return training_data

# train_data = create_train_data()

train_data = np.load('train_data.npy')

import tensorflow as tf
import tensorflow.keras as keras
import matplotlib.pyplot as plt
from keras.models import Sequential, load_model
from keras.layers import Dense, Conv2D, Flatten
from keras import optimizers

#create model
model = Sequential()
#add model layers
model.add(Conv2D(64, kernel_size=3, activation='relu', input_shape=(IMG_SIZE,IMG_SIZE,1)))
model.add(Conv2D(64, kernel_size=3, activation='relu'))
model.add(Conv2D(64, kernel_size=3, activation='relu'))
model.add(Conv2D(64, kernel_size=3, activation='relu'))
model.add(Conv2D(64, kernel_size=3, activation='relu'))
model.add(Flatten())
model.add(Dense(2, activation='softmax'))

#sgd = optimizers.SGD(lr=LR, decay=1e-6, momentum=0.9, nesterov=True)
model.compile(loss='categorical_crossentropy', optimizer='Adam', metrics=['accuracy'])

train = train_data[:-500]
test = train_data[-500:]

X = np.array([i[0] for i in train]).reshape(-1, IMG_SIZE, IMG_SIZE, 1) # the image data in train
Y = np.array([i[1] for i in train])

test_x = np.array([i[0] for i in test]).reshape(-1, IMG_SIZE, IMG_SIZE, 1)
test_y = np.array([i[1] for i in test])

#train the model
model.fit(X, Y, validation_data=(test_x, test_y), epochs=4, use_multiprocessing=True)

model.save("dogness25000pic4ep.h5")
