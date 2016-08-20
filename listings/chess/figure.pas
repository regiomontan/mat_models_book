// ���� figure.pas
unit figure;
interface
uses board;
//------------------------------------
// ����� ��������� ������
//------------------------------------
Type Tfigure = class
               protected
               ID       : Tid;        // ������������� ������;
               board    : Tboard;     // ������������ board;
               function  can_move(    // ������������ ����;
                                    to_position: Tposition
                                 ): Boolean; virtual; abstract;
               public
               procedure   move ( to_position: Tposition);
               constructor Init ( ident      : Tid;
                                  chessBoard : Tboard );
               destructor  delete;
               end;

