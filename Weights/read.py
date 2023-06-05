import h5py
import numpy as np
data = h5py.File("trained_values.hdf5", "r") 

print(list(data.keys()))
base_items = list(data.items())
print("Items in the base directory: ", base_items)
print("-------------------------------------------------------")

def print_sofmax():
    print("-------------- Sofmax ------------------------------------------------------")

    g1 = data.get('dense_sofmax')
    g1_items = list(g1.items())
    print("Items in group 1: ", g1_items) 

    g2 = data.get('dense_sofmax/dense_sofmax')
    g2_items = list(g2.items())
    print("Items in group 2: ", g2_items)


    bias = np.array(g2.get('bias:0'))
    print("Bias : ",bias)

    kernel = np.array(g2.get('kernel:0'))
    print("Kernel : ", kernel)

def print_denserelu():
    print("-------------- Dense ReLU ---------------------------------------------------")

    g1 = data.get('dense_relu')
    g1_items = list(g1.items())
    print("Items in group 1: ", g1_items)

    g2 = data.get('dense_relu/dense_relu')
    g2_items = list(g2.items())
    print("Items in group 2: ", g2_items) 

    bias = np.array(g2.get('bias:0'))
    print("Bias : ",bias)

    kernel = np.array(g2.get('kernel:0'))
    print("Kernel : ", kernel)

print_sofmax()
print_denserelu()
