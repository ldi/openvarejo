unit UfrmMesclaPreVenda;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, ActnList, StdCtrls, DBGrids, UfrmBotoesBase, sqldb, db;

type

  { TfrmMesclaPreVenda }

  TfrmMesclaPreVenda = class(TfrmBotoesBase)
    dsDetalhe: TDatasource;
    dsMestre: TDatasource;
    EditCPFCNPJ: TEdit;
    EditDestinatario: TEdit;
    GridDetalhe: TDBGrid;
    GridMestre: TDBGrid;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Panel1: TPanel;
    QDetalhe: TSQLQuery;
    QMestre: TSQLQuery;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmMesclaPreVenda: TfrmMesclaPreVenda;

implementation

{$R *.lfm}

end.

