unit gimpCurve;

interface
  procedure dumpCurve(name: string; var red, green, blue : array of Double);
implementation

  uses System.SysUtils;

  procedure dumpCurve(name: string; var red, green, blue : array of Double);
  var
    f : TextFile;
  begin
    AssignFile(f, name);



    CloseFile(f);
  end; //dumpCurve

end.
