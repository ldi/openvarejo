unit UfrmCancelaPreVenda;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, ActnList, StdCtrls, DBGrids, UfrmBotoesBase;

type

  { TfrmCancelaPreVenda }

  TfrmCancelaPreVenda = class(TfrmBotoesBase)
    GridDetalhe: TDBGrid;
    GridMestre: TDBGrid;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmCancelaPreVenda: TfrmCancelaPreVenda;

implementation

{$R *.lfm}

end.

