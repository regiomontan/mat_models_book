 // ���� predator.h. ����� "������"
 //------------------------------------
 #ifndef  _PREDATOR_H_
 #define  _PREDATOR_H_
 #include  "thing.h"
 //------------------------------------
 class predator: public thing
 {
  virtual  double  fitness( const Lint &p,   // ������������-
                            const Lint &q ); // ����� �������;
  public:
            predator( const Lint &L, const Lint &enemy_term );
  virtual  ~predator() {};
 };
 #endif

