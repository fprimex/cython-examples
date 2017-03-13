"""
Program     : lorenz96_solver.py
Author      : Celestine Woodruff
Cython port : Brent Woodruff
Date        : 2/10/11
Purpose     : Explore the effect of a small perturbation of the initial data on
              the long term solution of the Lorenz 96 model.
"""

cimport numpy
from libc.stdlib cimport free, malloc
from libc.string cimport memcpy

cdef extern from "lorenz96_solver.h":
    void solve_c(int F, double h, int J, int steps, double *t, double **u, double **v)

# Credit to Tiago Pereira for the conversion routines
# http://web.archiveorange.com/archive/v/JPeC5e4On3uR5BZQI9U2
cdef inline double **numpy2c_dbl(numpy.ndarray[numpy.float64_t, ndim=2] a):
    """Convert 2D numpy array to double** for processing in C"""
    cdef int m = a.shape[0]
    cdef int n = a.shape[1]
    cdef int i
    cdef double **data
    data = <double **> malloc(m*sizeof(double *))
    for i in range(m):
        data[i] = &(<double *>a.data)[i*n]
    return data

cdef inline numpy.ndarray c2numpy_dbl(double **a, int n, int m):
    """Convert double** from C into an initialized 2D numpy array"""
    cdef numpy.ndarray[numpy.float64_t, ndim=2]result = numpy.zeros((m,n),dtype=numpy.float64)
    cdef double *dest
    cdef int i
    dest = <double *> malloc(m*n*sizeof(double*))  
    for i in range(m):
        memcpy(dest + i*n,a[i],m*sizeof(double*))
        free(a[i])
    memcpy(result.data,dest,m*n*sizeof(double*))
    free(dest)
    free(a)
    return result

def solve(int F, double h, int J, int steps,
          numpy.ndarray[numpy.float64_t, ndim=1] t,
          numpy.ndarray[numpy.float64_t, ndim=2] u,
          numpy.ndarray[numpy.float64_t, ndim=2] v):
    """Perform 4th order Runge-Kutta to iterate in time"""
    u_dbl = numpy2c_dbl(u)
    v_dbl = numpy2c_dbl(v)
    solve_c(F, h, J, steps, <double *>t.data, u_dbl, v_dbl)
    free(u_dbl)
    free(v_dbl)
