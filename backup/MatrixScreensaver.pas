

{$mode objfpc}
{$m+}

program MatrixScreensaver;
uses crt;

var
   console_width : DWord;
   console_height : DWord;
   i,counter,tmp1: integer;

type character = class

     private
            currentX: integer;
            currentY: integer;
            currentChar: char;
            //procedure remove();
     public
            constructor create(x, y : integer);
            procedure fall();
            procedure show();

end;

    var
       mychars : array [0..119] of character;


constructor character.create(x, y : integer);
begin
     currentX := x;
     currentY := y;
     currentChar := chr( random(255) );
end;

procedure character.fall();
var i: integer;
begin
     crt.TextColor(crt.Green);

     for i:=0 to 30 do
     begin
       currentY := currentY + random(2 + 1);
       currentChar := chr( random(255) );
       show();
       delay(20);
     end;


end;

procedure character.show();
begin

     crt.TextColor(crt.White);
     crt.GotoXY(currentX, currentY);
     write(currentChar);

end;





BEGIN



 console_width := crt.WindMaxX;
 console_height := crt.WindMaxY;

 randomize();


  for i:=0 to 10 do

  begin
    tmp1:= random(30);
    mychars[i] := character.create(tmp1, 1);
  end;

  for i:=0 to 10 do
  begin

    mychars[i].fall();

  end;


  //readln();


END.

