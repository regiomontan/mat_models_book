// ���� board.pas
unit board;
interface
uses Forms, Graphics, Types;

Type  Tletter   = ( _a, _b, _c, _d, _e, _f, _g, _h );
Type  Tposition = record
                   x : Tletter;       // ���������� ���������
                   y : 1..8;          // ����� �� �����;
                   end;
type  Tfigcolor = ( black, white );   // ���� �����;
Type  Tid       = record              // ������������� ������;
                  pos   : Tposition;  // ���������;
                  color : Tfigcolor;  // ���� ������;
                  number: 0..16;      // �  ������
                  // 0 - �����������, 1 - ������, 2 - �����,...
                  end;

