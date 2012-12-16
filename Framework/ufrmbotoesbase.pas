unit UfrmBotoesBase;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, ActnList, UfrmBase;

type

  { TfrmBotoesBase }

  TfrmBotoesBase = class(TfrmBase)
    actConfirmar: TAction;
    actCancelar: TAction;
    actlBotoes: TActionList;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ImglBotoes: TImageList;
    imgLogo: TImage;
    pnlBottom: TPanel;
    procedure actCancelarExecute(Sender: TObject);
    procedure actConfirmarExecute(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmBotoesBase: TfrmBotoesBase;

implementation

{$R *.lfm}

{ TfrmBotoesBase }

procedure TfrmBotoesBase.actConfirmarExecute(Sender: TObject);
begin
  //
end;

procedure TfrmBotoesBase.actCancelarExecute(Sender: TObject);
begin
  //
end;

end.

