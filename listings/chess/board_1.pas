Type Tboard = class
              protected
              Forma     : TForm;  // �����, ���� �� ��������;
              whiteCell : Tcolor; // ����� ������
              blackCell : Tcolor; // ��������� �����;
              hCell     : word;   // ����� ������� ������;
              // ����� ��� ������ ��� ��������������� �����:
              fig_board : array[1..8, 1..8] of Tid;
              function   get_color_cell( i, j: word ): boolean;
              procedure  draw;
              // �� ������� ������ ���������� ������ �����: 
              function   search_rect( pos: Tposition ): TRect;
              procedure  show_figures;
              // ��������� �����:
              procedure  draw_queen( pos  :TPosition; 
                                     color:Tfigcolor );
              procedure  draw_rook ( pos  :TPosition; 
                                     color:Tfigcolor );
              // ����� ����� ���� ������ ������...
              public
              // �� ����������� ����� ���������� �������:
              function    search_pos( X, Y: word ): Tposition;
              // ������ ID ������ � ������ fig_board: 
              procedure   entry_fig_board( ID: Tid );
              procedure   refresh;
              constructor init( white_cell, black_cell: Tcolor;
                                h_cell : word; form : TForm );
              end;
