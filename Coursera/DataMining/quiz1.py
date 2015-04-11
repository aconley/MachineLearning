import numpy as np

beta = 0.7
m = np.matrix([[1/3., 1, 1], [1/3, 0, 1], [1/3, 0, 1]])
a = beta * m + (1 - beta) * np.ones((3, 3))/3.0
r = (np.matrix([1, 1, 1.])/3).transpose()
