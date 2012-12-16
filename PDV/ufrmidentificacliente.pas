unit UfrmIdentificaCliente;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, ActnList, StdCtrls, maskedit, UfrmBotoesBase;

type

  { TfrmIdentificaCliente }

  TfrmIdentificaCliente = class(TfrmBotoesBase)
    botaoLocaliza: TBitBtn;
    editCpfCnpj: TMaskEdit;
    editIDCliente: TMaskEdit;
    editEndereco: TEdit;
    editNome: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    panPeriodo: TPanel;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmIdentificaCliente: TfrmIdentificaCliente;

implementation

{$R *.lfm}

end.

