unit UfrmCadBase;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  ExtCtrls, Buttons, ActnList, DBGrids, ZDataset, UfrmBase, Utiposdados, db,
  sqldb;

type

  { TfrmCadBase }

  TfrmCadBase = class(TfrmBase)
    actCadbase: TActionList;
    actNovo: TAction;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Datasource1: TDatasource;
    Datasource2: TDatasource;
    dbgCadBase: TDBGrid;
    IglCadBase: TImageList;
    pgcBase: TPageControl;
    pnltop: TPanel;
    pnltop1: TPanel;
    SQLQuery1: TSQLQuery;
    stbCadBase: TStatusBar;
    tbsListagem: TTabSheet;
    tbsCadastro: TTabSheet;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
  private
    StatusTela: TStatusTela;

    procedure Executa_Novo_Registro; virtual;
    procedure Novo_Registro; virtual;
    procedure Antes_Novo_Registro; virtual;
    procedure Depois_Novo_Registro; virtual;
    procedure Executa_Alterar_Registro; virtual;
    procedure Antes_Alterar_Registro; virtual;
    procedure Alterar_Registro; virtual;
    procedure Depois_Alterar_Registro; virtual;
    procedure Executa_Salvar_Registro; virtual;
    procedure Salvar_Registro; virtual;
    procedure Antes_Salvar_Registro; virtual;
    procedure Depois_Salvar_Registro; virtual;
    procedure Executa_Cancelar_Registro; virtual;
    procedure Cancelar_Registro; virtual;
    procedure Antes_Cancelar_Registro; virtual;
    procedure Depois_Cancelar_Registro; virtual;
    procedure Executa_Excluir_Registro; virtual;
    procedure Excluir_Registro; virtual;
    procedure Antes_Excluir_Registro; virtual;
    procedure Depois_Excluir_Registro; virtual;
    procedure Executa_Pesquisa_Base; virtual;
    procedure Pesquisa_Base; virtual;
    procedure Antes_Pesquisa_Base; virtual;
    procedure Depois_Pesquisa_Base; virtual;
    procedure Habilita_Botoes;
    procedure Foco_Primeiro_Campo; virtual;
    procedure Limpa_Objeto(); virtual;
    function IdRegistroSelecionado: Integer;
  public
    { public declarations }
  end;

var
  frmCadBase: TfrmCadBase;

implementation

uses UdmPrincipal;

{ TfrmCadBase }

procedure TfrmCadBase.Executa_Novo_Registro;
begin

end;

procedure TfrmCadBase.Novo_Registro;
begin

end;

procedure TfrmCadBase.Antes_Novo_Registro;
begin

end;

procedure TfrmCadBase.Depois_Novo_Registro;
begin

end;

procedure TfrmCadBase.Executa_Alterar_Registro;
begin

end;

procedure TfrmCadBase.Antes_Alterar_Registro;
begin

end;

procedure TfrmCadBase.Alterar_Registro;
begin

end;

procedure TfrmCadBase.Depois_Alterar_Registro;
begin

end;

procedure TfrmCadBase.Executa_Salvar_Registro;
begin

end;

procedure TfrmCadBase.Salvar_Registro;
begin

end;

procedure TfrmCadBase.Antes_Salvar_Registro;
begin

end;

procedure TfrmCadBase.Depois_Salvar_Registro;
begin

end;

procedure TfrmCadBase.Executa_Cancelar_Registro;
begin

end;

procedure TfrmCadBase.Cancelar_Registro;
begin

end;

procedure TfrmCadBase.Antes_Cancelar_Registro;
begin

end;

procedure TfrmCadBase.Depois_Cancelar_Registro;
begin

end;

procedure TfrmCadBase.Executa_Excluir_Registro;
begin

end;

procedure TfrmCadBase.Excluir_Registro;
begin

end;

procedure TfrmCadBase.Antes_Excluir_Registro;
begin

end;

procedure TfrmCadBase.Depois_Excluir_Registro;
begin

end;

procedure TfrmCadBase.Executa_Pesquisa_Base;
begin

end;

procedure TfrmCadBase.Pesquisa_Base;
begin

end;

procedure TfrmCadBase.Antes_Pesquisa_Base;
begin

end;

procedure TfrmCadBase.Depois_Pesquisa_Base;
begin

end;

procedure TfrmCadBase.Habilita_Botoes;
begin

end;

procedure TfrmCadBase.Foco_Primeiro_Campo;
begin

end;

procedure TfrmCadBase.Limpa_Objeto;
begin

end;

function TfrmCadBase.IdRegistroSelecionado: Integer;
begin

end;

{$R *.lfm}

end.

