unit UfrmCargaPDV;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  ExtCtrls, UfrmBase, ContasParcelasVO;

type

  { TfrmCargaPDV }

  TfrmCargaPDV = class(TfrmBase)
    ProgressBar: TProgressBar;
    Timer1: TTimer;
    function ImportaCarga(RemoteApp: String): Boolean;
    function ExportaCarga(RemoteApp: String): Boolean;
    function ExportaCancelamentoCupom(RemoteApp: String): Boolean;
    procedure Timer1Timer(Sender: TObject);
    procedure ImprimeParcelasECF(Nome, CPF, COO: String; TotalParcela:currency; ListaParcela: TContasParcelasListaVO);
    function ExportaTabela(PathTabela: String): Boolean;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmCargaPDV: TfrmCargaPDV;

implementation

{$R *.lfm}

{ TfrmCargaPDV }

function TfrmCargaPDV.ImportaCarga(RemoteApp: String): Boolean;
begin

end;

function TfrmCargaPDV.ExportaCarga(RemoteApp: String): Boolean;
begin

end;

function TfrmCargaPDV.ExportaCancelamentoCupom(RemoteApp: String): Boolean;
begin

end;

procedure TfrmCargaPDV.Timer1Timer(Sender: TObject);
begin

end;

procedure TfrmCargaPDV.ImprimeParcelasECF(Nome, CPF, COO: String;
  TotalParcela: currency; ListaParcela:  TContasParcelasListaVO);
begin

end;

function TfrmCargaPDV.ExportaTabela(PathTabela: String): Boolean;
begin

end;

end.

