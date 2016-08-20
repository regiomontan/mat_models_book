 // �������� ���� mainUnit.pas
 unit  mainUnit;
 interface
 uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms,  Dialogs, vectorUnit, figureUnit, rayUnit,
  colorUnit, ComCtrls, ExtCtrls, StdCtrls, traceUnit, Menus, 
  ExtDlgs;
 //-----------------------------------
 type  TmainForm = class( TForm )
 Panel          : TPanel;
 StatusBar      : TStatusBar;
 renderButton   : TButton;
 cameraBox1     : TGroupBox;
 cameraEdit_x   : TEdit;
 cameraEdit_y   : TEdit;
 cameraEdit_z   : TEdit;
 Label1         : TLabel;
 Label2         : TLabel;
 Label3         : TLabel;
 MainMenu1      : TMainMenu;
 menu_file      : TMenuItem;
 menu_exit      : TMenuItem;
 menu_help      : TMenuItem;
 menu_about     : TMenuItem;
 SavePictDialog : TSavePictureDialog;
 save_picture   : TMenuItem;
 procedure  FormPaint( Sender: TObject );
 procedure  renderButtonClick( Sender: TObject );
 procedure  menu_exitClick(Sender: TObject);
 procedure  menu_aboutClick(Sender: TObject);
 procedure  save_pictureClick(Sender: TObject);
 procedure  FormCreate(Sender: TObject);
 procedure  FormCanResize(     Sender   : TObject;
                           var NewWidth,
                               NewHeight: Integer;
                           var Resize   : Boolean  );
 private
 { Private declarations }
 public
 { Public declarations }
 end;
 //-----------------------------------
 var  mainForm                : TmainForm;
      ImageWidth, ImageHeight : integer;
      bitmap                  : TBitmap;
      EmptyBMP                : boolean;
 implementation
 {$R *.dfm}
 //-----------------------------------
 // ���������� ������ ��� ����������� ����� 
 //-----------------------------------
 procedure TmainForm.FormPaint( Sender: TObject );
 begin
 canvas.Brush.Color := mainForm.Color;
 canvas.FillRect( rect( 0, 0, mainForm.ClientWidth,
                              mainForm.ClientHeight ) );
 ImageWidth  := mainForm.ClientWidth - panel.Width - 20;
 ImageHeight := mainForm.ClientHeight - StatusBar.Height - 20;
 Canvas.Rectangle( 10, 10, ImageWidth + 10, ImageHeight + 10 );
 StatusBar.SimpleText := ' ';
    if ( EmptyBMP = FALSE ) then Canvas.Draw( 10, 10, bitmap );
 end;
 //-----------------------------------
 // ������
 //-----------------------------------
 procedure TmainForm.renderButtonClick( Sender: TObject );
 var  i, j          : integer;
      x, y          : double;
      ray           : Tvector;
      ray_direction : Tvector;
      R_G_B         : Tcvet;
 begin
     try    // ��������� ������ ����� ������:
     begin  // ��������� ������:
     eye_position.x := StrToFloat( cameraEdit_x.Text );
     eye_position.y := StrToFloat( cameraEdit_y.Text );
     eye_position.z := StrToFloat( cameraEdit_z.Text );
     end
     except on EConvertError
     do   begin
          ShowMessage('�������� ���� ������' + #13#10 +
                      '��������� ���������� ./,');
          RenderButton.Enabled := TRUE;
          exit;
          end;
     end;   // ����� ��������� ������ ����� ������;
 init_scene;
 RenderButton.Enabled := FALSE;
 bitmap        := TBitmap.Create;
 bitmap.Width  := ImageWidth;
 bitmap.Height := ImageHeight;
 ray := Tvector.birth( eye_position );
    for  i := 10 to ImageHeight + 10 do
    begin
    y := -(i/( ImageHeight - 1 )*2 - 1 );
    StatusBar.SimpleText := ' ������������ ������ '+IntToStr(i)
                             +'/'+IntToStr( ImageHeight ) ;
      for  j := 10 to ImageWidth + 10 do
      begin
      x:=(j/(ImageWidth - 1) - 0.5)*2*ImageWidth/ImageHeight;
      ray_direction := Tvector.birth( x, y, 3 );
      ray_direction.normalization;
      recursion := 1;
      R_G_B := trace( ray, ray_direction );
      ray_direction.Free;
      Canvas.Pixels[j, i]:=RGB( R_G_B.R, R_G_B.G, R_G_B.B );
      bitmap.Canvas.Pixels[j-10, i-10] := RGB( R_G_B.R,
                                           R_G_B.G, R_G_B.B );
      end;
    end;
 ray.Free;
 delete_scene;
 EmptyBMP := FALSE;
 RenderButton.Enabled := TRUE;
 StatusBar.SimpleText := '����� �����������';
 end;
 //-----------------------------------
 procedure TmainForm.menu_exitClick( Sender: TObject );
 begin
 close;
 end;
 //-----------------------------------
 procedure TmainForm.menu_aboutClick(Sender: TObject);
 begin
 ShowMessage( '����������� �����' + #13#10 + '������� ������'
               + #13#10 + '������ �.�., 2005 �.');
 end;
 //-----------------------------------
 procedure TmainForm.save_pictureClick( Sender: TObject );
 begin
    if ( EmptyBMP ) then ShowMessage('��� ��������!')
    else
       if  ( SavePictDialog.Execute )
       then  bitmap.SaveToFile( SavePictDialog.FileName );
 end;
 //-----------------------------------
 procedure TmainForm.FormCreate( Sender: TObject );
 begin
 EmptyBMP := TRUE;
 end;
 //-----------------------------------
 // ����������� �������� ��� ��������� ������� �����
 //-----------------------------------
 procedure TmainForm.FormCanResize(     Sender    : TObject;
                                    var NewWidth,
                                        NewHeight : Integer;
                                    var Resize    : Boolean  );
 begin
   if ( EmptyBMP = FALSE ) then Canvas.Draw( 10, 10, bitmap );
 end;
 end. // ����� ����� mainUnit.pas



