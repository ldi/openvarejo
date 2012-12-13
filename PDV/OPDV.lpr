program OPDV;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, rxnew, rx, zcomponent, UfrmBase, UfrmCheckout, UdmPrincipal,
  UdmPrincipalBase, Utiposdados, Uvariaveisbase, UfrmEfetuaPagamento,
  ufrmSplash, UfrmMenuFiscal, SpedFiscalC390VO, SpedFiscalC370VO,
  SpedFiscalC321VO, SituacaoClienteVO, SintegraVO, Sintegra61RVO, Sintegra60RVO,
  Sintegra60MVO, Sintegra60DVO, Sintegra60AVO, SangriaVO, ResolucaoVO,
  RecebimentoNaoFiscalVO, R07VO, R06VO, R05VO, R04VO, R03VO, R02VO, R01VO,
  ProdutoVO, ProdutoPromocaoVO, PreVendaDetalheVO, PreVendaCabecalhoVO,
  PosicaoComponentesVO, OperadorVO, NotaFiscalDetalheVO, NotaFiscalCabecalhoVO,
  NfeDetalheVO, NfeCupomFiscalVO, NfeCabecalhoVO, MovimentoVO, MeiosPagamentoVO,
  LogImportacaoVO, ImpressoraVO, FuncionarioVO, FichaTecnicaVO, FechamentoVO,
  EmpresaVO, DocumentosEmitidosVO, DavDetalheVO, DavCabecalhoVO,
  ContasParcelasVO, ContasPagarReceberVO, ContadorVO, ConfiguracaoVO, ClienteVO,
  ChequeClienteVO, CfopVO, CaixaVO, BancoVO, VendaDetalheVO, VendaCabecalhoVO,
  UnidadeProdutoVO, TurnoVO, TotalTipoPagamentoVO, TipoPagamentoVO,
  SuprimentoVO, SpedFiscalC490VO, SpedFiscalC425VO, VendedorController,
  VendaController, UnidadeController, TurnoController,
  TotalTipoPagamentoController, TipoPagamentoController, SpedFiscalController,
  SituacaoClienteController, SintegraController, ResolucaoController,
  RegistroRController, ProdutoPromocaoController, ProdutoController,
  PreVendaController, ParcelaController, OperadorController,
  NotaFiscalController, NFeController, MovimentoController,
  LogImportacaoController, ImpressoraController, FichaTecnicaController,
  FechamentoController, EmpresaController, DAVController, ContadorController,
  ConfiguracaoController, ComponentesController, ClienteController,
  ChequeController, CFOPController, CaixaController, BancoController, 
UfrmCargaPDV, UECF, UPAF, UfrmEncerraMovimento;

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TfrmCheckout, frmCheckout);
  Application.CreateForm(TfrmSplash, frmSplash);
  Application.CreateForm(TfrmMenuFiscal, frmMenuFiscal);
  Application.CreateForm(TfrmCargaPDV, frmCargaPDV);
  Application.CreateForm(TfrmEncerraMovimento, frmEncerraMovimento);
  Application.Run;
end.

