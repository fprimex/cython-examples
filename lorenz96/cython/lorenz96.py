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
from lorenz96_solver import solve

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
for i in xrange(J):
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
print "tfinal: %i" % tfinal
print "h: %f" % h
print "Seconds elapsed: %f" % (end_time - start_time)

#diffs = numpy.concatenate( ([t], u-v), axis=0).T

#numpy.savetxt('u.txt', u)
#numpy.savetxt('v.txt', v)
#numpy.savetxt('t.txt', t)
#numpy.savetxt('diffs.txt', diffs)

#for i = 1:length(u)
#for i in xrange(1, len(u)):
#    u2(i) = mean(u[:][i])

#for i = 1:length(v)
#for i in xrange(1,len(v)):
#    v2(i) = mean(v[:][i])

# Solutions
#figure(1)
#subplot(2,3,1); plot(t,u[1][:],t,v[1][:])
#title('Solutions at Location 1')
#xlabel('time')
#legend('orig.','pert.')
#subplot(2,3,2); plot(t,u[2][:],t,v[2][:])
#title('Solutions at Location 2')
#xlabel('time')
#legend('orig.','pert.')
#subplot(2,3,3); plot(t,u[3][:],t,v[3][:])
#title('Solutions at Location 3')
#xlabel('time')
#legend('orig.','pert.')
#subplot(2,3,4); plot(t,u[4][:],t,v[4][:])
#title('Solutions at Location 4')
#xlabel('time')
#legend('orig.','pert.')
#subplot(2,3,5); plot(t,u[5][:],t,v[5][:])
#title('Solutions at Location 5')
#xlabel('time')
#legend('orig.','pert.')
#subplot(2,3,6); plot(t,u[6][:],t,v[6][:])
#title('Difference at Location 6')
#xlabel('time')
#legend('orig.','pert.')
#
#
## histograms
#[n1u,xout1u] = hist(u[1][:])
#[n2u,xout2u] = hist(u[2][:])
#[n3u,xout3u] = hist(u[3][:])
#[n4u,xout4u] = hist(u[4][:])
#[n5u,xout5u] = hist(u[5][:])
#[n6u,xout6u] = hist(u[6][:])
##[nu,xoutu] = hist(u2)
#[n1v,xout1v] = hist(v[1][:])
#[n2v,xout2v] = hist(v[2][:])
#[n3v,xout3v] = hist(v[3][:])
#[n4v,xout4v] = hist(v[4][:])
#[n5v,xout5v] = hist(v[5][:])
#[n6v,xout6v] = hist(v[6][:])
##[nv,xoutv] = hist(v2)
#
#figure(2)
#subplot(2,3,1); bar(xout1u,n1u/(J*(steps+1)),1,'b')
#hold on
#bar(xout1v,n1v/(J*(steps+1)),.5,'r')
#hold off
#xlim([-20 20])
#title('Location 1')
#legend('orig.','pert.')
#
#subplot(2,3,2); bar(xout2u,n2u/(J*(steps+1)),1,'b')
#hold on
#bar(xout2v,n2v/(J*(steps+1)),.5,'r')
#hold off
#xlim([-20 20])
#title('Location 2')
#legend('orig.','pert.')
#
#subplot(2,3,3); bar(xout3u,n3u/(J*(steps+1)),1,'b')
#hold on
#bar(xout3v,n3v/(J*(steps+1)),.5,'r')
#hold off
#xlim([-20 20])
#title('Location 3')
#legend('orig.','pert.')
#
#subplot(2,3,4); bar(xout4u,n4u/(J*(steps+1)),1,'b')
#hold on
#bar(xout4v,n4v/(J*(steps+1)),.5,'r')
#hold off
#xlim([-20 20])
#title('Location 4')
#legend('orig.','pert.')
#
#subplot(2,3,5); bar(xout5u,n5u/(J*(steps+1)),1,'b')
#hold on
#bar(xout5v,n5v/(J*(steps+1)),.5,'r')
#hold off
#xlim([-20 20])
#title('Location 5')
#legend('orig.','pert.')
#
#subplot(2,3,6); bar(xout6u,n6u/(J*(steps+1)),1,'b')
#hold on
#bar(xout6v,n6v/(J*(steps+1)),.5,'r')
#hold off
#xlim([-20 20])
#title('Location 6')
#legend('orig.','pert.')
#
##subplot(2,3,6); bar(xoutu,nu/(J*(steps+1)),1,'b')
##hold on
##bar(xoutv,nv/(J*(steps+1)),.5,'r')
##hold off
##xlim([-20 20])
##title('Average')
##legend('orig.','pert.')
#
## Differences
#figure(3)
#subplot(2,3,1); plot(t,u[1][:] - v[1][:])
#title('Difference at Location 1')
#xlabel('time')
#subplot(2,3,2); plot(t,u[2][:] - v[2][:])
#title('Difference at Location 2')
#xlabel('time')
#subplot(2,3,3); plot(t,u[3][:] - v[3][:])
#title('Difference at Location 3')
#xlabel('time')
#subplot(2,3,4); plot(t,u[4][:] - v[4][:])
#title('Difference at Location 4')
#xlabel('time')
#subplot(2,3,5); plot(t,u[5][:] - v[5][:])
#title('Difference at Location 5')
#xlabel('time')
#subplot(2,3,6); plot(t,u[6][:] - v[6][:])
#title('Difference at Location 6')
#xlabel('time')
#
## make movie of solution
#figure(4)
#lor_mov = avifile('lorenz_movie.avi','quality',100,'fps',10)
#k = 1
#for i = 1:400:length(u)
#    plot(t(1:i),u[1][1:i],t(1:i),v[1][1:i],'LineWidth',2)
#    xlim([0 20])
#    ylim([-15 15])
#    title('Solutions at Location 1')
#    xlabel('time')
#    legend('orig.','pert.')
#
#    M(k) = getframe(gcf)
#    lor_mov = addframe(lor_mov,M(k))
#    k = k + 1
#end
#
#lor_mov = close(lor_mov)
#
#print -f1 -djpeg 'solns' -r500
#print -f2 -djpeg 'hists' -r500
#print -f3 -djpeg 'diffs' -r500
#
#disp('Done printing')
