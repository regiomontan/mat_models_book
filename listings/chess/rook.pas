// ���� rook.pas
unit rook;
interface
uses figure, board;
//------------------------------------
Type Trook = class( Tfigure ) // ����� �����
             protected
             function  can_move(
                                 to_position: Tposition
                                 ): Boolean;  override;
             public
             constructor Init( ident: Tid; chessBoard: Tboard );
             destructor  delete;
             end;
//------------------------------------
implementation
//------------------------------------
//  ����� �� ����� ���� � to_position
//------------------------------------
function  Trook.can_move( to_position: Tposition ): Boolean;
begin
result := ( ID.pos.x = to_position.x )
           OR ( ID.pos.y = to_position.y );
end;
//------------------------------------
constructor Trook.Init( ident: Tid; chessBoard: Tboard );
begin
inherited  Init( ident, chessBoard );
end;
//------------------------------------
destructor  Trook.delete;
begin
inherited delete;
end;
end. // ����� ����� rook.pas
