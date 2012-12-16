unit UfrmCheckout;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, MRUList, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ExtCtrls, EditBtn, Spin, Menus, curredit, UfrmBase, LCLIntf,
  LCLType, LMessages, ACBrBAL, ACBrLCB, ACBrInStore, MovimentoVO,
  ConfiguracaoVO, ClienteVO, PreVendaCabecalhoVO, VendaCabecalhoVO, windows;

type

  { TfrmCheckout }

  TfrmCheckout = class(TfrmBase)
    ACBrBAL1: TACBrBAL;
    ACBrInStore1: TACBrInStore;
    ACBrLCB1: TACBrLCB;
    ApplicationProperties1: TApplicationProperties;
    editCodigo: TCurrencyEdit;
    editQuantidade: TCurrencyEdit;
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
    GifAnimadoLogErro: TImage;
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
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    MenuItem19: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    Panel1: TPanel;
    pnlTOP: TPanel;
    pnlclient: TPanel;
    pnlDescricaoProduto: TPanel;
    pnlMensagens: TPanel;
    pnlTotalGeral: TPanel;
    pmFuncoes: TPopupMenu;
    ppmListaGerente: TPopupMenu;
    PopupMenu2: TPopupMenu;
    Timer1: TTimer;
    TimeIntegracao: TTimer;
    procedure ACBrBAL1LePeso(Peso: Double; Resposta: AnsiString);
    procedure ACBrLCB1LeCodigo(Sender: TObject);
    procedure editCodigoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure editCodigoKeyPress(Sender: TObject; var Key: char);
    procedure EntradaDadosNF;
     procedure DesmembraCodigoDigitado(CodigoDeBarraOuDescricaoOuIdProduto: String);
     procedure MensagemDeProdutoNaoEncontrado;
     procedure FechaMenuOperacoes;
     procedure CarregaPreVenda(Numero: String);
     procedure CarregaDAV(Numero: String);
     procedure MenuItem11Click(Sender: TObject);
     procedure MenuItem14Click(Sender: TObject);
     procedure MenuItem15Click(Sender: TObject);
     procedure MenuItem16Click(Sender: TObject);
     procedure MenuItem17Click(Sender: TObject);
     procedure MenuItem18Click(Sender: TObject);
     procedure MenuItem1Click(Sender: TObject);
     procedure MenuItem2Click(Sender: TObject);
     procedure MenuItem4Click(Sender: TObject);
     procedure MenuItem5Click(Sender: TObject);
     procedure MenuItem7Click(Sender: TObject);
     procedure MenuItem9Click(Sender: TObject);
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

uses UdmPrincipal, ufrmSplash, UfrmConfiguracao, UfrmEfetuaPagamento, ACBrTEFDClass,
    UPaf, UfrmImportaNumero, UfrmMesclaPreVenda, UEcf, UfrmMesclaDAV,
    UfrmIdentificaCliente, UfrmValorReal, UfrmDescontoAcrescimo,
    ProdutoController, ProdutoVO, UfrmIniciaMovimento, VendaController, MovimentoController,
    UfrmEncerraMovimento, UfrmImportaCliente,
    ConfiguracaoController, PosicaoComponentesVO, UfrmImportaProduto,
    UfrmMovimentoAberto, VendedorController, FuncionarioVO, SuprimentoVO, SangriaVO,
    PreVendaController, PreVendaDetalheVO, DAVDetalheVO, DAVController,
    UfrmLoginGerenteSupervisor,
    UfrmCancelaPreVenda, UfrmCargaPDV, UfrmExcluiProdutoVenda,
    UfrmLocaliza, UfrmCheques, UfrmLogImportacao, UfrmNotaFiscal, UfrmPenDrive,
    UfrmMenuFiscal, UfrmCarregaDav;

{$R *.lfm}

{ TfrmCheckout }

procedure TfrmCheckout.EntradaDadosNF;
begin

end;

procedure TfrmCheckout.editCodigoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_RETURN :
      if trim(editCodigo.Text) <> '' then
        IniciaVendaDeItens;
  end;
end;

procedure TfrmCheckout.ACBrBAL1LePeso(Peso: Double; Resposta: AnsiString);
var
  valid: Integer;
begin
   editCodigo.Text:=   formatFloat('##0.000', Peso )+'*';
   if Peso > 0 then
   begin
     labelMensagens.Caption := 'Leitura da Balança OK !' ;
     editQuantidade.Text:=   formatFloat('##0.000', Peso );
     editCodigo.SetFocus;
   end
   else
   begin
     valid := Trunc(ACBrBAL1.UltimoPesoLido);
     case valid of
       0   : labelMensagens.Caption := 'Coloque o produto sobre a Balança!';
       -1  : labelMensagens.Caption := 'Tente Nova Leitura';
       -2  : labelMensagens.Caption := 'Peso Negativo !' ;
       -10 : labelMensagens.Caption := 'Sobrepeso !' ;
     end;
  end
end;

procedure TfrmCheckout.ACBrLCB1LeCodigo(Sender: TObject);
begin
   if editCodigo.Focused then  // Para evitar que ponha o codigo no campo quantidade por exemplo
   begin
     editCodigo.Text := ACBrLCB1.UltimoCodigo;    // Preenche o edit com o codigo lido
     keybd_event(VK_RETURN, 0, 0, 0);            // Simula o acionamento da tecla ENTER
   end;
end;

procedure TfrmCheckout.editCodigoKeyPress(Sender: TObject; var Key: char);
var
  Quantidade: Extended;
begin
  if Key = '.' then
    Key := DecimalSeparator;

  if (key = #13) and (trim(editCodigo.Text) = '') then
  begin
    Key:= #0;
    PerformTab (true);
  end;

  if key = '*' then
  begin
    Key := #0;
    try
      Quantidade:=StrToFloat(editCodigo.Text);
      if (Quantidade <= 0) or (Quantidade > 999) then
      begin
        Application.MessageBox('Quantidade inválida.', 'Erro', MB_OK + MB_ICONERROR);
        editCodigo.Text := '';
        editQuantidade.Text := '1';
      end
      else
      begin
        editQuantidade.Text := editCodigo.Text;
        editCodigo.Text := '';
      end;
    except
      Application.MessageBox('Quantidade inválida.', 'Erro', MB_OK + MB_ICONERROR);
      editCodigo.Text := '';
      editQuantidade.Text := '1';
    end;
  end;

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

procedure TfrmCheckout.MenuItem11Click(Sender: TObject);
begin
  Application.CreateForm(TFrmConfiguracao, FrmConfiguracao);
  FrmConfiguracao.ShowModal;
  PegaConfiguracao;
end;

procedure TfrmCheckout.MenuItem14Click(Sender: TObject);
begin
  Application.CreateForm(TFrmEfetuaPagamento, FrmEfetuaPagamento);
  try
    FrmEfetuaPagamento.ACBrTEFD.Inicializar(TACBrTEFDTipo(3));
    FrmEfetuaPagamento.ACBrTEFD.ADM(TACBrTEFDTipo(3));
  except
    Application.MessageBox('Problemas no GP HIPER.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
  end;
  FrmEfetuaPagamento.Free;
end;

procedure TfrmCheckout.MenuItem15Click(Sender: TObject);
begin
  Application.CreateForm(TfrmEfetuaPagamento, frmEfetuaPagamento);
  try
    frmEfetuaPagamento.ACBrTEFD.Inicializar(TACBrTEFDTipo(2));
    frmEfetuaPagamento.ACBrTEFD.ADM(TACBrTEFDTipo(2));
  except
    Application.MessageBox('Problemas no GP TECBAN.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
  end;
  frmEfetuaPagamento.Free;
end;

procedure TfrmCheckout.MenuItem16Click(Sender: TObject);
begin
  Application.CreateForm(TfrmEfetuaPagamento, frmEfetuaPagamento);
  try
    frmEfetuaPagamento.ACBrTEFD.Inicializar(TACBrTEFDTipo(1));
    frmEfetuaPagamento.ACBrTEFD.ADM(TACBrTEFDTipo(1));
  except
    Application.MessageBox('Problemas no GP TEFDIAL.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
  end;
  frmEfetuaPagamento.Free;
end;

procedure TfrmCheckout.MenuItem17Click(Sender: TObject);
begin
  TimeIntegracao.Enabled := False;
  Application.CreateForm(TFrmPenDrive, FrmPenDrive);
  FrmPenDrive.Rotina := 'IMPORTA';
  FrmPenDrive.ShowModal;
  TimeIntegracao.Enabled := True;
end;

procedure TfrmCheckout.MenuItem18Click(Sender: TObject);
begin
  TimeIntegracao.Enabled := False;
  Application.CreateForm(TFrmPenDrive, FrmPenDrive);
  FrmPenDrive.Rotina := 'EXPORTA';
  FrmPenDrive.ShowModal;
  TimeIntegracao.Enabled := True;
end;

procedure TfrmCheckout.MenuItem1Click(Sender: TObject);
begin
  IniciaMovimento;
end;

procedure TfrmCheckout.MenuItem2Click(Sender: TObject);
begin
  EncerraMovimento;
end;

procedure TfrmCheckout.MenuItem4Click(Sender: TObject);
begin
  Suprimento;
end;

procedure TfrmCheckout.MenuItem5Click(Sender: TObject);
begin
  Sangria;
end;

procedure TfrmCheckout.MenuItem7Click(Sender: TObject);
begin
  if Application.MessageBox('Tem Certeza Que Deseja Executar a Redução Z?'+#13+#13+'O Movimento da Impressora Será Suspenso no dia de Hoje.', 'Redução Z', Mb_YesNo + Mb_IconQuestion) = IdYes then
  begin
    try
      UECF.ReducaoZ;
    finally
      MenuAberto := 0;
      HabilitaControlesVenda;
      TelaPadrao(2);
      editCodigo.SetFocus;
    end;
  end;
end;

procedure TfrmCheckout.MenuItem9Click(Sender: TObject);
begin
  Application.CreateForm(TFrmImportaCliente, FrmImportaCliente);
  FrmImportaCliente.ShowModal;
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

