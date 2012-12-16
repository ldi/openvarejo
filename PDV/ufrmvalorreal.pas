unit UfrmValorReal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, ActnList, StdCtrls, UfrmBotoesBase;

type

  { TfrmValorReal }

  TfrmValorReal = class(TfrmBotoesBase)
    EditEntrada: TEdit;
    LabelEntrada: TLabel;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmValorReal: TfrmValorReal;

implementation

{$R *.lfm}

end.

