#!/usr/bin/env python

import os
os.environ['TF_CPP_MIN_LOG_LEVEL'] = '3'  # or any {'0', '1', '2'}

import numpy as np
import tensorflow as tf
import tensorflow.keras as keras
import matplotlib.pyplot as plt
from keras.models import Sequential, load_model
from keras.layers import Dense, Conv2D, Flatten
from keras import optimizers
import cv2 #resize image
import numpy as np
from random import shuffle
from tqdm import tqdm #progress bar
import sys

model = load_model('./dogness25000pic4ep.h5')

img = cv2.resize(cv2.imread(sys.argv[1], cv2.IMREAD_GRAYSCALE),(50, 50))
img = np.array(img)
img2 = img.reshape(-1, 50, 50, 1)

magic = model.predict(img2)
# print(str(round(magic[0][0]*100,1))+"% a cat and "+str(round(magic[0][1]*100,1))+"% dog")
plt.imshow(img, interpolation='nearest', cmap="gray")
plt.title(str(round(magic[0][0]*100,1))+"% a cat and "+str(round(magic[0][1]*100,1))+"% dog")
plt.show()
