unit UfrmMovimentoAberto;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, ActnList, StdCtrls, UfrmBotoesBase;

type

  { TfrmMovimentoAberto }

  TfrmMovimentoAberto = class(TfrmBotoesBase)
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    editSenhaOperador: TLabeledEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    LabelData: TLabel;
    LabelHora: TLabel;
    LabelImpressora: TLabel;
    LabelOperador: TLabel;
    LabelTerminal: TLabel;
    LabelTurno: TLabel;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmMovimentoAberto: TfrmMovimentoAberto;

implementation

{$R *.lfm}

end.

