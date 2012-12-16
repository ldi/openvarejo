unit UfrmImportaCliente;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, ActnList, DBGrids, StdCtrls, UfrmBotoesBase, db, sqldb;

type

  { TfrmImportaCliente }

  TfrmImportaCliente = class(TfrmBotoesBase)
    dsCliente: TDatasource;
    GridPrincipal: TDBGrid;
    EditLocaliza: TEdit;
    Label1: TLabel;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    QCliente: TSQLQuery;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmImportaCliente: TfrmImportaCliente;

implementation

{$R *.lfm}

end.

