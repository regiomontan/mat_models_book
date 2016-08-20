 //------------------------------------
 // Файл cell_bits.h. 
 //------------------------------------
 #ifndef   CELLS_BITS_H_
 #define   CELLS_BITS_H_
 #include  <vector>
 typedef   unsigned long long int  Lint;
 typedef   std::vector<bool>       boolvect;
 //------------------------------------
 class  cell_auto
 {
  boolvect      *init_generation;  // указ. на исх. поколение;
  boolvect      *curr_generation;  // указ. на текущ. поколение;
  const  int     L;                // число клеток в строке;
  const  int     rule_number;
  int            ERROR;
  public:
  bool           rule(int i);
  void           next_generation();
  Lint           decimal(boolvect* bit_vector);
  boolvect*     get_init_generation();
  boolvect*     get_curr_generation();
  int            get_error();
                 cell_auto( const int  &rulenumber,  
                            const Lint &number,
                            const int  &dimension_automata );
                 cell_auto( const  cell_auto &s );
  cell_auto&     operator=( const  cell_auto &s );
  virtual       ~cell_auto();
 };
 #endif
 //-- конец файла  cell_bits.h -------------------
