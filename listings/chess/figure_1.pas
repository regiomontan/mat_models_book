implementation
// ��� ������ � ������� to_position
//------------------------------------
procedure  Tfigure.move( to_position: Tposition);
var tempID : Tid;
begin
  if ( can_move( to_position ) )         // ���� ��� �������-
  then  begin                            // ���, ������ ������
        tempID := ID;                    // ��������� � "�����"
        tempID.number := 0;              // (�0 - ��� ������),  
       board.entry_fig_board( tempID );  // ������ �����������
        ID.pos := to_position;           // � ������ �������;
       board.entry_fig_board( ID );
        end;
board.refresh;
end;
