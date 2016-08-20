// файл chessMain.pas
unit chessMain;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, figure, queen, rook, board,
  StdCtrls, ComCtrls, Menus, ExtCtrls;
//----------------------------------  
type  TForm1 = class( TForm )
      StatusBar1   : TStatusBar;
      MainMenu1    : TMainMenu;
      menuFile     : TMenuItem;
      MenuExit     : TMenuItem;
      menuAbout0   : TMenuItem;
      menuAbout    : TMenuItem;
      RadioGroup1  : TRadioGroup;
      procedure FormActivate( Sender: TObject );
      procedure FormMouseMove( Sender : TObject;
                                   Shift  : TShiftState;
                                   X, Y   : Integer     );
      procedure FormMouseDown( Sender : TObject;
                                   Button : TMouseButton;
                                   Shift  : TShiftState;
                                   X, Y   : Integer     );
      procedure MenuExitClick( Sender: TObject );
      procedure menuAboutClick( Sender: TObject );
      procedure RadioGroup1Click( Sender: TObject );
      procedure FormPaint(Sender: TObject);
      private
      { Private declarations }
      public
      { Public declarations }
      end;
var    Form1       : TForm1;
       h           : word;    // ширина клетки доски;
       chess_board : Tboard;  // объект Шахматная доска;
       queen       : Tqueen;  // объект Ферзь;
       rook        : Trook;   // объект Ладья;
       ID          : Tid;     // идентификатор фигуры;
const  whiteCell = clSilver;  // цвета клеток
       blackCell = clGray;    // шахматной доски;
implementation
{$R *.dfm}
//----------------------------------
// инициализация ферзя (ID.number ферзя равен 2)
//----------------------------------
procedure init_queen;
begin
  if ( ID.number = 2 ) then exit;
  if ( ID.number = 3 ) then rook.delete;
ID.number := 2;
queen := Tqueen.Init( ID, chess_board );
queen.move( ID.pos );
end;
//----------------------------------
// инициализация ладьи (ID.number ладьи равен 3)
//----------------------------------
procedure init_rook;
begin
  if ( ID.number = 3 ) then  exit;
  if ( ID.number = 2 ) then  queen.delete;
ID.number := 3;
rook := Trook.Init( ID, chess_board );
rook.move( ID.pos );
end;
//----------------------------------
// инициализация шахматной доски bord
//----------------------------------
procedure TForm1.FormActivate( Sender: TObject );
begin
form1.Width  := 600;
form1.Height := 540;
h:= ( form1.Width - 210 ) div 8;
chess_board := Tboard.init( whiteCell,blackCell, h, Form1 );
chess_board.refresh;
StatusBar1.SimpleText := 'click board';
ID.pos.x    := _e;
ID.pos.y    := 2;
ID.color    := white;
ID.number   := 0;
end;
//----------------------------------
// по "мышиным" координатам выводит в статусную строку
// координаты клетки под курсором мыши
//----------------------------------
procedure TForm1.FormMouseMove( Sender: TObject;
                                     Shift : TShiftState;
                                     X, Y  : Integer       );
var pos : Tposition;
begin
pos := chess_board.search_pos( X, Y );
StatusBar1.SimpleText :=  ' ' + chr( 65 + ord(pos.x) ) +
                          ' ' + IntToStr( 9 - pos.y );
end;
//----------------------------------
// по щелчку на клетке доски двигает в неё фигуру
//----------------------------------
procedure TForm1.FormMouseDown( Sender : TObject;
                                     Button : TMouseButton;
                                     Shift  : TShiftState;
                                     X, Y   : Integer       );
begin
ID.pos := chess_board.search_pos( X, Y );
  if ( ID.number = 2 )  then  queen.move( ID.pos );
  if ( ID.number = 3 )  then  rook.move( ID.pos );
end;
//----------------------------------
procedure TForm1.MenuExitClick( Sender: TObject );
begin
close;
end;
//----------------------------------
procedure TForm1.menuAboutClick( Sender: TObject );
begin
ShowMessage('Заготовка для шахмат'+ #13#10 +
            'учебный пример' + #13#10 + 'В.Зенкин, 2005 г.');
end;
//----------------------------------
procedure TForm1.RadioGroup1Click( Sender: TObject );
begin
  if RadioGroup1.ItemIndex = 0 then init_queen;
  if RadioGroup1.ItemIndex = 1 then init_rook;
end;
//----------------------------------
procedure TForm1.FormPaint( Sender: TObject );
begin
chess_board.refresh;
end;
end. // конец файла chessMain.pas
