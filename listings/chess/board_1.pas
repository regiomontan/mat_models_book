Type Tboard = class
              protected
              Forma     : TForm;  // форма, куда всё рисуется;
              whiteCell : Tcolor; // цвета клетки
              blackCell : Tcolor; // шахматной доски;
              hCell     : word;   // длина стороны клетки;
              // доска как массив для идентефикаторов фигур:
              fig_board : array[1..8, 1..8] of Tid;
              function   get_color_cell( i, j: word ): boolean;
              procedure  draw;
              // по позиции фигуры определяет клетку доски: 
              function   search_rect( pos: Tposition ): TRect;
              procedure  show_figures;
              // рисование фигур:
              procedure  draw_queen( pos  :TPosition; 
                                     color:Tfigcolor );
              procedure  draw_rook ( pos  :TPosition; 
                                     color:Tfigcolor );
              // здесь могут быть другие фигуры...
              public
              // по координатам доски определяет позицию:
              function    search_pos( X, Y: word ): Tposition;
              // запись ID фигуры в массив fig_board: 
              procedure   entry_fig_board( ID: Tid );
              procedure   refresh;
              constructor init( white_cell, black_cell: Tcolor;
                                h_cell : word; form : TForm );
              end;
