// ���� queen.pas
unit queen;
interface
uses figure, board;
//------------------------------------
Type Tqueen = class( Tfigure ) // ����� �����
             protected
             function  can_move(
                                  to_position: Tposition
                                 ): Boolean;  override;
             public
             constructor Init( ident: Tid; chessBoard: Tboard );
             destructor  delete;
             end;
