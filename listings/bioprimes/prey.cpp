 // Файл prey.cpp. Класс "Жертва"
 //------------------------------------
 #include "prey.h"
 //------------------------------------
 // приспособленность Жертвы
 //------------------------------------
 double  prey::fitness( const Lint &p, const Lint &q )
 {
  return  ( 1.0 - 2.0*HOD( p, q )/q );
 }
 //------------------------------------
 prey::prey( const Lint &L, const Lint &enemy_term )
      :thing( enemy_term )
 {
  min_bound = L/2 + 2;
  max_bound = L;
  best_period( enemy_term );
 }

