#include <math.h>
#include <omp.h>

int quad(double (*f)(double), double* total, double* error,
         double* wtime, double a, double b, double exact, int n) {
  int i;
  double t;
  double x;

  *wtime = omp_get_wtime ( );

  t = 0.0;

# pragma omp parallel shared ( a, b, n ) private ( i, x ) 

# pragma omp for reduction ( + : t )

  for ( i = 0; i < n; i++ ) {
    x = ( ( double ) ( n - i - 1 ) * a + ( double ) ( i ) * b ) / ( double ) ( n - 1 );
    t = t + f ( x );
  }

  *wtime = omp_get_wtime ( ) - *wtime;
  *total = ( b - a ) * t / ( double ) n;
  *error = fabs ( *total - exact );

  return 0;
}

