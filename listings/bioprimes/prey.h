 // Файл prey.h. Класс "Жертва"
 //------------------------------------
 #ifndef   _PREY_H_
 #define   _PREY_H_
 #include  "thing.h"
 //------------------------------------
 class prey: public thing
 {
  virtual  double  fitness( const Lint &p,    // приспособлен-
                            const Lint &q  ); // ность Жертвы;
  public:
            prey( const Lint &L, const Lint &enemy_term );
  virtual  ~prey() {};
 };
 #endif

