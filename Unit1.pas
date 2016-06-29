unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Image2: TImage;
    btnLoadLeft: TButton;
    btnLoadRight: TButton;
    btnCompare: TButton;
    OpenDialog1: TOpenDialog;
    procedure btnLoadLeftClick(Sender: TObject);
    procedure btnLoadRightClick(Sender: TObject);
    procedure btnCompareClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  leftLoaded, rightLoaded: boolean;

implementation
  uses analyser;

{$R *.fmx}

procedure TForm1.btnCompareClick(Sender: TObject);

begin
   analyser.analyse(Image1.Bitmap, Image2.Bitmap);
end;

procedure TForm1.btnLoadLeftClick(Sender: TObject);
begin
    if OpenDialog1.Execute then begin
     Image1.Bitmap.LoadFromFile(OpenDialog1.FileName);
     //Image1.Scale;
     leftLoaded := true;
     if leftLoaded and rightLoaded then begin btnCompare.Enabled := true end;

    end;
end;

procedure TForm1.btnLoadRightClick(Sender: TObject);
begin
    if OpenDialog1.Execute then begin
     Image2.Bitmap.LoadFromFile(OpenDialog1.FileName);
     //Image2.Scale;
     rightLoaded := true;
     if leftLoaded and rightLoaded then begin btnCompare.Enabled := true end;
    end;
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
  leftLoaded := false;
  rightLoaded := false;
  btnCompare.Enabled := false;
end;

end.
