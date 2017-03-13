from quad_openmp_wrapper import Integrator

I = Integrator()

jobs = [
        (0, 0.0, 10.0, 0.49936338107645674464, 1000000000),
        (1, -4.0, 4.0, 0.49936338107645674464, 1000000000)
       ]

for job in jobs:
    func, a, b, exact, n = job
    I.set_selection(func)
    I.set_parameters(a=a, b=b, exact=exact, n=n)

    print()
    print("QUAD_OPENMP:")
    print("  Python -> Cython -> C version")
    print("  Use OpenMP for parallel execution.")
    print("  Estimate the integral of f(x) from A to B.")
    print("  {}.".format(I.get_selection_repr()))
    print()
    print("  A        = {}".format(a))
    print("  B        = {}".format(b))
    print("  N        = {}".format(n))
    print("  Exact    = {}".format(exact))
    #print("  Exact    = {}%24.16f", exact)

    total, error, wtime = I.integrate()

    print()
    print("  Estimate = {}".format(total))
    print("  Error    = {}".format(error))
    print("  Time     = {}".format(wtime))

    print()
    print("QUAD_OPENMP:")
    print("  Normal end of execution.")
    print()

