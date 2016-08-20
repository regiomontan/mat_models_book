// файл board.pas
unit board;
interface
uses Forms, Graphics, Types;

Type  Tletter   = ( _a, _b, _c, _d, _e, _f, _g, _h );
Type  Tposition = record
                   x : Tletter;       // координаты шахматных
                   y : 1..8;          // фигур на доске;
                   end;
type  Tfigcolor = ( black, white );   // цвет фигур;
Type  Tid       = record              // идентификатор фигуры;
                  pos   : Tposition;  // положение;
                  color : Tfigcolor;  // цвет фигуры;
                  number: 0..16;      // №  фигуры
                  // 0 - отсутствует, 1 - король, 2 - ферзь,...
                  end;

