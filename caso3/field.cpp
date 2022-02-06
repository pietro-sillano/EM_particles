#include<iostream>

#include <fstream>

#include<cmath>

#include<iomanip>


using namespace std;
int main() {
  using namespace std;
  ofstream fdata;
  fdata.open("field.dat");
  fdata << setiosflags(ios::scientific);
  fdata << setprecision(12);
  cout << setprecision(5);
  int N = 50;
  double Fx,Fy,Fz,FF;
  
  for (int x = - 1000; x < 1000 ; x+=N){
      for (int y = -1000; y < 1000; y+=N){
        for (int z = -1000; z < 1000; z+=1000){
          Fx = double(y) / 1000;
          Fy = double(x) / 1000;
          Fz = 0;
          FF = Fx*Fx + Fy*Fy + Fz*Fz ;
          fdata << x << "  " << y << "  "  << z << "  " << Fx << "  " << Fy << "  " << Fz<< "  " <<FF <<"  "<<endl;
        }
      }
  }
  
  fdata.close();
  return 0;
}

