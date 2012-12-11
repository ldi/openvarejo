unit UfrmEfetuaPagamento;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  UfrmBase, Uvariaveisbase;

type

  { TfrmEfetuaPagamento }

  TfrmEfetuaPagamento = class(TfrmBase)
    ComboBox1: TComboBox;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmEfetuaPagamento: TfrmEfetuaPagamento;

implementation

{$R *.lfm}

end.

