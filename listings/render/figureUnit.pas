 // файл figureUnit.pas
 unit figureUnit;
 interface
 uses vectorUnit, colorUnit;
 //-----------------------------------
 type  Tfigure = class
 protected
 center     : Tvector;   // центр фигуры;
 normal     : Tvector;   // нормаль;
 reflected  : Tvector;   // отражённый луч;
 color      : Tcvet;     // цвет;
 n_spec     : double;    // показатель отражения;
 v_spec     : double;    // коэффициент отражения;
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
 // определяет отражённый в т. p луч, incident - падающий луч
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
 // возвращает отражённый в т. p луч, incident - падающий луч
 //-----------------------------------
 function Tfigure.get_reflected(incident, p: Tvector): Tvector;
 begin
 set_reflected( incident, p );
 result := reflected;
 end;
 //-----------------------------------
 // возвращает коэффициент диффузии в т. p при направлении 
 // на осветитель light_direction
 //-----------------------------------
 function Tfigure.get_diff(p, light_direction: Tvector): double;
 begin
 set_normal( p );
 result := dot_product( light_direction, normal );
 end;
 //-----------------------------------
 // возвращает коэффициент отражения в т. p при направлениях
 // на осветитель light_direction, из камеры -- ray_direction
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
 end.  // конец файла figureUnit.pas
