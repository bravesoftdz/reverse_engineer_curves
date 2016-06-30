unit gimpCurve;

interface
  procedure dumpCurve(name: string; var red, green, blue : array of Double);
implementation

  uses System.SysUtils;

  procedure writeCurveDesc(var f : TextFile; name : string);
  var
    I : Integer;
  begin
    WriteLn(f, '(time 0)');
    Write  (f, '(channel '); Write (f, name);  WriteLn(f, ')');
    WriteLn(f, '(curve');
    WriteLn(f, '   (curve-type smooth)');
    WriteLn(f, '   (n-points 17)');
    Write  (f, '   (points 34');
    for I := 0 to 33 do
      begin
        Write(f, ' -1.0');
      end;
    WriteLn(f, ')');
    WriteLn(f,     '(n-samples 256)');
    Write  (f,     '(samples 256 ');
  end;

  procedure writeDummyChannel(var f : TextFile);
  var
    i : Integer;
    fl : String;
  begin
    for i := 0 to 255 do
      begin
        fl := FloatToStrF(i/255, TFloatFormat.ffFixed, 7, 6);
        Write (f, ' '); Write (f, fl);
      end;
  end;

  procedure writeChannel(var f : TextFile; var arr : array of Double);
  var
    i : Integer;
    fl : String;
  begin
    for i := 0 to 255 do
      begin
        fl := FloatToStrF(arr[i], TFloatFormat.ffFixed, 7, 6);
        Write (f, ' '); Write (f, fl);
      end;

  end;

  procedure dumpCurve(name: string; var red, green, blue : array of Double);
  var
    f : TextFile;
    i : Integer;

  begin
    AssignFile(f, name);
    rewrite(f);
    WriteLn(f, '# GIMP curves tool settings');

    writeCurveDesc(f, 'value');
    writeDummyChannel(f);
    WriteLn (f, '))');

    writeCurveDesc(f, 'red');
    writeChannel(f, red);
    WriteLn (f, '))');

    writeCurveDesc(f, 'green');
    writeChannel(f, green);
    WriteLn (f, '))');

    writeCurveDesc(f, 'blue');
    writeChannel(f, blue);
    WriteLn (f, '))');

    CloseFile(f);
  end; //dumpCurve

end.
