unit UfrmBase;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs;

type

  { TfrmBase }

  TfrmBase = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmBase: TfrmBase;

implementation

uses Uvariaveisbase;

{$R *.lfm}

{ TfrmBase }

procedure TfrmBase.FormCreate(Sender: TObject);
begin
  caption := 'OpenVarejo' + '.: ' + nomeform + ' :..';
end;

end.

