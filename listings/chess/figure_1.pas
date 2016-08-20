implementation
// Ход фигуры в позицию to_position
//------------------------------------
procedure  Tfigure.move( to_position: Tposition);
var tempID : Tid;
begin
  if ( can_move( to_position ) )         // если ход правиль-
  then  begin                            // ный, запись фигуры
        tempID := ID;                    // удаляется с "доски"
        tempID.number := 0;              // (№0 - нет фигуры),  
       board.entry_fig_board( tempID );  // фигура записыается
        ID.pos := to_position;           // в другой позиции;
       board.entry_fig_board( ID );
        end;
board.refresh;
end;
