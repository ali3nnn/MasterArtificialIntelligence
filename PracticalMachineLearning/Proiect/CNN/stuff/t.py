#!/usr/bin/env python
# coding: utf-8

import cv2 #resize image
import numpy as np
import os #for directories
from random import shuffle
from tqdm import tqdm #progress bar

train_data = np.load('train_data.npy')

print(train_data.shape)
