unit UfrmDescontoAcrescimo;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, ActnList, StdCtrls, curredit, UfrmBotoesBase;

type

  { TfrmDescontoAcrescimo }

  TfrmDescontoAcrescimo = class(TfrmBotoesBase)
    ComboOperacao: TComboBox;
    EditEntrada: TCurrencyEdit;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmDescontoAcrescimo: TfrmDescontoAcrescimo;

implementation

{$R *.lfm}

end.

