unit ufrmlogingerentesupervisor;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, ActnList, StdCtrls, UfrmBotoesBase;

type

  { TfrmLoginGerenteSupervisor }

  TfrmLoginGerenteSupervisor = class(TfrmBotoesBase)
    ComboBox1: TComboBox;
    editLoginGerente: TLabeledEdit;
    editSenhaGerente: TLabeledEdit;
    GroupBox1: TGroupBox;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmLoginGerenteSupervisor: TfrmLoginGerenteSupervisor;

implementation

{$R *.lfm}

end.

