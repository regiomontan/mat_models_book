 // Файл thing.cpp. Базовый класс "Особь"
 //------------------------------------
 #include "thing.h"
 #include <iostream>
 //------------------------------------
 // Наибольший общий делитель чисел a, b.
 //------------------------------------
 Lint  thing::HOD( Lint a, Lint  b  )
 {
     while ( ( a > 0 ) && ( b > 0 ) )
         if   ( a > b )  a = a - b;
         else            b = b - a;
 return ( a + b );
 }
 //------------------------------------
 // Подбор наилучшего периода для особи
 //------------------------------------
 void   thing::best_period( const Lint &enemy_term )
 {
  term = min_bound;
    for ( Lint p = min_bound + 1; p <= max_bound; ++p )
      if ( fitness(p, enemy_term) > fitness(term, enemy_term) )
       term = p;
 }
 //------------------------------------
 Lint  thing::period()
 {
  return  term;
 }
 //------------------------------------
 thing::thing( const Lint &enemy_term )
 {
 }

