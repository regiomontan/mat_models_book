 // ���� figureUnit.pas
 unit figureUnit;
 interface
 uses vectorUnit, colorUnit;
 //-----------------------------------
 type  Tfigure = class
 protected
 center     : Tvector;   // ����� ������;
 normal     : Tvector;   // �������;
 reflected  : Tvector;   // ��������� ���;
 color      : Tcvet;     // ����;
 n_spec     : double;    // ���������� ���������;
 v_spec     : double;    // ����������� ���������;
 procedure set_normal( point: Tvector ); virtual; abstract;
 procedure set_reflected( incident, p: Tvector );
 public
 function  get_reflected( incident, p: Tvector ): Tvector;
 function  get_diff( p, light_direction: Tvector ): double;
 function  get_spec( p, ray_direction: Tvector;
                     light_direction: Tvector ): double;
 function  get_value_spec: double;
 function  get_color: Tcvet;
 constructor  birth( center0: Tvector; color0: Tcvet;
                     n_spec0, v_spec0: double         );
 end;
 //-----------------------------------
 implementation
 //-----------------------------------
 // ���������� ��������� � �. p ���, incident - �������� ���
 //-----------------------------------
 procedure Tfigure.set_reflected( incident, p: Tvector);
 var  scalar : double;
      tmp    : Tvector;
 begin
 set_normal( p );
 scalar := dot_product( normal, incident );
 tmp := mult_on_scal( -2.0*scalar, normal );
 reflected := summ_vectors( incident, tmp );
 tmp.Free;
 end;
 //-----------------------------------
 // ���������� ��������� � �. p ���, incident - �������� ���
 //-----------------------------------
 function Tfigure.get_reflected(incident, p: Tvector): Tvector;
 begin
 set_reflected( incident, p );
 result := reflected;
 end;
 //-----------------------------------
 // ���������� ����������� �������� � �. p ��� ����������� 
 // �� ���������� light_direction
 //-----------------------------------
 function Tfigure.get_diff(p, light_direction: Tvector): double;
 begin
 set_normal( p );
 result := dot_product( light_direction, normal );
 end;
 //-----------------------------------
 // ���������� ����������� ��������� � �. p ��� ������������
 // �� ���������� light_direction, �� ������ -- ray_direction
 //-----------------------------------
 function Tfigure.get_spec( p              : Tvector;
                            ray_direction  : Tvector;
                            light_direction: Tvector ): double;
 var  scalar : double;
 begin
 scalar := dot_product( reflected, light_direction );
    if  ( scalar < 0.0 )
    then  result := 0.0
    else  result := v_spec*exp( n_spec*ln( scalar ) );
 end;
 //-----------------------------------
 function Tfigure.get_value_spec: double;
 begin
 result := v_spec;
 end;
 //-----------------------------------
 function  Tfigure.get_color: Tcvet;
 begin
 result := color;
 end;
 //-----------------------------------
 constructor Tfigure.birth( center0: Tvector; color0: Tcvet;
                            n_spec0, v_spec0        : double );
 begin
 center    := center0;
 color     := color0;
 n_spec    := n_spec0;
 v_spec    := v_spec0;
 normal    := Tvector.birth( 0, 0, 0 );
 reflected := Tvector.birth( 0, 0, 0 );
 end;
 end.  // ����� ����� figureUnit.pas
