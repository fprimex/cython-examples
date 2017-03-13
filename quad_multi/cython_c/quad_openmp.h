#ifndef QUADH
#define QUADH

int quad(double (*f)(double), double* total, double* error,
         double* wtime, double a, double b, double exact, int n);

#endif
