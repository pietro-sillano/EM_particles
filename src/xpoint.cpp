#include<iostream>

#include <fstream>

#include<cmath>

#include<iomanip>


const int NPART = 10000;
const double L = 1000;

#define q 1.6e-19
#define m 9.e-31
#define E0 1.e-2
#define B0 1.e-8

#define V0 E0 / B0
#define t0 m * V0 / (q * E0)
#define l0 V0 * t0

using namespace std;
void crossproduct(double * A, double * B, double * C);
void BorisPusherParticles(double x[][3], double v[][3], double dt, int NPART);
void Efield(double x, double y, double z, double * E);
void Bfield(double x, double y, double z, double * B);

int main() {
  using namespace std;
  ofstream fdata;
  fdata.open("../data/xpoint.dat");
  fdata << setiosflags(ios::scientific);
  fdata << setprecision(12);
  cout << setprecision(5);
  srand48(time(NULL));

  double x[NPART][3];
  double v[NPART][3];

  //   starting point del integratore
  double tb = 20.;
  double ta = 0.;
  double dt = 0.1;
  int nstep = round((tb - ta) / double(dt));
  double t = ta;
  double U = 0.;

  //  Assegnazione condizioni iniziali 
  for (int i = 0; i < NPART; i++) {
    x[i][0] = L * (2. * drand48() - 1.); // x
    x[i][1] = L * (2. * drand48() - 1.); // y
    x[i][2] = 0.; // z

    v[i][0] = sqrt(0.05) * cos(2 * M_PI * drand48()); // vx
    v[i][1] = sqrt(0.05) * sin(2 * M_PI * drand48()); // vy
    v[i][2] = 0.; // vz
  }

  //   ciclo per Boris
  for (int j = 0; j < nstep; j++) {
    for (int i = 0; i < NPART; i++) {
      U = v[i][0] * v[i][0] + v[i][1] * v[i][1] + v[i][1] * v[i][1];
      fdata << i << "  " << t << "  " << x[i][0] << "  " << x[i][1] << "  " << x[i][2] << "  " << v[i][0] << "  " << v[i][1] << "  " << v[i][2] << "  " << U << endl;
    }
    BorisPusherParticles(x, v, dt, NPART);
    t += dt;
    fdata << endl << endl;
    if (j % 10 == 0) cout << int(t) << endl;
  }
  fdata.close();
  

  return 0;
}

void crossproduct(double * A, double * B, double * C) {
  C[0] = A[1] * B[2] - A[2] * B[1];
  C[1] = -A[0] * B[2] + A[2] * B[0];
  C[2] = A[0] * B[1] - A[1] * B[0];
}
void BorisPusherParticles(double x[][3], double v[][3], double dt, int NPART) {

  double E[3] = {
    0,
    0,
    0
  };
  double B[3] = {
    0,
    0,
    0
  };
  double temp[3];
  double alpha = 1.;
  double upm[3], upp[3];
  double h = alpha * dt;
  double b[3];
  double temp2[3];
  double bquadro;

  for (int i = 0; i < NPART; i++) {
    Efield(x[i][0], x[i][1], x[i][2], E);
    Bfield(x[i][0], x[i][1], x[i][2], B);

    b[0] = 0.5 * h * B[0];
    b[1] = 0.5 * h * B[1];
    b[2] = 0.5 * h * B[2];
    bquadro = b[0] * b[0] + b[1] * b[1] + b[2] * b[2];

    x[i][0] += dt * 0.5 * v[i][0];
    x[i][1] += dt * 0.5 * v[i][1];
    x[i][2] += dt * 0.5 * v[i][2];

    upm[0] = v[i][0] + 0.5 * h * E[0];
    upm[1] = v[i][1] + 0.5 * h * E[1];
    upm[2] = v[i][2] + 0.5 * h * E[2];

    crossproduct(upm, b, temp);

    temp2[0] = 2 * (upm[0] + temp[0]) / (1 + bquadro);
    temp2[1] = 2 * (upm[1] + temp[1]) / (1 + bquadro);
    temp2[2] = 2 * (upm[2] + temp[2]) / (1 + bquadro);

    crossproduct(temp2, b, temp);

    upp[0] = upm[0] + temp[0];
    upp[1] = upm[1] + temp[1];
    upp[2] = upm[2] + temp[2];

    v[i][0] = upp[0] + 0.5 * h * E[0];
    v[i][1] = upp[1] + 0.5 * h * E[1];
    v[i][2] = upp[2] + 0.5 * h * E[2];

    x[i][0] += 0.5 * dt * v[i][0];
    x[i][1] += 0.5 * dt * v[i][1];
    x[i][2] += 0.5 * dt * v[i][2];
  }
}
void Efield(double x, double y, double z, double * E) {
  E[0] = 0;
  E[1] = 0;
  E[2] = 0.5;
}
void Bfield(double x, double y, double z, double * B) {
  B[0] = y / L;
  B[1] = x / L;
  B[2] = 0;
}
