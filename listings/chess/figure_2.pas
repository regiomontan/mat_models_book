//------------------------------------
// инициализация
//------------------------------------
constructor Tfigure.Init( ident: Tid; chessBoard: Tboard );
begin
ID    := ident;
board := chessBoard;
end;
//------------------------------------
// фигура удаляется с доски
//------------------------------------
destructor  Tfigure.delete;
begin
ID.number := 0;
board.entry_fig_board( ID );
board.refresh;
end;
end. 
// конец файла figure.pas