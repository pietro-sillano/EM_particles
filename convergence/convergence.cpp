#include "prototypes.h"

void RHSFunc(double t, double * Y, double * R);
void crossproduct6(double * A, double * B, double * C);
void crossproduct3(double * A, double * B, double * C);
void Efield(double x, double y, double z, double * E);
void Bfield(double x, double y, double z, double * B);
void BorisPusher(double * Y, double dt);
double analitical(double t);


int main() {
  using namespace std;
  ofstream fdata;
  fdata.open("convergence.dat");
  fdata << setiosflags(ios::scientific);
  fdata << setprecision(12);
  cout << setprecision(5);

  //   queste sono le velocitá, le tratto come se fossero 3 semplici ODE
  int neq = 6;
  double Y[neq];

  //   Condizioni Iniziali
  double x0 = 0.;
  double y0 = 0.;
  double z0 = 0.;
  double vx0 = 1.;
  double vy0 = 0.;
  double vz0 = 0.;
  double U0 = vx0 * vx0 + vy0 * vy0 + vz0 * vz0;
  double U;

  //  Assegnazione condizioni iniziali 
  Y[0] = x0; // x
  Y[1] = y0; // y
  Y[2] = z0; //z
  Y[3] = vx0; // vx
  Y[4] = vy0; // vy
  Y[5] = vz0; //vz

  //   starting point dell' integratore
  double tb = 10;
  double ta = 0.;
  int nstep;           //numero steps
  double dt=(tb-ta)/double(nstep);
  double err;
  int i,j,k;
  double t;
  
  
  nstep = 4 ;
  cout<<"RK2 method" << endl;
  for (k=1;k<=12;k++){
    
    Y[0] = x0; // x
    Y[1] = y0; // y
    Y[2] = z0; //z
    Y[3] = vx0; // vx
    Y[4] = vy0; // vy
    Y[5] = vz0; //vz
    
    t=ta; //punto di partenza dell integratore
    dt=(tb-ta)/double(nstep);

    for (i=1;i<=nstep;i++){
    RK2Step(t, Y, RHSFunc, dt, neq);
    t+=dt;
    }
    
    cout <<"nstep: "<<nstep<<"   dt: "<<dt <<"    err: " <<fabs(Y[0]-analitical(tb))<<"  t:"<<t<<endl;
    
    fdata <<dt <<"  " <<fabs(Y[0]-analitical(tb)) <<endl;
    nstep=nstep*2;
  }
  
  fdata <<endl<<endl;

  nstep = 4 ;
  cout<<"RK4 method" << endl;
  for (k=1;k<=12;k++){
    
    Y[0] = x0; // x
    Y[1] = y0; // y
    Y[2] = z0; //z
    Y[3] = vx0; // vx
    Y[4] = vy0; // vy
    Y[5] = vz0; //vz
    
    t=ta; //punto di partenza dell integratore
    dt=(tb-ta)/double(nstep);

    for (i=1;i<=nstep;i++){
    RK4Step(t, Y, RHSFunc, dt, neq);
    t+=dt;
    }
    
    cout <<"nstep: "<<nstep<<"   dt: "<<dt <<"    err: " <<fabs(Y[0]-analitical(tb))<<"  t:"<<t<<endl;
    
    fdata <<dt <<"  " <<fabs(Y[0]-analitical(tb)) <<endl;
    nstep=nstep*2;
  }
    fdata <<endl<<endl;

  
  
  
  nstep = 4 ;
  cout<<"boris method" << endl;
  for (k=1;k<=12;k++){
    
    Y[0] = x0; // x
    Y[1] = y0; // y
    Y[2] = z0; //z
    Y[3] = vx0; // vx
    Y[4] = vy0; // vy
    Y[5] = vz0; //vz
    
    t=ta; //punto di partenza dell integratore
    dt=(tb-ta)/double(nstep);

    for (i=1;i<=nstep;i++){
    BorisPusher(Y,dt);
    t+=dt;
    }
    
    cout <<"nstep: "<<nstep<<"   dt: "<<dt <<"    err: " <<fabs(Y[0]-analitical(tb))<<"  t:"<<t<<endl;
    
    fdata <<dt <<"  " <<fabs(Y[0]-analitical(tb)) <<endl;
    nstep=nstep*2;
  }
  
  fdata <<endl<<endl;

  return 0;
}


double analitical(double t){
  double x;
  double Ey = 0.5;
  double Bz = 1.;
  double vd = Ey / Bz;
  x = 0.5*sin(t) + vd*t;
  return x;
}

void RHSFunc(double t, double * Y, double * R) {
  double vxb[3];
  double E[3];
  double B[3];
  Efield(Y[0], Y[1], Y[2], E);
  Bfield(Y[0], Y[1], Y[2], B);
  crossproduct6(Y, B, vxb);
  //   posizioni
  R[0] = Y[3];
  R[1] = Y[4];
  R[2] = Y[5];
  //   velocita
  R[3] = E[0] + vxb[0];
  R[4] = E[1] + vxb[1];
  R[5] = E[2] + vxb[2];
}
void crossproduct6(double * A, double * B, double * C) {
  C[0] = A[4] * B[2] - A[5] * B[1];
  C[1] = -A[3] * B[2] + A[5] * B[0];
  C[2] = A[3] * B[1] - A[4] * B[0];
}

void crossproduct3(double * A, double * B, double * C) {
  C[0] = A[1] * B[2] - A[2] * B[1];
  C[1] = -A[0] * B[2] + A[2] * B[0];
  C[2] = A[0] * B[1] - A[1] * B[0];
}

void BorisPusher(double * Y, double dt) {

  double E[3];
  double B[3];
  Efield(Y[0], Y[1], Y[2], E);
  Bfield(Y[0], Y[1], Y[2], B);
  double temp[3];
  double alpha = 1;
  double upm[3], upp[3];
  double h = alpha * dt;
  double b[3];
  b[0] = 0.5 * h * B[0];
  b[1] = 0.5 * h * B[1];
  b[2] = 0.5 * h * B[2];
  double bquadro = b[0] * b[0] + b[1] * b[1] + b[2] * b[2];
  double temp2[3];

  Y[0] += dt * 0.5 * Y[3];
  Y[1] += dt * 0.5 * Y[4];
  Y[2] += dt * 0.5 * Y[5];

  upm[0] = Y[3] + 0.5 * h * E[0];
  upm[1] = Y[4] + 0.5 * h * E[1];
  upm[2] = Y[5] + 0.5 * h * E[2];

  crossproduct3(upm, b, temp);

  temp2[0] = 2 * (upm[0] + temp[0]) / (1 + bquadro);
  temp2[1] = 2 * (upm[1] + temp[1]) / (1 + bquadro);
  temp2[2] = 2 * (upm[2] + temp[2]) / (1 + bquadro);

  crossproduct3(temp2, b, temp);

  upp[0] = upm[0] + temp[0];
  upp[1] = upm[1] + temp[1];
  upp[2] = upm[2] + temp[2];

  Y[3] = upp[0] + 0.5 * h * E[0];
  Y[4] = upp[1] + 0.5 * h * E[1];
  Y[5] = upp[2] + 0.5 * h * E[2];

  Y[0] += 0.5 * dt * Y[3];
  Y[1] += 0.5 * dt * Y[4];
  Y[2] += 0.5 * dt * Y[5];
}

void Efield(double x, double y, double z, double * E) {
  E[0] = 0.;
  E[1] = 0.5;
  E[2] = 0.;
}

void Bfield(double x, double y, double z, double * B) {
  B[0] = 0.;
  B[1] = 0.;
  B[2] = 1.;
}
