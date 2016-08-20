 // Файл predator.cpp. Класс "Хищник"
 //------------------------------------
 #include "predator.h"
 //------------------------------------
 // приспособленность Хищника
 //------------------------------------
 double  predator::fitness( const Lint &p, const Lint &q )
 {
  return  ( 2.0*HOD( p, q )/q - 1.0 );
 }
 //------------------------------------
 predator::predator( const Lint &L, const Lint &enemy_term )
          :thing( enemy_term )
 {
  min_bound = 2;
  max_bound = L/2 + 1;
  best_period( enemy_term );
 }

