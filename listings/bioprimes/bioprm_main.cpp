 // Файл bioprm_main.cpp
 // Биологическая модель типа "хищник-жертва"
 // с простыми периодами
 //------------------------------------
 #include <iostream>
 #include <stdio.h>
 #include "predator.h"
 #include "prey.h"
 int main( int argc, char *argv[] )
 {
  const Lint L     = 16;
  Lint pred_period = 2;
  Lint prey_period = L/2 + 2;
  prey *pprey      = new  prey( L, pred_period );
  prey_period      = pprey->period();
  predator *ppred  = new  predator( L, prey_period );
  pred_period      = ppred->period();
  std::cout << "prey period = " << prey_period
            << ", predator = "  << pred_period  << std::endl;
  delete  pprey;
  delete  ppred;
  std::cout << std::endl << "Game over, press Enter";
  getchar();
  return  0;
 }

