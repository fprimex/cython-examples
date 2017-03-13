# include <math.h>

// Not all compilers have M_PI and this code is GPL,
// so I have taken the definition from GCC 4.9.
#ifndef M_PI
#define M_PI        3.14159265358979323846264338327950288
#endif

double f1(double x) {
  return 50.0 / (M_PI * (2500.0 * x * x + 1.0));
}

char* f1_repr(void) {
  return "50.0 / (PI * (2500.0 * x^2 + 1.0))";
}

