import six
import numpy as np
import tensorflow.compat.v2 as tf
import matplotlib.pyplot as plt

from tensorflow.keras.layers import *
from tensorflow.keras.models import Model
from tensorflow.keras.datasets import mnist
from tensorflow.keras.utils import to_categorical

from qkeras import *
from qkeras.utils import *

def get_data():
    (x_train, y_train), (x_test, y_test) = mnist.load_data()
    x_train = x_train.reshape(x_train.shape + (1,)).astype("float16")
    x_test = x_test.reshape(x_test.shape + (1,)).astype("float16")

    x_train /= 256.0
    x_test /= 256.0

    x_mean = np.mean(x_train, axis=0)

    x_train -= x_mean
    x_test -= x_mean

    nb_classes = np.max(y_train)+1
    y_train = to_categorical(y_train, nb_classes)
    y_test = to_categorical(y_test, nb_classes)

    return (x_train.astype("float16"), y_train.astype("float16")), (x_test.astype("float16"), y_test.astype("float16"))

(x_train, y_train), (x_test, y_test) = get_data()

qmodel = load_qmodel(filepath='./Weights/saved_model.h5')
qmodel.summary()

while True :
    input_a = input("Enter the index to acess: ")
    image_index = int(input_a)
    pred = qmodel.predict(x_test[image_index].reshape(1, 28, 28, 1))

    test = x_test[image_index,0,0,0]

    #print("Type :",type(x_test))
    #for i in x_test[image_index]:
        #for x in x_test[image_index]:
           # print(x_test[image_index])
      #  print('\n')

    for i in range(28):
        for x in range(28):
            print(",to_float(%.5f)" % x_test[image_index,i,x], end='')
        print("),(")
    #print(x_test[image_index,10,2])
    #print(f'{x_test[image_index]}')
    print("Predicted :",pred.argmax())
    print("Label : " ,y_test[image_index].argmax())
    #print(f'Test :{((x_test[image_index,0]))}')
    print("Tipo teste 2: ", type(test))

    plt.imshow(x_test[image_index].reshape(28, 28),cmap='Greys')
    plt.show()


