#include <math.h>

double f2(double x) {
  return (2.0 * x + 1.0 / 3.0) * cos(x * x + x / 3.0);
}

char* f2_repr(void) {
  return "(2x + 1/3)*cos(x^2 + x/3)";
}

