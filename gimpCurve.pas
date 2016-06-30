unit gimpCurve;

interface
  procedure dumpCurve(name: string; var red, green, blue : array of Double);
implementation

  uses System.SysUtils;

  procedure dumpCurve(name: string; var red, green, blue : array of Double);
  var
    f : TextFile;
    i : Integer;
    fl : string;
  begin
    AssignFile(f, name);
    rewrite(f);
    WriteLn(f, '# GIMP curves tool settings');
    WriteLn(f, '(time 0)');
    WriteLn(f, '(channel value)');
    WriteLn(f, 'curve');
    WriteLn(f, '   (curve-type smooth)');
    WriteLn(f, '   (n-points 17)');
    WriteLn(f, '   (points 34');
    for I := 0 to 33 do
    begin
        Write(f, ' -1.0');
    end;
    WriteLn(f, '")');
    WriteLn(f,     '(n-samples 256)');
    Write  (f,     '(samples 256 ');
    //DecimalSeparator := '.';
    // alpha
    for i := 0 to 255 do
    begin
      fl := FloatToStrF(i/255, TFloatFormat.ffFixed, 7, 6);
    end;

    CloseFile(f);
  end; //dumpCurve

end.
