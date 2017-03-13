cdef extern from "quad_openmp.h":
    int quad(double* total, double* error, double* wtime, double a,
              double b, double exact, int n)

def quadrature(double a, double b, double exact, int n):
    """Integrate a function using quadrature"""
    cdef double t, e, w
    quad(&t, &e, &w, a, b, exact, n)
    return t, e, w 
