unit UfrmImportaNumero;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, ActnList, StdCtrls, EditBtn, Spin, UfrmBotoesBase, Uvariaveisbase;

type

  { TfrmImportaNumero }

  TfrmImportaNumero = class(TfrmBotoesBase)
    EditEntrada: TEdit;
    LabelEntrada: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmImportaNumero: TfrmImportaNumero;

implementation

uses UfrmCheckout;

{$R *.lfm}

{ TfrmImportaNumero }

procedure TfrmImportaNumero.FormCreate(Sender: TObject);
begin
  nomeform:= 'Importa Número';
  inherited;
end;

procedure TfrmImportaNumero.FormActivate(Sender: TObject);
begin
  Color := StringToColor(Configuracao.CorJanelasInternas);
end;

end.

