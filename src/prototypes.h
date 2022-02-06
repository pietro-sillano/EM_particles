#include<iostream>
#include <fstream>
#include<cmath>
#include<iomanip>

#define DEBUG false

using namespace std;

// ROOT_SOLVERS//
#define MAX_ZEROS 256
double Bisection(double (* func)(double),double a,double b,double tol,int &k);
double FalsePosition(double (* func)(double),double a,double b,double tol,int &k);
double Secant(double (* func)(double),double a,double b,double tol,int &k);
double Newton(double (* func)(double),double (* deriv)(double),double a,double b,double tol,int &k);
int Bracket(double (* func)(double),double a,double b,int N,double *xL,double *xR);


//ODE_SOLVERS//
void EulerStep(double x,double *Y,void(*RHSFunc)(double,double *,double *),double dx,int neq);

void RHSFunc (double t,double *Y,double *R);

void RK2Step(double t,double *Y,void(*RHSFunc)(double,double *,double *),double h, int neq);

void RK4Step(double t,double *Y,void(*RHSFunc)(double,double *,double *),double h, int neq);

//SYMPLECTIC INTEGRATORS
void PositionVerlet(double &x,double &v,double (*Acceleration)(double),double dt);



// MATRIX UTILITIES
void tridiag_solver(double *a,double *b,double *c,double *r,int n, double *x);






