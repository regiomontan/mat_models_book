 // файл vectorUnit.pas
 unit vectorUnit;
 interface
 //----------------------------------
 type Tpoint3D = record
                 x, y, z : double;
                 end;
 //----------------------------------
 type Tvector = class
 protected
 coordinate: Tpoint3D;
 public
 function     get_coord  : Tpoint3D;
 function     get_module : double;
 procedure    normalization;
 constructor  birth( xx, yy, zz: double ); overload;
 constructor  birth( p: Tpoint3d );        overload;
 end;
 //--  векторные операции: -------------------
 function  summ_vectors( v_1, v_2: Tvector ): Tvector;
 function  dot_product( v_1, v_2: Tvector ) : double;
 function  mult_on_scal( k: double; v: Tvector ): Tvector;
 //=====================================
 implementation
 //----------------------------------
 function  Tvector.get_coord: Tpoint3D;
 begin
 result := coordinate;
 end;
 //----------------------------------
 function  Tvector.get_module: double;
 begin
 result := sqrt(   coordinate.x*coordinate.x
                 + coordinate.y*coordinate.y
                 + coordinate.z*coordinate.z );
 end;
 //----------------------------------
 procedure  Tvector.normalization;
 var  module: double;
 begin
 module := get_module;
    if  ( module > 0.0 ) then
    begin
    coordinate.x := coordinate.x/module;
    coordinate.y := coordinate.y/module;
    coordinate.z := coordinate.z/module;
    end;
 end;
 //----------------------------------
 constructor Tvector.birth( xx, yy, zz: double );
 begin
 coordinate.x := xx;
 coordinate.y := yy;
 coordinate.z := zz;
 end;
 //----------------------------------
 constructor Tvector.birth( p: Tpoint3d );
 begin
 coordinate.x := p.x;
 coordinate.y := p.y;
 coordinate.z := p.z;
 end;
 //=====================================
 function summ_vectors( v_1, v_2: Tvector ): Tvector;
 var  c1, c2: Tpoint3D;
 begin
 c1     := v_1.get_coord;
 c2     := v_2.get_coord;
 result := Tvector.birth(c1.x + c2.x, c1.y + c2.y, c1.z + c2.z);
 end;
 //----------------------------------
 function  dot_product( v_1, v_2: Tvector ): double;
 var  c1, c2: Tpoint3D;
 begin
 c1     := v_1.get_coord;
 c2     := v_2.get_coord;
 result := c1.x*c2.x + c1.y*c2.y + c1.z*c2.z;
 end;
 //----------------------------------
 function  mult_on_scal( k: double; v: Tvector ): Tvector;
 var  c: Tpoint3D;
 begin
 c      := v.get_coord;
 result := Tvector.birth( c.x*k, c.y*k, c.z*k );
 end;
 //----------------------------------
 end. // конец файла vectorUnit.pas
