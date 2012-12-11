unit UfrmMenuFiscal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Buttons, ActnList, UfrmBase, Uvariaveisbase;

type

  { TfrmMenuFiscal }

  TfrmMenuFiscal = class(TfrmBase)
    actConfirmar: TAction;
    actCancelar: TAction;
    actLX: TAction;
    Action10: TAction;
    Action11: TAction;
    Action12: TAction;
    Action13: TAction;
    Action14: TAction;
    actLMFC: TAction;
    actLMFS: TAction;
    actEspelhoMFD: TAction;
    actArquivoMFD: TAction;
    actTabProdutos: TAction;
    actEstoque: TAction;
    Action8: TAction;
    Action9: TAction;
    actlMenuFiscal: TActionList;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Button1: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    GroupBox1: TGroupBox;
    Image1: TImage;
    ImglMenuFiscal: TImageList;
    Panel1: TPanel;
    pnlbotoes: TPanel;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmMenuFiscal: TfrmMenuFiscal;

implementation

{$R *.lfm}

end.

