!------------------------------------------------------------------------------
! Program   : lorenz96.f95
! Author    : Celes Woodruff
! Date      : 2/7/11
! Purpose   : Explore the effect of a small perturbation of the initial data on
!             the long term solution of the Lorenz 96 model.
!------------------------------------------------------------------------------

PROGRAM lorenz96
IMPLICIT NONE

REAL, ALLOCATABLE, DIMENSION(:,:) :: u, v, diffs
REAL, ALLOCATABLE, DIMENSION(:) :: t
REAL :: tfinal, h, F, f1, f2, f3, f4, start, finish
INTEGER :: J, steps, i, status, s

J = 5
J = J + 1 ! shift to arrays beginning with 1
F = -12.0
tfinal = 160.0
!tfinal = 20.0
h = 1e-5

steps = ceiling(tfinal/h)

!OPEN(UNIT = 10, FILE = 'u.txt')
!OPEN(UNIT = 11, FILE = 'v.txt')
!OPEN(UNIT = 12, FILE = 't.txt')
!OPEN(UNIT = 13, FILE = 'diffs.txt')

ALLOCATE(u(J,steps+1), STAT = status)
ALLOCATE(v(J,steps+1), STAT = status)
ALLOCATE(diffs(J,steps+1), STAT = status)
ALLOCATE(t(steps+1), STAT = status)

write(*,*) "\n J = ", J
write(*,*) "F = ", F
write(*,*) "tfinal = ", tfinal
write(*,*) "h = ", h
write(*,*) "steps = ", steps

! generate initial values between -1 and 1
! the rows of u,v are x's and columns are time steps
DO i = 1,J
    u(i,1) = -1.0 + 2.0*rand()
    v(i,1) = u(i,1)*(1.0 + (-1.0 + 2.0*rand())/100.0)
END DO

write(*,*) "\n Initially, u = ", u(:,1)
write(*,*) "\n Initially, v = ", v(:,1)

t(1) = 0.0

CALL CPU_TIME(start)
! perform 4th order Runge-Kutta to iterate in time
DO i = 1,steps
    t(i+1) = i*h
    !write(*,*) t(i+1)
    
    ! iterate this step for the special cases first
    ! s = 1
    f1 = (u(2,i) - u(J-1,i))*u(J,i) - u(1,i) + F
    f2 = (u(2,i) - u(J-1,i))*(u(J,i) + h/2.0*f1) - u(1,i) - h/2.0*f1 + F
    f3 = (u(2,i) - u(J-1,i))*(u(J,i) + h/2.0*f2) - u(1,i) - h/2.0*f2 + F
    f4 = (u(2,i) - u(J-1,i))*(u(J,i) + h*f3) - u(1,i) - h*f3 + F
    u(1,i+1) = u(1,i) + h/6.0*(f1 + 2.0*(f2 + f3) + f4)

    ! s = 2
    f1 = (u(3,i) - u(J,i))*u(1,i) - u(2,i) + F
    f2 = (u(3,i) - u(J,i))*(u(1,i) + h/2.0*f1) - u(2,i) - h/2.0*f1 + F
    f3 = (u(3,i) - u(J,i))*(u(1,i) + h/2.0*f2) - u(2,i) - h/2.0*f2 + F
    f4 = (u(3,i) - u(J,i))*(u(1,i) + h*f3) - u(2,i) - h*f3 + F
    u(2,i+1) = u(2,i) + h/6.0*(f1 + 2*(f2 + f3) + f4)

    ! s = J
    f1 = (u(1,i) - u(J-2,i))*u(J-1,i) - u(J,i) + F
    f2 = (u(1,i) - u(J-2,i))*(u(J-1,i) + h/2.0*f1) - u(J,i) - h/2.0*f1 + F
    f3 = (u(1,i) - u(J-2,i))*(u(J-1,i) + h/2.0*f2) - u(J,i) - h/2.0*f2 + F
    f4 = (u(1,i) - u(J-2,i))*(u(J-1,i) + h*f3) - u(J,i) - h*f3 + F
    u(J,i+1) = u(J,i) + h/6.0*(f1 + 2.0*(f2 + f3) + f4)

    ! now do the same for the perturbed matrix
    ! s = 1
    f1 = (v(2,i) - v(J-1,i))*v(J,i) - v(1,i) + F
    f2 = (v(2,i) - v(J-1,i))*(v(J,i) + h/2.0*f1) - v(1,i) - h/2.0*f1 + F
    f3 = (v(2,i) - v(J-1,i))*(v(J,i) + h/2.0*f2) - v(1,i) - h/2.0*f2 + F
    f4 = (v(2,i) - v(J-1,i))*(v(J,i) + h*f3) - v(1,i) - h*f3 + F
    v(1,i+1) = v(1,i) + h/6.0*(f1 + 2.0*(f2 + f3) + f4)

    ! s = 2
    f1 = (v(3,i) - v(J,i))*v(1,i) - v(2,i) + F
    f2 = (v(3,i) - v(J,i))*(v(1,i) + h/2.0*f1) - v(2,i) - h/2.0*f1 + F
    f3 = (v(3,i) - v(J,i))*(v(1,i) + h/2.0*f2) - v(2,i) - h/2.0*f2 + F
    f4 = (v(3,i) - v(J,i))*(v(1,i) + h*f3) - v(2,i) - h*f3 + F
    v(2,i+1) = v(2,i) + h/6.0*(f1 + 2*(f2 + f3) + f4)

    ! s = J
    f1 = (v(1,i) - v(J-2,i))*v(J-1,i) - v(J,i) + F
    f2 = (v(1,i) - v(J-2,i))*(v(J-1,i) + h/2.0*f1) - v(J,i) - h/2.0*f1 + F
    f3 = (v(1,i) - v(J-2,i))*(v(J-1,i) + h/2.0*f2) - v(J,i) - h/2.0*f2 + F
    f4 = (v(1,i) - v(J-2,i))*(v(J-1,i) + h*f3) - v(J,i) - h*f3 + F
    v(J,i+1) = v(J,i) + h/6.0*(f1 + 2.0*(f2 + f3) + f4)

    ! iterate for the rest
    DO s = 3,J-1
        f1 = (u(s+1,i) - u(s-2,i))*u(s-1,i) - u(s,i) + F
        f2 = (u(s+1,i) - u(s-2,i))*(u(s-1,i) + h/2.0*f1) - u(s,i) - h/2.0*f1 + F
        f3 = (u(s+1,i) - u(s-2,i))*(u(s-1,i) + h/2.0*f2) - u(s,i) - h/2.0*f2 + F
        f4 = (u(s+1,i) - u(s-2,i))*(u(s-1,i) + h*f3) - u(s,i) - h*f3 + F
        u(s,i+1) = u(s,i) + h/6.0*(f1 + 2.0*(f2 + f3) + f4)

        ! perturbed matrix
        f1 = (v(s+1,i) - v(s-2,i))*v(s-1,i) - v(s,i) + F
        f2 = (v(s+1,i) - v(s-2,i))*(v(s-1,i) + h/2.0*f1) - v(s,i) - h/2.0*f1 + F
        f3 = (v(s+1,i) - v(s-2,i))*(v(s-1,i) + h/2.0*f2) - v(s,i) - h/2.0*f2 + F
        f4 = (v(s+1,i) - v(s-2,i))*(v(s-1,i) + h*f3) - v(s,i) - h*f3 + F
        v(s,i+1) = v(s,i) + h/6.0*(f1 + 2.0*(f2 + f3) + f4)
    END DO
END DO

CALL CPU_TIME(finish)

write(*,*) "This took ", finish - start, " seconds."

!write(*,*) "\n The final solution is u = \n", u
!write(*,*) "\n The final perturbed solution is v = \n", v

!DO i = 1,J
!    write(10,*) u(i,:)
!    write(11,*) v(i,:)
!END DO

diffs = u - v
!DO s = 1,steps+1
!    write(12,*) t(s)
!    write(13,*) t(s), diffs(:,s)
!END DO

DEALLOCATE(u)
DEALLOCATE(v)
DEALLOCATE(t)
DEALLOCATE(diffs)

!CLOSE(10)
!CLOSE(11)
!CLOSE(12)
!CLOSE(13)

END
