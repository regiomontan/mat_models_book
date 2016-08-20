 // файл sphereUnit.pas
 unit sphereUnit;
 interface
 uses  figureUnit, vectorUnit, colorUnit;
 //-----------------------------------
 type  Tsphere = class( Tfigure )
 protected
 radius : double;
 procedure set_normal( point: Tvector ); override;
 public
 function  intersection( ray_origin    : Tvector;
                         ray_direction : Tvector  ): double;
 constructor  birth( center0: Tvector; color0: Tcvet;
                     n_spec0, v_spec0, radius0: double );
 end;
 //-----------------------------------
 implementation
 //-----------------------------------
 // определяет нормаль к сфере в т. point:
 // N = OPoint - OCenter, normal = N/|N|
 //-----------------------------------
 procedure  Tsphere.set_normal( point: Tvector );
 var  tmp : Tvector;
 begin
 tmp := mult_on_scal( -1.0, center );
 normal.Free;
 normal := summ_vectors( point, tmp );
 tmp.Free;
 normal.normalization;
 end;
 //-----------------------------------
 // Возвращает множитель t, на который нужно умножить на-
 // правляющий вектор луча ray_direction, чтобы луч попал 
 // на сферу, если пересечения нет, то возвращает -1.0.
 // Множитель t определяется из векторного уравнения:
 // |ray_origin + t*ray_direction - Center_sphere| = radius,
 //-----------------------------------
 function  Tsphere.intersection( ray_origin    : Tvector;
                                 ray_direction : Tvector
                                ): double;
 var  Center_sphere, V: Tvector;
      t, scalar_dV, d_sqr, v_sqr, discriminant : double;
 begin
 Center_sphere := mult_on_scal( -1.0, center ); 
 V             := summ_vectors( ray_origin, Center_sphere );
 scalar_dV     := dot_product( ray_direction, V );
 d_sqr         := sqr( ray_direction.get_module );
 V_sqr         := sqr( V.get_module );
 discriminant  := sqr(scalar_dV) - d_sqr*(V_sqr - sqr(radius));
    if  ( discriminant < 0 )   then  t := -1.0
    else  t := -scalar_dV - sqrt( discriminant )/d_sqr;
    if  ( abs( t ) < 1.0E-20 ) then  t := -1;
 Center_sphere.Free;
 V.Free;
 result := t;
 end;
 //-----------------------------------
 constructor Tsphere.birth( center0: Tvector; color0: Tcvet;
                            n_spec0, v_spec0, radius0: double );
 begin
 inherited birth( center0, color0, n_spec0, v_spec0 );
 radius := radius0;
 end;
 //-----------------------------------
 end. // конец файла sphereUnit.pas
