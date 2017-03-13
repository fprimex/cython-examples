from quad_openmp_wrapper import quadrature

a = 0.0
b = 10.0
exact = 0.49936338107645674464
n=1000000000

print()
print("QUAD_OPENMP:")
print("  C version")
print("  Use OpenMP for parallel execution.")
print("  Estimate the integral of f(x) from A to B.")
print("  f(x) = 50 / ( pi * ( 2500 * x * x + 1 ) ).")
print()
print("  A        = {}".format(a))
print("  B        = {}".format(b))
print("  N        = {}".format(n))
print("  Exact    = {}".format(exact))
#print("  Exact    = {}%24.16f", exact)

total, error, wtime = quadrature(a, b, exact, n)

print()
#print("  Estimate = %24.16f", total)
print("  Estimate = {}".format(total))
print("  Error    = {}".format(error))
print("  Time     = {}".format(wtime))

print()
print("QUAD_OPENMP:")
print("  Normal end of execution.")
print()

