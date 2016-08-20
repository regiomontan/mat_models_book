 //------------------------------------
 // файл cell_bits.cpp 
 //------------------------------------
  #include "cell_bits.h"
 //------------------------------------
 cell_auto::cell_auto( const int  &rulenumber, 
                       const Lint &number,
                       const int  &dimension_automata )
           : L(dimension_automata), rule_number(rulenumber%256)
 {
  init_generation  = new  boolvect( L, 0 );    // <- 000...0;
  curr_generation  = new  boolvect( L, 0 );    // <- 000...0;
  ERROR            = 0;
  // max число, которое влезет в строку, 2^63 -1:
  const Lint  max_number = ( 1ULL << L ) - 1;   
      if ( number > max_number )                
      {
       ERROR = 1;
      }
      else
      {
          for ( int  i = L - 1; i >= 0; i-- )
          {
           (*init_generation)[i]= ((number & (1ULL<<i))>>i);
          }
       curr_generation = init_generation;
      }
 }
 //------------------------------------
 cell_auto::cell_auto( const cell_auto &s )
           : L( s.L ), rule_number( s.rule_number % 256 )
 {
  init_generation = s.init_generation;
  curr_generation = s.curr_generation;
 }
 //------------------------------------
 cell_auto&   cell_auto::operator=( const  cell_auto &s )
 {
      if ( this != &s )
      {
       init_generation = s.init_generation;
       curr_generation = s.curr_generation;
      }
  return *this;
 }
 //------------------------------------
 cell_auto::~cell_auto()
 {
      if ( init_generation )  delete  init_generation;
      if ( curr_generation )  delete  curr_generation;
 }
 //------------------------------------
 // ѕравила клеточного автомата (rule update function):
 //------------------------------------
 bool cell_auto::rule( int i )
 {
  bool          next_generation_i = 0;
  unsigned int  left_i            = i + 1;
  unsigned int  right_i           = i - 1;
      if ( i == L - 1 )  left_i  = 0;        // краевые случаи, 
      if ( i == 0     )  right_i = L - 1;    // замыкание ленты;
  unsigned int prod_3cell = 4*(*curr_generation)  [left_i] 
                            + 2*(*curr_generation)[i]
                            + (*curr_generation)  [right_i];
      switch ( prod_3cell )
      {
       case 7: next_generation_i=((rule_number & (1<<7))>>7);
                break;
       case 6: next_generation_i=((rule_number & (1<<6))>>6);
                break;
       case 5: next_generation_i=((rule_number & (1<<5))>>5);
                break;
       case 4: next_generation_i=((rule_number & (1<<4))>>4);
                break;
       case 3: next_generation_i=((rule_number & (1<<3))>>3);
                break;
       case 2: next_generation_i=((rule_number & (1<<2))>>2);
                break;
       case 1: next_generation_i=((rule_number & (1<<1))>>1);
                break;
       case 0: next_generation_i=( rule_number &  1 );
                break;
       default: ERROR = 1;
      }
  return  next_generation_i;
 }
 //------------------------------------
 void  cell_auto::next_generation()
 {
  boolvect *temp_generation = new boolvect(L, 0);  // <- 0...0;
      for ( int  i = 0; i < L; i++ )
      {
       (*temp_generation)[i] = rule(i);
      }
  curr_generation = temp_generation;
 }
 //------------------------------------
 boolvect*  cell_auto::get_init_generation()
 {
  return  init_generation;
 }
 //------------------------------------
 boolvect*  cell_auto::get_curr_generation()
 {
  return  curr_generation;
 }
 //------------------------------------
 Lint  cell_auto::decimal( boolvect* bit_vector )
 {
  Lint  decimal_number = 0;
      for ( int i = 0; i < L; ++i )
      {
          if ((*bit_vector)[i]) decimal_number += (1ULL << i);
      }
  return  decimal_number;
 }
 //------------------------------------
 int  cell_auto::get_error()
 {
  return  ERROR;
 }
 // конец  файла cell_bits.cpp -------------------
