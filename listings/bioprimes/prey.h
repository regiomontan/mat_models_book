 // ���� prey.h. ����� "������"
 //------------------------------------
 #ifndef   _PREY_H_
 #define   _PREY_H_
 #include  "thing.h"
 //------------------------------------
 class prey: public thing
 {
  virtual  double  fitness( const Lint &p,    // ������������-
                            const Lint &q  ); // ����� ������;
  public:
            prey( const Lint &L, const Lint &enemy_term );
  virtual  ~prey() {};
 };
 #endif

