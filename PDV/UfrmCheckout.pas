unit UfrmCheckout;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, MRUList, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ExtCtrls, EditBtn, Spin, Menus, curredit, UfrmBase, LCLType,
  MovimentoVO, ConfiguracaoVO, ClienteVO, PreVendaCabecalhoVO, VendaCabecalhoVO;

type

  { TfrmCheckout }

  TfrmCheckout = class(TfrmBase)
    edtCodigo: TCurrencyEdit;
    edtquantidade: TCurrencyEdit;
    edtsubtotal: TCurrencyEdit;
    curedttotalgeral: TCurrencyEdit;
    edtvalortotal: TCurrencyEdit;
    edtvalorunit: TCurrencyEdit;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    imgOnline: TImage;
    imgOffline: TImage;
    imgProduto: TImage;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lbldescontoacrescimo: TLabel;
    labelMensagens: TLabel;
    LstbBobina: TListBox;
    Panel1: TPanel;
    pnlTOP: TPanel;
    pnlclient: TPanel;
    pnlDescricaoProduto: TPanel;
    pnlMensagens: TPanel;
    pnlTotalGeral: TPanel;
    pmFuncoes: TPopupMenu;
    Timer1: TTimer;
    TimeIntegracao: TTimer;
    procedure EntradaDadosNF;
     procedure DesmembraCodigoDigitado(CodigoDeBarraOuDescricaoOuIdProduto: String);
     procedure MensagemDeProdutoNaoEncontrado;
     procedure FechaMenuOperacoes;
     procedure CarregaPreVenda(Numero: String);
     procedure CarregaDAV(Numero: String);
     procedure VerificaEstadoImpressora;
     procedure ConfiguraACBr;
     procedure CompoeItemParaVenda;
     procedure ParametrosIniciaisVenda;
     procedure ConsultaProduto(Codigo: String; Tipo: Integer);
     procedure ImprimeCabecalhoBobina;
     procedure ImprimeItemBobina;
     function VerificaVendaAberta: Boolean;
     procedure VerificaVendaComProblemas;
     procedure LocalizaProduto;
     procedure AcionaMenuPrincipal;
     procedure AcionaMenuOperacoes;
     procedure AcionaMenuFiscal;
     procedure IdentificaCliente;
     procedure IdentificaVendedor;
     procedure PegaConfiguracao;
     procedure ConfiguraConstantes;
     procedure SetResolucao;
     procedure IniciaMovimento;
     procedure EncerraMovimento;
     procedure CancelaCupom;
     procedure Suprimento;
     procedure Sangria;
     procedure DescontoOuAcrescimo;
     procedure TelaPadrao(Tipo: Integer = 1);
     procedure IniciaVenda;
     procedure IniciaEncerramentoVenda;
     procedure ConcluiEncerramentoVenda;
     procedure VendeItem;
     procedure IniciaVendaDeItens;
     procedure AtualizaTotais;
     procedure DesabilitaControlesVenda;
     procedure ExportaParaRetaguarda(Arquivo: String; Tipo: Integer);
     procedure HabilitaControlesVenda;

    procedure FormActivate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure TrataExcecao(Sender: TObject; E: Exception);
  private
  public
    MenuAberto: Integer; // 0-não | 1-sim
    StatusCaixa: Integer; // 0-aberto | 1-venda em andamento | 2-venda em recuperação ou importação de PV/DAV | 3-So Consulta | 4-Usuario cancelou a tela Movimento Aberto | 5-Informando dados de NF
    ItemCupom: Integer;
    SubTotal, TotalGeral, Desconto, Acrescimo: Extended;
  end;

var
  frmCheckout: TfrmCheckout;

  MD5: String;
  ProblemaNoPagamento: Boolean;
  MensagemPersistente: String;
  CargaOK, AcionaMenu: Boolean;
  AtualizarEstoque: Integer;

  Movimento: TMovimentoVO;
  Configuracao: TConfiguracaoVO;
  Cliente: TClienteVO;
  VendaCabecalho: TVendaCabecalhoVO;
  ArrayAliquotas: Array [0..50] of String;

implementation

uses UdmPrincipal, ufrmSplash;

{$R *.lfm}

{ TfrmCheckout }

procedure TfrmCheckout.EntradaDadosNF;
begin

end;

procedure TfrmCheckout.DesmembraCodigoDigitado(
  CodigoDeBarraOuDescricaoOuIdProduto: String);
begin

end;

procedure TfrmCheckout.MensagemDeProdutoNaoEncontrado;
begin

end;

procedure TfrmCheckout.FechaMenuOperacoes;
begin

end;

procedure TfrmCheckout.CarregaPreVenda(Numero: String);
begin

end;

procedure TfrmCheckout.CarregaDAV(Numero: String);
begin

end;

procedure TfrmCheckout.VerificaEstadoImpressora;
begin

end;

procedure TfrmCheckout.ConfiguraACBr;
begin

end;

procedure TfrmCheckout.CompoeItemParaVenda;
begin

end;

procedure TfrmCheckout.ParametrosIniciaisVenda;
begin

end;

procedure TfrmCheckout.ConsultaProduto(Codigo: String; Tipo: Integer);
begin

end;

procedure TfrmCheckout.ImprimeCabecalhoBobina;
begin

end;

procedure TfrmCheckout.ImprimeItemBobina;
begin

end;

function TfrmCheckout.VerificaVendaAberta: Boolean;
begin

end;

procedure TfrmCheckout.VerificaVendaComProblemas;
begin

end;

procedure TfrmCheckout.LocalizaProduto;
begin

end;

procedure TfrmCheckout.AcionaMenuPrincipal;
begin

end;

procedure TfrmCheckout.AcionaMenuOperacoes;
begin

end;

procedure TfrmCheckout.AcionaMenuFiscal;
begin

end;

procedure TfrmCheckout.IdentificaCliente;
begin

end;

procedure TfrmCheckout.IdentificaVendedor;
begin

end;

procedure TfrmCheckout.PegaConfiguracao;
begin

end;

procedure TfrmCheckout.ConfiguraConstantes;
begin

end;

procedure TfrmCheckout.SetResolucao;
begin

end;

procedure TfrmCheckout.IniciaMovimento;
begin

end;

procedure TfrmCheckout.EncerraMovimento;
begin

end;

procedure TfrmCheckout.CancelaCupom;
begin

end;

procedure TfrmCheckout.Suprimento;
begin

end;

procedure TfrmCheckout.Sangria;
begin

end;

procedure TfrmCheckout.DescontoOuAcrescimo;
begin

end;

procedure TfrmCheckout.TelaPadrao(Tipo: Integer);
begin

end;

procedure TfrmCheckout.IniciaVenda;
begin

end;

procedure TfrmCheckout.IniciaEncerramentoVenda;
begin

end;

procedure TfrmCheckout.ConcluiEncerramentoVenda;
begin

end;

procedure TfrmCheckout.VendeItem;
begin

end;

procedure TfrmCheckout.IniciaVendaDeItens;
begin

end;

procedure TfrmCheckout.AtualizaTotais;
begin

end;

procedure TfrmCheckout.FormActivate(Sender: TObject);
begin
  frmCheckout.Repaint;
end;

procedure TfrmCheckout.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  inherited;
  if (StatusCaixa = 0) or (StatusCaixa = 3) then
  begin
    if MessageDlg('Tem Certeza Que Deseja Sair do Sistema?', 'Sair do Sistema',
      mtInformation,[mbOk,mbCancel],0)=mrOk then
    begin
      dmprincipal.ACBrECF.Desativar;
      Application.Terminate;
    end
    else
      CanClose := False;
  end
 else
  begin
    Application.MessageBox('Existe uma venda em andamento.', 'Informação do Sistema',MB_ICONINFORMATION);
    CanClose := False;
  end;
end;

procedure TfrmCheckout.FormCreate(Sender: TObject);
begin
  inherited;
  Application.CreateForm(TfrmSplash, frmSplash);
  frmSplash.Show;
  //Application.OnException := TrataExcecao;

  Application.CreateForm(TdmPrincipal, dmPrincipal);
end;

procedure TfrmCheckout.TrataExcecao(Sender: TObject; E: Exception);
begin

end;

procedure TfrmCheckout.DesabilitaControlesVenda;
begin

end;

procedure TfrmCheckout.ExportaParaRetaguarda(Arquivo: String; Tipo: Integer);
begin
  TimeIntegracao.Enabled := False;
  try
    if (Arquivo <> '') and (not(FileExists(ExtractFilePath(Application.ExeName)+'Script\'+Arquivo))) then
      exit;
    if (Configuracao.UsaIntegracao = 1) then
    begin
      frmcheckout.labelMensagens.Caption:='Aguarde..., Exportando Dados';
      Application.ProcessMessages;
     { if FCargaPDV = nil then
         Application.CreateForm(TFCargaPDV, FCargaPDV);
      FCargaPDV.Tipo := Tipo;
      FCargaPDV.NomeArquivo := Arquivo;
      FCargaPDV.ShowModal;}
      Application.ProcessMessages;
    end;
  finally
    TimeIntegracao.Enabled := True;
  end;
end;

procedure TfrmCheckout.HabilitaControlesVenda;
begin

end;

end.

