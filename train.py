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
    x_train = x_train.reshape(x_train.shape + (1,)).astype("float32")
    x_test = x_test.reshape(x_test.shape + (1,)).astype("float32")

    x_train /= 256.0
    x_test /= 256.0

    x_mean = np.mean(x_train, axis=0)

    x_train -= x_mean
    x_test -= x_mean

    nb_classes = np.max(y_train)+1
    y_train = to_categorical(y_train, nb_classes)
    y_test = to_categorical(y_test, nb_classes)

    return (x_train, y_train), (x_test, y_test)

(x_train, y_train), (x_test, y_test) = get_data()


def CreateQModel(shape, nb_classes):
    x = x_in = Input(shape)
    x = Flatten()(x)
    x = QDense(20, kernel_quantizer=quantized_bits(4,0,1),
           bias_quantizer=quantized_bits(4,0,1),
           name="dense_relu")(x)
    x = Activation("relu", name="relu")(x)
    x = QDense(nb_classes, kernel_quantizer=quantized_bits(4,0,1),
           bias_quantizer=quantized_bits(4,0,1),
           name="dense_sofmax")(x)
    x = Activation("softmax", name="softmax")(x)

    model = Model(inputs=x_in, outputs=x)

    return model

qmodel = CreateQModel(x_train.shape[1:], y_train.shape[-1])

from tensorflow.keras.optimizers import Adam

qmodel.compile(
    loss="categorical_crossentropy",
    optimizer=Adam(0.0005),
    metrics=["accuracy"])


qmodel.fit(x_train, y_train, epochs=300, batch_size=128, validation_data=(x_test, y_test), verbose=True)

qmodel.summary()

#print_qstats(qmodel)

##model_save_quantized_weights(qmodel,filename='./Weights/trained_values.hdf5')


while True :
    input_a = input("Enter the index to acess: ")
    image_index = int(input_a)
    plt.figure(figsize=(11,6))
    plt.imshow(x_test[image_index].reshape(28, 28),cmap='Greys')
    plt.show()
    pred = qmodel.predict(x_test[image_index].reshape(1, 28, 28, 1))
    print("Predicted :",pred.argmax())
    print("Label : " ,y_test[image_index].argmax())
    #print(x_test[image_index])