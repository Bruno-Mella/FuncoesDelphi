unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ACBrDelphiZXingQRCode;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function CriarQRcodeBitmap(Texto: String): TBitmap;
var
  QRCode: TDelphiZXingQRCode;
  QRCodeBitmap: TBitmap;
  Row, Column: Integer;
begin
  QRCode := TDelphiZXingQRCode.Create;
  QRCodeBitmap := TBitmap.Create;
  try
    QRCode.Encoding := qrUTF8BOM;
    QRCode.QuietZone := 4;  // Ajuste conforme necessário
    QRCode.Data := WideString(Texto);

    QRCodeBitmap.Width  := QRCode.Columns;
    QRCodeBitmap.Height := QRCode.Rows;

    for Row := 0 to QRCode.Rows - 1 do
    begin
      for Column := 0 to QRCode.Columns - 1 do
      begin
        if QRCode.IsBlack[Row, Column] then
          QRCodeBitmap.Canvas.Pixels[Column, Row] := clBlack
        else
          QRCodeBitmap.Canvas.Pixels[Column, Row] := clWhite;
      end;
    end;

    Result := QRCodeBitmap;
  finally
    QRCode.Free;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
   close;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  QRCodeBitmap: TBitmap;
begin
  QRCodeBitmap := CriarQRcodeBitmap(Edit1.Text);
  try
    Image1.Picture.Bitmap.Assign(QRCodeBitmap);
  finally
    QRCodeBitmap.Free;
  end;
end;

end.
