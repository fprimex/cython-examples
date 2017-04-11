from cpython.mem cimport PyMem_Malloc, PyMem_Realloc, PyMem_Free

# Define a function pointer to a function that returns a double and takes a
# double as argument.
ctypedef double (*cfptr) (double)

# Import the quadrature function that will perform the integration.
cdef extern from "quad_openmp.h":
    int quad(cfptr f, double* total, double* error, double* wtime,
             double a, double b, double exact, int n)

# Import the definitions of the functions to integrate.
cdef extern from "f1.h":
    double f1(double x)
    char* f1_repr()

cdef extern from "f2.h":
    double f2(double x)
    char* f2_repr()

# Declare a pointer to these functions
cdef cfptr f1_ptr = &f1
cdef cfptr f2_ptr = &f2

# Number of functions we have
cdef int num_funcs = 2


# Cython extension class for handling the integration of various functions
cdef class ExtIntegrator:

    # Pointer to what will be an C level array of function pointers
    cdef cfptr* func_ptrs

    def __cinit__(self):
        # allocate memory to hold the function pointers
        self.func_ptrs = <cfptr*> PyMem_Malloc(num_funcs * sizeof(cfptr))
        if not self.func_ptrs:
            raise MemoryError()

        # assign function pointers in order
        self.func_ptrs[0] = f1_ptr
        self.func_ptrs[1] = f2_ptr

    def __init__(self):
        self.func_reprs = [
            f1_repr().decode('utf-8'),
            f2_repr().decode('utf-8')
        ]
        self.selection = 0
        self.set_parameters(a=0.0, b=1.0, exact=0.49936338107645674464,
                            n=1000000000)

    def set_parameters(self, a, b, exact, n):
        self.a = a
        self.b = b
        self.exact = exact
        self.n = n

    def get_func_repr(self, s):
        return self.func_reprs[s]

    def get_selection(self):
        return self.selection

    def get_selection_repr(self):
        return self.func_reprs[self.selection]

    def set_selection(self, s):
        if 0 <= self.selection < num_funcs:
            self.selection = s

    def integrate_quad(self):
        cdef double t, e, w
        quad(self.func_ptrs[self.selection], &t, &e, &w,
             self.a, self.b, self.exact, self.n)
        return t, e, w 

class Integrator(ExtIntegrator):
    def __init__(self):
        super().__init__()

    # Creat the wrapper that will be called from Python to perform the integration.
    def integrate(self):
        """Integrate a function using quadrature"""
        return self.integrate_quad()

