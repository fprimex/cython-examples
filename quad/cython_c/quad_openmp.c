# include <math.h>
# include <omp.h>

// Not all compilers have M_PI and this code is GPL,
// so I have taken the definition from GCC 4.9.
#ifndef M_PI
#define M_PI        3.14159265358979323846264338327950288
#endif

double f ( double x );

int quad (double* total, double* error, double* wtime, double a,
          double b, double exact, int n) {
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

double f ( double x ) {
  return 50.0 / ( M_PI * ( 2500.0 * x * x + 1.0 ) );
}

