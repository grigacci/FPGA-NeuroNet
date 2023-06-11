import six
import numpy as np
import tensorflow.compat.v2 as tf

from tensorflow.keras.layers import *
from tensorflow.keras.models import Model
from tensorflow.keras.datasets import mnist
from tensorflow.keras.utils import to_categorical
from tensorflow.keras.models import save_model

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


def CreateQModel(shape, nb_classes):
    x = x_in = Input(shape)
    x = Flatten()(x)
    x = QDense(20, kernel_quantizer=quantized_bits(4,0,1),
           bias_quantizer=quantized_bits(4,0,1),
           name="dense_relu")(x)
    x = Activation("relu", name="relu")(x)
    x = QDense(nb_classes, kernel_quantizer=quantized_bits(4,0,1),
           bias_quantizer=quantized_bits(4,0,1),
           name="dense_softmax")(x)
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

save_model(qmodel,'./Weights/saved_model.h5')
model_save_quantized_weights(qmodel,filename='./Weights/trained_values.hdf5')

