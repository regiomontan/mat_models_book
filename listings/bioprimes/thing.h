 // ���� thing.h. ������� ����� "�����"
 //------------------------------------
 #ifndef  _THING_H_
 #define  _THING_H_
 typedef   unsigned long long int   Lint;
 //------------------------------------
 class  thing
 {
  protected:
  Lint     term;          // ������ ��������� �����;
  Lint     min_bound;     // ������� ����������� ������
  Lint     max_bound;     // �������, ����� ������� �� L;
  Lint     HOD( Lint a,
                Lint b ); // �.�.�. (a,b);
  // ����������������� �����:
  virtual  double  fitness( const Lint &p, const Lint &q ) = 0;
   // ����� ���������� �������:
  void     best_period( const Lint &enemy_term );
  public:
  Lint     period();       // �����. ��������� ������;
           thing ( const Lint &enemy_term );
  virtual ~thing() {};
 };
 #endif

