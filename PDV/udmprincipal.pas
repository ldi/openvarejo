unit UdmPrincipal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ACBrECF,
  ACBrBAL, ACBrPAF, ACBrSintegra, ACBrAAC, ACBrTEFD, ACBrSpedFiscal,
  ZConnection, UdmPrincipalBase, IBConnection;

type

  { TdmPrincipal }

  TdmPrincipal = class(TdmPrincipalBase)
    ACBrAAC: TACBrAAC;
    ACBrECF: TACBrECF;
    ACBrPAF: TACBrPAF;
    ACBrSintegra: TACBrSintegra;
    ACBrSPEDFiscal: TACBrSPEDFiscal;
    procedure DataModuleCreate(Sender: TObject);
  private
    { private declarations }
  public
    procedure Conecta_Banco;
  end;

var
  dmPrincipal: TdmPrincipal;

implementation

{$R *.lfm}

{ TdmPrincipal }

procedure TdmPrincipal.DataModuleCreate(Sender: TObject);
begin

end;

procedure TdmPrincipal.Conecta_Banco;
begin
  // Ler arquivo de configuração

end;

end.

