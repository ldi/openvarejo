unit UfrmMesclaDAV;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, ActnList, StdCtrls, DBGrids, UfrmBotoesBase, UdmPrincipal, sqldb, db;

type

  { TfrmMesclaDAV }

  TfrmMesclaDAV = class(TfrmBotoesBase)
    dsMestre: TDatasource;
    dsDetalhe: TDatasource;
    GridMestre: TDBGrid;
    GridDetalhe: TDBGrid;
    EditCPFCNPJ: TEdit;
    EditDestinatario: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Panel1: TPanel;
    QMestre: TSQLQuery;
    QDetalhe: TSQLQuery;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmMesclaDAV: TfrmMesclaDAV;

implementation

{$R *.lfm}

end.

