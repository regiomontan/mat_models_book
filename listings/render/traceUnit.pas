 // файл traceUnit.pas, инициализация и трассировка сцены
 unit traceUnit;
 interface
 uses  vectorUnit, figureUnit, rayUnit, colorUnit, sphereUnit;

 const numb_spheres    = 5;        // количество сфер;
       depth_recursion = 12;       // глубина рекурсии;
       max_dist        = 1000.0;   // макс. длина трассировки;

 var   backgr_color     : Tcvet;   // цвет фона;
       eye_position     : Tpoint3D;// положение камеры;
       lamp             : Tray;    // источник света;
       sphere           : array[1..numb_spheres] of Tsphere;
       recursion        : integer; // № рекурсии;

 procedure init_scene;
 function  trace( ray_source, ray_direction: Tvector ): Tcvet;
 procedure delete_scene;

 implementation
 //-----------------------------------
 procedure init_scene;             // эти данные лучше хранить
 var  center: Tvector;             // в файле специального
      color : Tcvet;               // формата описания сцены;
 begin
 backgr_color.R := 10; backgr_color.G := 10; 
 backgr_color.B := 30;
 lamp      := Tray.birth( 0, 4, 2, 255, 255, 255 );
 center    := Tvector.birth( 0, -3, 10 );
 color.R   := 255; color.G := 255; color.B := 255;
 sphere[1] := Tsphere.birth( center, color, 5, 0.4, 4.0  );
 center    := Tvector.birth( 3.0, -1.0, 5 );
 color.R := 5; color.G := 255; color.B := 5;
 sphere[2] := Tsphere.birth( center, color, 1, 0.01, 1.5 );
 center    := Tvector.birth( -3.0, -1.0, 5 );
 color.R := 55; color.G := 255; color.B := 255;
 sphere[3] := Tsphere.birth( center, color, 5, 0.01, 1.5 );
 center    := Tvector.birth( 0, 3.0, 8 );
 color.R := 255; color.G := 10; color.B := 10;
 sphere[4] := Tsphere.birth( center, color, 2, 0.1, 2.1 );
 center    := Tvector.birth( 0, -2.5, 4 );
 color.R := 255; color.G := 255; color.B := 10;
 sphere[5] := Tsphere.birth( center, color, 1, 0.08, 1.5 );
 end;
 //-----------------------------------
 //  трассировщик
 //-----------------------------------
 function trace( ray_source, ray_direction: Tvector ): Tcvet;

 var  t, tt, diff_koeff, spec_koeff, min_t, spec    : double;
      color, diff_color, spec_color, plus_color     : Tcvet;
      SHADOWED                                      : boolean;
      trace_point, light_direction, reflect, tmp,tm : Tvector;
      i, id                                         : integer;

 begin
 inc( recursion );
 color := backgr_color;
 id    := numb_spheres + 1;
 min_t := max_dist;
    for i := 1 to numb_spheres do
    begin
    t := sphere[i].intersection( ray_source, ray_direction );
       // ближайшее пересечение сферы с индексом
       // id с лучом на расстоянии min_t:
       if ( t >= 0 ) AND ( t < min_t ) then
       begin
       min_t := t;
       id    := i;
       color := sphere[id].get_color;
       end;
    end;
    if   ( id = numb_spheres + 1 ) // луч никуда не попал
    then   color := backgr_color   // -- вернуть цвет фона,
    else                           // иначе -- расчёт цвета
    begin                          // точки пересечения:
    tmp := mult_on_scal( min_t, ray_direction );
    trace_point := summ_vectors( ray_source, tmp );
    tmp.Free;
    tmp := mult_on_scal( -1, trace_point );
    tm  := lamp.get_source;
    light_direction := summ_vectors( tmp, tm );
    tmp.Free; tm.Free;
    light_direction.normalization;
    // отражённый луч:
    reflect := sphere[id].get_reflected( ray_direction,
                                         trace_point    );
    // освещение - затенённость другой сферой:
    SHADOWED := FALSE;
       for i := 1 to numb_spheres do
       begin
       tt := sphere[i].intersection( trace_point,
                                     light_direction );
          if  ( ( tt > 0  ) AND ( i <> id ) ) then
          begin
          SHADOWED := TRUE;
          color := mult_colors( sphere[id].get_color, 0.2 );
          break;
          end;
       end; // конец теста затенённости;
       if ( SHADOWED = FALSE ) then
       begin
       // освещение - диффузное  освещение:
       diff_koeff := sphere[id].get_diff( trace_point,
                                          light_direction );
       diff_color := mult_colors( lamp.get_color, diff_koeff );
       color := mix_colors( color, diff_color );
       // освещение - specular-ое освещение:
          if ( sphere[id].get_value_spec > 0 ) then
          begin
          spec_koeff := sphere[id].get_spec( trace_point,
                                             ray_direction,
                                             light_direction );
            if ( ( spec_koeff > diff_koeff )
                  AND ( diff_koeff > 0 )      ) then
            begin
            spec_color := mult_colors(lamp.get_color, spec_koeff);  
            spec_color := mix_colors(spec_color, 
                                     sphere[id].get_color);
            color := mix_colors( color, spec_color );
            end;
          end;
        end; // if ( SHADOWED = FALSE )...
       // отражение (рекурсивные вызовы):
       if  ( recursion <= depth_recursion ) then
       begin
       spec := sphere[id].get_value_spec;
          if  ( spec > 0.0 ) then
          begin
          plus_color := trace( trace_point, reflect );
          plus_color := mult_colors( plus_color, spec );
          color := mix_colors( color, plus_color );
          end;
        end;
    trace_point.Free;
    light_direction.Free;
    reflect.Free;
    end; // else if( id = numb_spheres + 1 )...
 result := color;
 end;
 //-----------------------------------
 procedure delete_scene;
 var  i: integer;
 begin
 lamp.Free;
    for i := 1 to numb_spheres do
    sphere[i].Free;
 end;
 //-----------------------------------
 end. // конец файла traceUnit.pas
