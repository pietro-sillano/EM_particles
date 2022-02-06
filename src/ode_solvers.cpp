#include "prototypes.h"


void EulerStep(double x,double *Y,void(*RHSFunc)(double ,double *,double *),double dx,int neq){
  int k;
  double rhs[neq]; 
  RHSFunc(x,Y,rhs);
  
  for (k = 0; k < neq; k++){
    Y[k] += dx*rhs[k];
    }
  }
  
void RK2Step(double t,double *Y,void(*RHSFunc)(double,double *,double *),double h, int neq){
   
  double Y1[neq],k1[neq],k2[neq];
  int i;
  
  RHSFunc(t,Y,k1);
  for (i=0;i<neq;i++)  {
    Y1[i]=Y[i]+0.5*h*k1[i];
  }

  RHSFunc(t+0.5*h,Y1,k2);
  for(i=0;i<neq;i++){
    Y[i]=Y[i]+h*k2[i];
  }
}
  
void RK4Step(double t,double *Y,void(*RHSFunc)(double,double *,double *),double h, int neq){
   
  double Y1[neq],Y2[neq],Y3[neq];
  double k1[neq],k2[neq],k3[neq],k4[neq];
  int i;
  
  //calcolo k1
  RHSFunc(t,Y,k1);
  
  for (i=0;i<neq;i++)  {
    Y1[i]=Y[i]+0.5*h*k1[i];
  }
  //calcolo di k2
  RHSFunc(t+0.5*h,Y1,k2);
  
  for (i=0;i<neq;i++)  {
  Y2[i]=Y[i]+0.5*h*k2[i];
}
  
  //calcolo di k3
  RHSFunc(t+0.5*h,Y2,k3);
  
  
  for (i=0;i<neq;i++)  {
  Y3[i]=Y[i]+h*k3[i];
}
  //calcolo di k4
  RHSFunc(t+h,Y3,k4);
  
  for(i=0;i<neq;i++){
    Y[i]=Y[i]+h/6.*(k1[i]+2.*k2[i]+2.*k3[i]+k4[i]);
  }
}
  
  
void PositionVerlet(double &x,double &v,double (*Acceleration)(double),double dt){
  double acc;
  x+=dt*0.5*v;
  acc=Acceleration(x);
  v+=dt*acc;
  x+=0.5*dt*v;
}
  
  
  
  
  
  
  
  
  
  
