
 #include <iostream>
 #include <stdio.h>
 #include "cell_bits.h"
 using namespace std;
 //------------------------------------
 int  main( int argc, char *argv[] )
 {
  const int   rule_number = 90;
  const Lint  number      = 1ULL << 31;
  const int   dimension   = 62;
  int         iteration   = 32;
  cout << endl << " Rule " << rule_number << endl << endl;
  cell_auto  *CA  = new cell_auto( rule_number,  
                                   number, 
                                   dimension  );
      if ( CA->get_error() )
      {
       cout << "Input error!" << endl;
       delete CA;
       getchar();
       return 1;
      }
  boolvect *init  = CA->get_init_generation();
      for ( int i = init->size() - 1; i >= 0; --i )
      {
       //cout << (*init)[ i ];
           if ( (*init)[ i ] ) cout << (char)254;
           else                cout << " ";
      }
  cout << "   = " << CA->decimal( init ) <<  endl;
      for ( int  i = 1; i <= iteration; ++i )
      {
       CA->next_generation();
       boolvect *gen   = CA->get_curr_generation();
          // вывод в двоичном виде:
          for ( int i = gen->size() - 1; i >= 0; --i )  
          {
           //cout << (*gen)[ i ];
               if    ((*gen)[ i ] )   cout << (char)254;
               else                   cout << " ";
          }
       // вывод в десятичном виде:
       cout << "   = " << CA->decimal( gen ) <<  endl;  
      }
  delete CA;
  //getchar();
  return 0;
 }
