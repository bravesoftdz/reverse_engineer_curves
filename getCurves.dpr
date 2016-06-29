program getCurves;

uses
  System.StartUpCopy,
  FMX.Forms,
  Unit1 in 'C:\noch\prj\compare\Unit1.pas' {Form1},
  analyser in 'C:\noch\prj\compare\analyser.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
