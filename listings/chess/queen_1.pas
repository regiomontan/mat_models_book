implementation
//------------------------------------
//  может ли ферзь идти в to_position
//------------------------------------
function  Tqueen.can_move( to_position: Tposition ): Boolean;
begin
result := ( ID.pos.x = to_position.x )
            OR ( ID.pos.y = to_position.y )
               OR ( Abs( ID.pos.y - to_position.y )  =
                    Abs( ord(ID.pos.x) - ord(to_position.x) ) );
end;
//------------------------------------
constructor Tqueen.Init( ident: Tid; chessBoard: Tboard );
begin
inherited  Init( ident, chessBoard );
end;
//------------------------------------
destructor  Tqueen.delete;
begin
inherited delete;
end;
// конец файла queen.pas
