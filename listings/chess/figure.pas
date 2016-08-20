// файл figure.pas
unit figure;
interface
uses board;
//------------------------------------
// класс Шахматная фигура
//------------------------------------
Type Tfigure = class
               protected
               ID       : Tid;        // идентификатор фигуры;
               board    : Tboard;     // используется board;
               function  can_move(    // правильность хода;
                                    to_position: Tposition
                                 ): Boolean; virtual; abstract;
               public
               procedure   move ( to_position: Tposition);
               constructor Init ( ident      : Tid;
                                  chessBoard : Tboard );
               destructor  delete;
               end;

