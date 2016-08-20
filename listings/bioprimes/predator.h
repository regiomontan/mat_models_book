 // Файл predator.h. Класс "Хищник"
 //------------------------------------
 #ifndef  _PREDATOR_H_
 #define  _PREDATOR_H_
 #include  "thing.h"
 //------------------------------------
 class predator: public thing
 {
  virtual  double  fitness( const Lint &p,   // приспособлен-
                            const Lint &q ); // ность Хищника;
  public:
            predator( const Lint &L, const Lint &enemy_term );
  virtual  ~predator() {};
 };
 #endif

