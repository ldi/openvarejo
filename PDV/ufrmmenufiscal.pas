unit UfrmMenuFiscal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Buttons, ActnList, UfrmBase, Uvariaveisbase, sqldb, LCLType;

type

  { TfrmMenuFiscal }

  TfrmMenuFiscal = class(TfrmBase)
    actConfirmar: TAction;
    actCancelar: TAction;
    actLX: TAction;
    actDavEmitidos: TAction;
    actIdentiPaf: TAction;
    actVendasPeriodo: TAction;
    actTabIndTecProd: TAction;
    actParametrosConfig: TAction;
    actLMFC: TAction;
    actLMFS: TAction;
    actEspelhoMFD: TAction;
    actArquivoMFD: TAction;
    actTabProdutos: TAction;
    actEstoque: TAction;
    actMovECF: TAction;
    actMeiosPag: TAction;
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
    procedure actArquivoMFDExecute(Sender: TObject);
    procedure actCancelarExecute(Sender: TObject);
    procedure actConfirmarExecute(Sender: TObject);
    procedure actDavEmitidosExecute(Sender: TObject);
    procedure actEspelhoMFDExecute(Sender: TObject);
    procedure actEstoqueExecute(Sender: TObject);
    procedure actIdentiPafExecute(Sender: TObject);
    procedure actLMFCExecute(Sender: TObject);
    procedure actLMFSExecute(Sender: TObject);
    procedure actLXExecute(Sender: TObject);
    procedure actMeiosPagExecute(Sender: TObject);
    procedure actMovECFExecute(Sender: TObject);
    procedure actParametrosConfigExecute(Sender: TObject);
    procedure actTabIndTecProdExecute(Sender: TObject);
    procedure actTabProdutosExecute(Sender: TObject);
    procedure actVendasPeriodoExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmMenuFiscal: TfrmMenuFiscal;

implementation

uses UfrmCheckout;

{$R *.lfm}

{ TfrmMenuFiscal }

procedure TfrmMenuFiscal.actConfirmarExecute(Sender: TObject);
begin
  //
end;

procedure TfrmMenuFiscal.actDavEmitidosExecute(Sender: TObject);
begin
  //
end;

procedure TfrmMenuFiscal.actEspelhoMFDExecute(Sender: TObject);
begin
  //
end;

procedure TfrmMenuFiscal.actEstoqueExecute(Sender: TObject);
begin
  //
end;

procedure TfrmMenuFiscal.actIdentiPafExecute(Sender: TObject);
begin
  //
end;

procedure TfrmMenuFiscal.actLMFCExecute(Sender: TObject);
begin
  //
end;

procedure TfrmMenuFiscal.actLMFSExecute(Sender: TObject);
begin
  //
end;

procedure TfrmMenuFiscal.actLXExecute(Sender: TObject);
begin
  //
  if frmCheckout.StatusCaixa <> 3 then
  begin
    if MessageDlg('Confirma a emissão da Leitura X?',
      'Emissão de Leitura X',mtInformation,
      [mbYes,mbNo],0)=mrYes then
     // UECF.LeituraX;
  end
  else
    Application.MessageBox('Terminal em Estado Somente Consulta.',
      'Informação do Sistema',MB_ICONINFORMATION);
end;

procedure TfrmMenuFiscal.actMeiosPagExecute(Sender: TObject);
begin
  //
end;

procedure TfrmMenuFiscal.actMovECFExecute(Sender: TObject);
begin
  //
end;

procedure TfrmMenuFiscal.actParametrosConfigExecute(Sender: TObject);
begin
  //
end;

procedure TfrmMenuFiscal.actTabIndTecProdExecute(Sender: TObject);
begin
  //
end;

procedure TfrmMenuFiscal.actTabProdutosExecute(Sender: TObject);
begin
  //
end;

procedure TfrmMenuFiscal.actVendasPeriodoExecute(Sender: TObject);
begin
  //
end;

procedure TfrmMenuFiscal.FormCreate(Sender: TObject);
begin
  nomeform:= 'Menu Fiscal';
  inherited;

end;

procedure TfrmMenuFiscal.actCancelarExecute(Sender: TObject);
begin
  //
  close;
end;

procedure TfrmMenuFiscal.actArquivoMFDExecute(Sender: TObject);
begin
  //
end;

end.

