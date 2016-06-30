unit analyser;

interface

uses System.SysUtils, FMX.Graphics;
 var

    //sums of values first, then curve values
    aRed, aGreen, aBlue: array [0..255] of Double;

  procedure analyse(ABitmapL, ABitmapR: TBitmap);

implementation
  uses System.UITypes;

  var

    //frequencies
    nRed, nGreen, nBlue : array [0..255] of Double;

  procedure firstNonZero(var a : array of Double);
  var
    first : Double;
    i : integer;
  begin
    first := 0.0;
    i := 0;

    while a[i] = 0 do
    begin
      inc(i)
    end;
    first := a[i];

    i := 0;

    while a[i] = 0 do
    begin
      a[i] := first;
      inc(i)
    end;

  end; //firstNonZero

  procedure lastNonOne(var a : array of Double);
  var
    last : Double;
    i : integer;
  begin
    last := 0;
    i := 255;

    while a[i] = 0 do
    begin
      dec(i)
    end;

    last := a[i];
    i := 255;

    while a[i] = 0 do
    begin
      a[i] := last;
      dec(i)
    end;

  end; //lastNonOne

  procedure analyse(ABitmapL, ABitmapR: TBitmap);
  var
    AlphaL, AlphaR, RedL, RedR, GreenL, GreenR, BlueL, BlueR: System.Byte;
    x, y, i : longint;
    bitdataL, bitdataR: TBitmapData;
    aColor, nColor: TAlphaColor;
  begin
    //init arrays
    for i := 0 to 255 do
    begin
       aRed[i] := 0.0;
       nRed[i] := 0.0;
       aGreen[i] := 0.0;
       nGreen[i] := 0.0;
       aBlue[i] := 0.0;
       nBlue[i] := 0.0;
    end;

     //TODO check that bitmaps should be same size
    if (ABitmapR.Map(TMapAccess.ReadWrite, bitdataR) and (ABitmapL.Map(TMapAccess.ReadWrite, bitdataL))) then
    try
     for y := 0 to ABitmapR.Height - 1 do
        for x := 0 to ABitmapR.Width - 1 do
        begin
          begin
               aColor := bitdataL.GetPixel(x, y);
               nColor := bitdataR.GetPixel(x, y);
               RedR := TAlphaColorRec(nColor).R;
               RedL := TAlphaColorRec(aColor).R;
               aRed[RedL] := aRed[RedL] +  RedR;
               //inc(nRed[RedR]);
               nRed[RedL] := nRed[RedL] + 1.0;

               GreenR := TAlphaColorRec(nColor).G;
               GreenL := TAlphaColorRec(aColor).G;
               aGreen[GreenL] := aGreen[GreenL] +  GreenR;
               //inc(nGreen[GreenR]);
               nGreen[GreenL] := nGreen[GreenL] + 1.0;

               BlueR := TAlphaColorRec(nColor).B;
               BlueL := TAlphaColorRec(aColor).B;
               aBlue[BlueL] := aBlue[BlueL] +  BlueR;
               //inc(nBlue[BlueR]);
               nBlue[BlueL] := nBlue[BlueL] + 1.0;
          end;
        end;

        for i := 0 to 255 do
        begin
          if nRed[i] <> 0 then
          begin
            aRed[i] := aRed[i] / (255.0 * nRed[i]);
          end;
          if aRed[i] > 1.0 then begin aRed[i] := 1.0 end;
          if nGreen[i] <> 0 then
          begin
            aGreen[i] := aGreen[i] / (255.0 * nGreen[i]);
          end;
          if aGreen[i] > 1.0 then begin aGreen[i] := 1.0 end;
          if nBlue[i] <> 0 then
          begin
            aBlue[i] := aBlue[i] / (255.0 * nBlue[i])
          end;
          if aBlue[i] > 1.0 then begin aBlue[i] := 1.0 end;
        end;

        //set first value to non-zero
        firstNonZero(aRed);
        firstNonZero(aGreen);
        firstNonZero(aBlue);

        //set last values to non-one
        lastNonOne(aRed);
        lastNonOne(aGreen);
        lastNonOne(aBlue);

        for i := 1 to 255 do
        begin
          if nRed[i] = 0 then begin aRed[i] := aRed[i-1] end;
          if nGreen[i] = 0 then begin aGreen[i] := aGreen[i-1] end;
          if nBlue[i] = 0 then begin aBlue[i] := aBlue[i-1] end;

        end;

    finally
      ABitmapL.Unmap(bitdataL);
      ABitmapR.Unmap(bitdataR);
    end;

  end; //analyse

end.



             {
                   Red := Round(redCurve[Red]* 255);
                   Green := Round(greenCurve[Green]*255);
                   Blue := Round(blueCurve[Blue] * 255);
                   Alpha := Round(alphaCurve[Alpha]* 255);

               TAlphaColorRec(nColor).A:= Alpha;
               TAlphaColorRec(nColor).R:=  Red;
               TAlphaColorRec(nColor).G:= Green;
               TAlphaColorRec(nColor).B:= Blue;
               bitdata1.SetPixel(i, j, nColor);
               }
