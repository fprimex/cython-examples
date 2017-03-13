/*
Program     : lorenz96_solver.py
Author      : Celestine Woodruff
C port      : Brent Woodruff
Date        : 2/14/11
Purpose     : Explore the effect of a small perturbation of the initial data on
              the long term solution of the Lorenz 96 model.
*/

void solve_c(int F, double h, int J, int steps,
          double *t, double **u, double **v) {
    //Perform 4th order Runge-Kutta to iterate in time
    int i, j;
    double f1, f2, f3, f4;
    for(i=0; i<steps; i++) {
        t[i+1] = i*h;
        // iterate this step for the special cases first
        // j = 0
        f1 = (u[1][i] - u[J-2][i])*u[J-1][i] - u[0][i] + F;
        f2 = (u[1][i] - u[J-2][i])*(u[J-1][i] + h/2*f1) - u[0][i] - h/2*f1 + F;
        f3 = (u[1][i] - u[J-2][i])*(u[J-1][i] + h/2*f2) - u[0][i] - h/2*f2 + F;
        f4 = (u[1][i] - u[J-2][i])*(u[J-1][i] + h*f3) - u[0][i] - h*f3 + F;
        u[0][i+1] = u[0][i] + h/6*(f1 + 2*f2 + 2*f3 + f4);

        // j = 1
        f1 = (u[2][i] - u[J-1][i])*u[0][i] - u[1][i] + F;
        f2 = (u[2][i] - u[J-1][i])*(u[0][i] + h/2*f1) - u[1][i] - h/2*f1 + F;
        f3 = (u[2][i] - u[J-1][i])*(u[0][i] + h/2*f2) - u[1][i] - h/2*f2 + F;
        f4 = (u[2][i] - u[J-1][i])*(u[0][i] + h*f3) - u[1][i] - h*f3 + F;
        u[1][i+1] = u[1][i] + h/6*(f1 + 2*f2 + 2*f3 + f4);

        // j = J-1
        f1 = (u[0][i] - u[J-3][i])*u[J-2][i] - u[J-1][i] + F;
        f2 = (u[0][i] - u[J-3][i])*(u[J-2][i] + h/2*f1) - u[J-1][i] - h/2*f1 + F;
        f3 = (u[0][i] - u[J-3][i])*(u[J-2][i] + h/2*f2) - u[J-1][i] - h/2*f2 + F;
        f4 = (u[0][i] - u[J-3][i])*(u[J-2][i] + h*f3) - u[J-1][i] - h*f3 + F;
        u[J-1][i+1] = u[J-1][i] + h/6*(f1 + 2*f2 + 2*f3 + f4);

        // now do the same for the perturbed matrix
        // j = 0
        f1 = (v[1][i] - v[J-2][i])*v[J-1][i] - v[0][i] + F;
        f2 = (v[1][i] - v[J-2][i])*(v[J-1][i] + h/2*f1) - v[0][i] - h/2*f1 + F;
        f3 = (v[1][i] - v[J-2][i])*(v[J-1][i] + h/2*f2) - v[0][i] - h/2*f2 + F;
        f4 = (v[1][i] - v[J-2][i])*(v[J-1][i] + h*f3) - v[0][i] - h*f3 + F;
        v[0][i+1] = v[0][i] + h/6*(f1 + 2*f2 + 2*f3 + f4);

        // j = 1
        f1 = (v[2][i] - v[J-1][i])*v[0][i] - v[1][i] + F;
        f2 = (v[2][i] - v[J-1][i])*(v[0][i] + h/2*f1) - v[1][i] - h/2*f1 + F;
        f3 = (v[2][i] - v[J-1][i])*(v[0][i] + h/2*f2) - v[1][i] - h/2*f2 + F;
        f4 = (v[2][i] - v[J-1][i])*(v[0][i] + h*f3) - v[1][i] - h*f3 + F;
        v[1][i+1] = v[1][i] + h/6*(f1 + 2*f2 + 2*f3 + f4);

        // j = J
        f1 = (v[0][i] - v[J-3][i])*v[J-2][i] - v[J-1][i] + F;
        f2 = (v[0][i] - v[J-3][i])*(v[J-2][i] + h/2*f1) - v[J-1][i] - h/2*f1 + F;
        f3 = (v[0][i] - v[J-3][i])*(v[J-2][i] + h/2*f2) - v[J-1][i] - h/2*f2 + F;
        f4 = (v[0][i] - v[J-3][i])*(v[J-2][i] + h*f3) - v[J-1][i] - h*f3 + F;
        v[J-1][i+1] = v[J-1][i] + h/6*(f1 + 2*f2 + 2*f3 + f4);
       
        // iterate for the rest
        for(j=2; j<J-1; j++) {
            f1 = (u[j+1][i] - u[j-2][i])*u[j-1][i] - u[j][i] + F;
            f2 = (u[j+1][i] - u[j-2][i])*(u[j-1][i] + h/2*f1) - u[j][i] - h/2*f1 + F;
            f3 = (u[j+1][i] - u[j-2][i])*(u[j-1][i] + h/2*f2) - u[j][i] - h/2*f2 + F;
            f4 = (u[j+1][i] - u[j-2][i])*(u[j-1][i] + h*f3) - u[j][i] - h*f3 + F;
            u[j][i+1] = u[j][i] + h/6*(f1 + 2*f2 + 2*f3 + f4);
            
            // perturbed matrix
            f1 = (v[j+1][i] - v[j-2][i])*v[j-1][i] - v[j][i] + F;
            f2 = (v[j+1][i] - v[j-2][i])*(v[j-1][i] + h/2*f1) - v[j][i] - h/2*f1 + F;
            f3 = (v[j+1][i] - v[j-2][i])*(v[j-1][i] + h/2*f2) - v[j][i] - h/2*f2 + F;
            f4 = (v[j+1][i] - v[j-2][i])*(v[j-1][i] + h*f3) - v[j][i] - h*f3 + F;
            v[j][i+1] = v[j][i] + h/6*(f1 + 2*f2 + 2*f3 + f4);
        }
    }
}

