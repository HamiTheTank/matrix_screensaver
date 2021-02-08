unit Main01;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Image1: TImage;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private

  public

  end;

  character = class
    private

      canvas : TCanvas;
      currentX : integer;
      Y_poz: array[0..15] of integer;
      letter: array[0..15] of char;

      procedure show();

    public
      constructor create(x: integer);
      procedure fall();

  end;



const
     FONT_SIZE = 8;
     SPACING = 1; // between the columns
     SPEED = 70; // smaller is faster. 70 default
     Delay_1 = 3000; // stop showing "Wake up, Neo..."
     Delay_2 = 5000; // start showing "The Matrix has you..."
     Delay_3 = 8000; // start animation

var

  Form1: TForm1;
  chars : array[0..66] of character;
  elapsed : Cardinal;



implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
var i: integer;
begin


  elapsed := 0;
  Timer1.Enabled := false;

  form1.Image1.Canvas.Brush.Color:= clBlack;
  form1.Image1.Canvas.Brush.Style:= bsSolid;
  form1.Image1.Canvas.Font.Size:= FONT_SIZE;
  Form1.Image1.canvas.Font.Color:= clWhite;
  form1.Image1.Canvas.Pen.Style:= psClear;




  Form1.Image1.Canvas.TextOut((image1.Width div 2) - 30,(image1.Height div 2) - 5,'Wake up, Neo...');

  randomize();

  for i:=0 to length(chars) - 1 do
  begin
   chars[i] := character.create(i*(form1.Image1.Canvas.Font.Size + SPACING));
  end;

  Timer1.Interval := SPEED;

  Timer1.Enabled := True;

end;




procedure TForm1.Timer1Timer(Sender: TObject);
var i: integer;
begin

  elapsed := elapsed + Timer1.Interval;



  if elapsed < Delay_1 then exit;


  if elapsed < Delay_2 then
  begin

      Form1.Image1.canvas.FillRect(200,100,400,200);

      exit ;

  end;


  if (elapsed > Delay_2) and (elapsed < Delay_3) then
  begin

      //form1.Image1.Canvas.Brush.Style:= bsClear;
      form1.Image1.Canvas.pen.Style := psClear;
      Form1.Image1.Canvas.TextOut((image1.Width div 2) - 50,(image1.Height div 2) - 3,'The Matrix has you...');

       exit ;

  end;


  form1.Image1.Canvas.Brush.Style:= bsSolid;
  form1.Image1.Canvas.pen.Style:=psSolid;

  //ANIMATION START
  for i:=0 to length(chars) - 1 do
  begin
   chars[i].fall();
  end;


end;



constructor character.create(x: integer);
var i : integer;
begin

  canvas := form1.Image1.Canvas;

  currentX := x;
  Y_poz[0] := random(280);
  letter[0] := chr(random(127 - 33) + 33);

  for i:= 1 to length(Y_poz) - 1 do
  begin
     Y_poz[i] := 999;
     letter[i] := chr(0);
  end;

end;

procedure character.show();
var i: integer;
begin

  for i:=0 to length(Y_poz)-1 do
    begin
      if Y_poz[i] <> 999 then
      begin

          case i of
            0 : canvas.Font.Color:= clWhite;
            12 : canvas.Font.Color:= clGreen;
            13 : canvas.Font.Color:= clGreen;
            14 : canvas.Font.Color:= clGreen;
            15 : canvas.Font.Color:= clBlack;
            else
            begin
                 canvas.Font.Color:= clYellow;
            end;
          end;

          canvas.TextOut(currentX, Y_poz[i], letter[i]);

      end;
    end;



end;

procedure character.fall();
var i: integer;
begin

  for i:=length(Y_poz)-1 downto 1 do
  begin
    if Y_poz[i-1] <> 999 then
    begin

         Y_poz[i] := Y_poz[i-1];

        letter[i] := letter[i-1];

    end;
  end;


  if Y_poz[0] > 280 then
     Y_poz[0] := 0
  else
      Y_poz[0] := Y_poz[0] + 15;


  letter[0] := chr(random(127 - 33) + 33);

  show();

end;







END.

