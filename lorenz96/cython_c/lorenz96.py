"""
Program     : lorenz96.py
Author      : Celestine Woodruff
Python port : Brent Woodruff
Date        : 2/10/11
Purpose     : Explore the effect of a small perturbation of the initial data on
              the long term solution of the Lorenz 96 model.
"""

import math
import numpy
from time import clock
from lorenz96_wrapper import solve

J = 5
J = J + 1 # shift to arrays beginning with 1
F = -12
#tfinal = 20
tfinal = 160
h = 1E-5

steps = int(math.ceil(tfinal/h))
u = numpy.zeros( (J, steps+1) )
v = u.copy() # perturbed matrix
# generate inital values between -1 and 1
# rows of u are x's and columns are time steps
#for i = 1:J
for i in range(J):
    u[i][0] = -1 + 2*numpy.random.rand()
    #u[i][1] = 0.1*i
    
    # initial perturbed data
    v[i][0] = u[i][0]*(1 + (-1 + 2*numpy.random.rand())/100)

#u[:][1] = -1 + 2*rand
#v[:][1] = u[:][1]*(1 + (-1 + 2*rand)/100)

t = numpy.zeros( steps+1 )

start_time = clock()
solve(F, h, J, steps, t, u, v)
end_time = clock()
print("tfinal: {}".format(tfinal))
print("h: {}".format(h))
print("Seconds elapsed: {}".format(end_time - start_time))

