import h5py
import numpy as np
import sys

data = h5py.File("trained_values.hdf5", "r") 
base_items = list(data.items())

g1 = data.get('dense_sofmax')
g1_items = list(g1.items())
g2 = data.get('dense_sofmax/dense_sofmax')
g2_items = list(g2.items())

bias = np.array(g2.get('bias:0'))

np.savetxt("softmax_bias.txt", bias, delimiter=",", fmt="%10.3f",newline=",",header='')

with open('softmax_bias.txt', 'rb+') as original:
    original.seek(-1, 2)
    original.truncate()
with open('softmax_bias.txt', 'a') as f: f.write(")")
with open('softmax_bias.txt', 'r') as original: data1 = original.read()
with open('softmax_bias.txt', 'w') as modified: modified.write("(" + data1)

kernel = np.array(g2.get('kernel:0'))

np.savetxt("softmax_weights.txt", kernel, delimiter=",", fmt="%10.3f",newline="),(",header='')

with open('softmax_weights.txt', 'rb+') as original:
    original.seek(-2, 2)
    original.truncate()
with open('softmax_weights.txt', 'a') as f: f.write(")")
with open('softmax_weights.txt', 'r') as original: data2 = original.read()
with open('softmax_weights.txt', 'w') as modified: modified.write("((" + data2)

g1 = data.get('dense_relu')
g1_items = list(g1.items())
g2 = data.get('dense_relu/dense_relu')
g2_items = list(g2.items())

bias = np.array(g2.get('bias:0'))

np.savetxt("relu_bias.txt", bias, delimiter=",", fmt="%10.3f",newline=",",header='')

with open('relu_bias.txt', 'rb+') as original:
    original.seek(-1, 2)
    original.truncate()
with open('relu_bias.txt', 'a') as f: f.write(")")
with open('relu_bias.txt', 'r') as original: data3 = original.read()
with open('relu_bias.txt', 'w') as modified: modified.write("(" + data3)


kernel = np.array(g2.get('kernel:0'))

np.savetxt("relu_weights.txt", kernel, delimiter=",", fmt="%10.3f",newline="),(",header='')

with open('relu_weights.txt', 'rb+') as original:
    original.seek(-2, 2)
    original.truncate()
with open('relu_weights.txt', 'a') as f: f.write(")")
with open('relu_weights.txt', 'r') as original: data4 = original.read()
with open('relu_weights.txt', 'w') as modified: modified.write("((" + data4)
        
print("File exported")


