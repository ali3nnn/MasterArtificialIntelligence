from skimage.transform import resize
from skimage.color import rgb2gray
import numpy as np
from skimage import io
import matplotlib.pyplot as plt
from sklearn.metrics import confusion_matrix

# Get the first 100 images of cat and dog to train
x = []
y = []
for i in range(1,101):
    cat = rgb2gray(resize(io.imread('/home/alex/Desktop/Master/ProiectPML/Dog-Cat-Classifier/Data/Train_Data/cat/cat.{}.jpg'.format(i)), (200,200)))
    x.append(cat.flatten())
    y.append(0)

for i in range(1,101):
    dog = rgb2gray(resize(io.imread('/home/alex/Desktop/Master/ProiectPML/Dog-Cat-Classifier/Data/Train_Data/dog/dog.{}.jpg'.format(i)), (200,200)))
    x.append(dog.flatten())
    y.append(1)

x, y = np.asarray(x), np.asarray(y)

train_images = x;
train_labels = y;

print('train_images shape: ', train_images.shape, '  train_labels shape: ', train_labels.shape)

# Get the first 11 images of cat and dog to test
x_test = []
y_test = []
for i in range(102,113):
    cat = rgb2gray(resize(io.imread('/home/alex/Desktop/Master/ProiectPML/Dog-Cat-Classifier/Data/Train_Data/cat/cat.{}.jpg'.format(i)), (200,200)))
    x_test.append(cat.flatten())
    y_test.append(0)

for i in range(102,113):
    dog = rgb2gray(resize(io.imread('/home/alex/Desktop/Master/ProiectPML/Dog-Cat-Classifier/Data/Train_Data/dog/dog.{}.jpg'.format(i)), (200,200)))
    x_test.append(dog.flatten())
    y_test.append(1)

x_test, y_test = np.asarray(x_test), np.asarray(y_test)

test_images = x_test;
test_labels = y_test;

print('test_images shape: ', test_images.shape, '  test_labels shape: ', test_labels.shape)

class Knn_classifier:

    def __init__(self, train_images, train_labels):
        self.train_images = train_images
        self.train_labels = train_labels

    # a. Write the classify_image(self, test_image, num_neighbors=3, metric='l2') function in order to classify 'test_image'
    # example using the k-NN method with 'num_neighbors' neighbors and 'metric' distance.
    def classify_image(self, test_image, num_neighbors=3, metric='l2'):
        # write your code here
        if metric == 'l2':
            distance = np.sqrt(np.sum(((self.train_images - test_image) ** 2), axis=1))
        else:
            distance = np.sqrt(abs((self.train_images - test_image ** 2)), axis=1)

        sorted_idx = np.argsort(distance)
        nearest_idx = sorted_idx[:num_neighbors]
        nearest_labels = self.train_labels[nearest_idx]
        histc = np.bincount(nearest_labels)
        return np.argmax(histc)

    # b. Write the classify_images(self, test_images, num_neighbors=3, metric='l2') function in order to predict the labels of
    # the test images.
    def classify_images(self, test_images, num_neighbors, metric='l2'):
        # write your code here
        num_test_example = test_images.shape[0]
        predictions = []
        for i in range(num_test_example):
            pred_label = self.classify_image(test_images[i],num_neighbors, metric)
            predictions.append(pred_label)
        return np.array(predictions)
        pass

    # c. Define a function to compute the accurracy score given the predicted labels and the ground-truth labels.
    def accuracy_score(self, y_true, y_pred):
        # write your code here
        return np.mean(y_true == y_pred).mean()
        pass

num_neighbors = 1

knn_classifier = Knn_classifier(train_images, train_labels)
predicted_labels = knn_classifier.classify_images(test_images, num_neighbors)
print(knn_classifier.accuracy_score(test_labels, predicted_labels))

confusion_matrix(test_labels, predicted_labels)
