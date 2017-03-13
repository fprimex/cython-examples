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

J = 5
J = J + 1 # shift to arrays beginning with 1
F = -12
tfinal = 160
#tfinal = 20 # good test value
h = 1E-5

steps = int(math.ceil(tfinal/h))
u = numpy.zeros( (J, steps+1) )
v = u.copy() # perturbed matrix
# generate inital values between -1 and 1
# rows of u are x's and columns are time steps
for i in xrange(J):
    u[i, 0] = -1 + 2*numpy.random.rand()
    
    # initial perturbed data
    v[i, 0] = u[i, 0]*(1 + (-1 + 2*numpy.random.rand())/100)

t = numpy.zeros( steps+1 )

# perform 4th order Runge-Kutta to iterate in time
start_time = clock()
for i in xrange(steps):
    t[i+1] = i*h

    # diagnostic output if desired
    #if i%10000 == 0: print t[i+1]

    # iterate this step for the special cases first
    # j = 0
    f1 = (u[1, i] - u[J-2, i])*u[J-1, i] - u[0, i] + F
    f2 = (u[1, i] - u[J-2, i])*(u[J-1, i] + h/2*f1) - u[0, i] - h/2*f1 + F
    f3 = (u[1, i] - u[J-2, i])*(u[J-1, i] + h/2*f2) - u[0, i] - h/2*f2 + F
    f4 = (u[1, i] - u[J-2, i])*(u[J-1, i] + h*f3) - u[0, i] - h*f3 + F
    u[0, i+1] = u[0, i] + h/6*(f1 + 2*f2 + 2*f3 + f4)

    # j = 1
    f1 = (u[2, i] - u[J-1, i])*u[0, i] - u[1, i] + F
    f2 = (u[2, i] - u[J-1, i])*(u[0, i] + h/2*f1) - u[1, i] - h/2*f1 + F
    f3 = (u[2, i] - u[J-1, i])*(u[0, i] + h/2*f2) - u[1, i] - h/2*f2 + F
    f4 = (u[2, i] - u[J-1, i])*(u[0, i] + h*f3) - u[1, i] - h*f3 + F
    u[1, i+1] = u[1, i] + h/6*(f1 + 2*f2 + 2*f3 + f4)

    # j = J-1
    f1 = (u[0, i] - u[J-3, i])*u[J-2, i] - u[J-1, i] + F
    f2 = (u[0, i] - u[J-3, i])*(u[J-2, i] + h/2*f1) - u[J-1, i] - h/2*f1 + F
    f3 = (u[0, i] - u[J-3, i])*(u[J-2, i] + h/2*f2) - u[J-1, i] - h/2*f2 + F
    f4 = (u[0, i] - u[J-3, i])*(u[J-2, i] + h*f3) - u[J-1, i] - h*f3 + F
    u[J-1, i+1] = u[J-1, i] + h/6*(f1 + 2*f2 + 2*f3 + f4)

    # now do the same for the perturbed matrix
    # j = 0
    f1 = (v[1, i] - v[J-2, i])*v[J-1, i] - v[0, i] + F
    f2 = (v[1, i] - v[J-2, i])*(v[J-1, i] + h/2*f1) - v[0, i] - h/2*f1 + F
    f3 = (v[1, i] - v[J-2, i])*(v[J-1, i] + h/2*f2) - v[0, i] - h/2*f2 + F
    f4 = (v[1, i] - v[J-2, i])*(v[J-1, i] + h*f3) - v[0, i] - h*f3 + F
    v[0, i+1] = v[0, i] + h/6*(f1 + 2*f2 + 2*f3 + f4)

    # j = 1
    f1 = (v[2, i] - v[J-1, i])*v[0, i] - v[1, i] + F
    f2 = (v[2, i] - v[J-1, i])*(v[0, i] + h/2*f1) - v[1, i] - h/2*f1 + F
    f3 = (v[2, i] - v[J-1, i])*(v[0, i] + h/2*f2) - v[1, i] - h/2*f2 + F
    f4 = (v[2, i] - v[J-1, i])*(v[0, i] + h*f3) - v[1, i] - h*f3 + F
    v[1, i+1] = v[1, i] + h/6*(f1 + 2*f2 + 2*f3 + f4)

    # j = J
    f1 = (v[0, i] - v[J-3, i])*v[J-2, i] - v[J-1, i] + F
    f2 = (v[0, i] - v[J-3, i])*(v[J-2, i] + h/2*f1) - v[J-1, i] - h/2*f1 + F
    f3 = (v[0, i] - v[J-3, i])*(v[J-2, i] + h/2*f2) - v[J-1, i] - h/2*f2 + F
    f4 = (v[0, i] - v[J-3, i])*(v[J-2, i] + h*f3) - v[J-1, i] - h*f3 + F
    v[J-1, i+1] = v[J-1, i] + h/6*(f1 + 2*f2 + 2*f3 + f4)
   
    # iterate for the rest
    #for j = 3:J-1
    for j in xrange(2, J-1):
        f1 = (u[j+1, i] - u[j-2, i])*u[j-1, i] - u[j, i] + F
        f2 = (u[j+1, i] - u[j-2, i])*(u[j-1, i] + h/2*f1) - u[j, i] - h/2*f1 + F
        f3 = (u[j+1, i] - u[j-2, i])*(u[j-1, i] + h/2*f2) - u[j, i] - h/2*f2 + F
        f4 = (u[j+1, i] - u[j-2, i])*(u[j-1, i] + h*f3) - u[j, i] - h*f3 + F
        u[j, i+1] = u[j, i] + h/6*(f1 + 2*f2 + 2*f3 + f4)
        
        # perturbed matrix
        f1 = (v[j+1, i] - v[j-2, i])*v[j-1, i] - v[j, i] + F
        f2 = (v[j+1, i] - v[j-2, i])*(v[j-1, i] + h/2*f1) - v[j, i] - h/2*f1 + F
        f3 = (v[j+1, i] - v[j-2, i])*(v[j-1, i] + h/2*f2) - v[j, i] - h/2*f2 + F
        f4 = (v[j+1, i] - v[j-2, i])*(v[j-1, i] + h*f3) - v[j, i] - h*f3 + F
        v[j, i+1] = v[j, i] + h/6*(f1 + 2*f2 + 2*f3 + f4)

end_time = clock()
print "tfinal: %i" % tfinal
print "h: %f" % h
print "Seconds elapsed: %f" % (end_time - start_time)

# Uncomment the rest if you're interested in saving data
# for plotting with, e.g., gnuplot. Plotting could also be
# done directly by Python with matplotlib

#diffs = numpy.concatenate( ([t], u-v), axis=0).T
#numpy.savetxt('u.txt', u)
#numpy.savetxt('v.txt', v)
#numpy.savetxt('t.txt', t)
#numpy.savetxt('diffs.txt', diffs)

