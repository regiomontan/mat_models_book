 // файл rayUnit.pas
 unit rayUnit;
 interface
 uses vectorUnit, colorUnit;
 //----------------------------------
 Type Tray = class( Tvector )
 protected
 color              : Tcvet;
 public
 function  get_source : Tvector;
 function  get_color  : Tcvet;
 constructor  birth( x0, y0, z0: double;
                     RR, GG, BB: integer  ); overload;
 constructor  birth( p0 :        Tpoint3d;
                     CC :        Tcvet    ); overload;
 end;
 //----------------------------------
 implementation
 //----------------------------------
 function  Tray.get_source: Tvector;
 begin
 result := Tvector.birth( coordinate.x,
                          coordinate.y,
                          coordinate.z  );
 end;
 //----------------------------------
 function  Tray.get_color: Tcvet;
 begin
 result := color;
 end;
 //----------------------------------
 constructor  Tray.birth( x0, y0, z0: double;
                          RR, GG, BB: integer );
 begin
 inherited birth( x0, y0, z0 );
 color.R := RR; color.G := GG; color.B := BB;
 end;
 //----------------------------------
 constructor  Tray.birth( p0 : Tpoint3d; CC: Tcvet );
 begin
 inherited birth( p0 );
 color := CC;
 end;
 //----------------------------------
 end. // конец файла rayUnit.pas
