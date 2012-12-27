unit ufrmSplash;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  UfrmBase;

type

  { TfrmSplash }

  TfrmSplash = class(TfrmBase)
    imgTEF: TImage;
    imgBanco: TImage;
    imgECF: TImage;
    imgOperadoras: TImage;
    imgPrincipal: TImage;
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmSplash: TfrmSplash;

implementation

{$R *.lfm}

{ TfrmSplash }

procedure TfrmSplash.FormCreate(Sender: TObject);
begin
  inherited;
  if FileExists('imgSplash\imgPrincipal.jpg') then
    imgPrincipal.Picture.LoadFromFile('imgSplash\imgPrincipal.jpg');
  if FileExists('imgSplash\imgBanco.jpg') then
    imgBanco.Picture.LoadFromFile('imgSplash\imgBanco.jpg');
  if FileExists('imgSplash\imgECF.jpg') then
    imgECF.Picture.LoadFromFile('imgSplash\imgECF.jpg');
  if FileExists('imgSplash\imgTEF.jpg') then
    imgTEF.Picture.LoadFromFile('imgSplash\imgTEF.jpg');
  if FileExists('imgSplash\imgOperadoras.jpg') then
    imgOperadoras.Picture.LoadFromFile('imgSplash\imgOperadoras.jpg');
end;

end.

