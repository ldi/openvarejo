unit UfrmImportaProduto;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, ActnList, DBGrids, StdCtrls, UfrmBotoesBase;

type

  { TfrmImportaProduto }

  TfrmImportaProduto = class(TfrmBotoesBase)
    EditLocaliza: TEdit;
    GridPrincipal: TDBGrid;
    Label1: TLabel;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmImportaProduto: TfrmImportaProduto;

implementation

{$R *.lfm}

end.

