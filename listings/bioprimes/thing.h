 // Файл thing.h. Базовый класс "Особь"
 //------------------------------------
 #ifndef  _THING_H_
 #define  _THING_H_
 typedef   unsigned long long int   Lint;
 //------------------------------------
 class  thing
 {
  protected:
  Lint     term;          // период появления особи;
  Lint     min_bound;     // границы выбираемого особью
  Lint     max_bound;     // периода, далее зависят от L;
  Lint     HOD( Lint a,
                Lint b ); // Н.О.Д. (a,b);
  // приспособленность особи:
  virtual  double  fitness( const Lint &p, const Lint &q ) = 0;
   // выбор наилучшего периода:
  void     best_period( const Lint &enemy_term );
  public:
  Lint     period();       // возвр. выбранный период;
           thing ( const Lint &enemy_term );
  virtual ~thing() {};
 };
 #endif

