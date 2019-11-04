import cv2
from PIL import Image
import numpy

im = Image.open("/home/alex/Desktop/Master/ProiectPML/Dog-Cat-Classifier/Data/Train_Data/cat/cat.0.jpg")
np_im = numpy.array(im)
print(np_im.shape)
