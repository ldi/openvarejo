unit ContasParcelasVO;

{$MODE Delphi}

interface

uses Fgl;

type
  TContasParcelasVO = class
  private
    FID: Integer;
    FID_CONTAS_PAGAR_RECEBER: Integer;
    FID_MEIOS_PAGAMENTO: Integer;
    FID_CHEQUE_EMITIDO: Integer;
    FID_CONTA_CAIXA: Integer;
    FDATA_EMISSAO: String;
    FDATA_VENCIMENTO: String;
    FDATA_PAGAMENTO: String;
    FNUMERO_PARCELA: Integer;
    FVALOR: Extended;
    FTAXA_JUROS: Extended;
    FTAXA_MULTA: Extended;
    FTAXA_DESCONTO: Extended;
    FVALOR_JUROS: Extended;
    FVALOR_MULTA: Extended;
    FVALOR_DESCONTO: Extended;
    FTOTAL_PARCELA: Extended;
    FHISTORICO: String;
    FSITUACAO: String;

  public
    property Id: Integer  read FID write FID;
    property IdContasPagarReceber: Integer  read FID_CONTAS_PAGAR_RECEBER write FID_CONTAS_PAGAR_RECEBER;
    property IdMeiosPagamento: Integer  read FID_MEIOS_PAGAMENTO write FID_MEIOS_PAGAMENTO;
    property IdChequeEmitido: Integer  read FID_CHEQUE_EMITIDO write FID_CHEQUE_EMITIDO;
    property IdContaCaixa: Integer  read FID_CONTA_CAIXA write FID_CONTA_CAIXA;
    property DataEmissao: String  read FDATA_EMISSAO write FDATA_EMISSAO;
    property DataVencimento: String  read FDATA_VENCIMENTO write FDATA_VENCIMENTO;
    property DataPagamento: String  read FDATA_PAGAMENTO write FDATA_PAGAMENTO;
    property NumeroParcela: Integer  read FNUMERO_PARCELA write FNUMERO_PARCELA;
    property Valor: Extended  read FVALOR write FVALOR;
    property TaxaJuros: Extended  read FTAXA_JUROS write FTAXA_JUROS;
    property TaxaMulta: Extended  read FTAXA_MULTA write FTAXA_MULTA;
    property TaxaDesconto: Extended  read FTAXA_DESCONTO write FTAXA_DESCONTO;
    property ValorJuros: Extended  read FVALOR_JUROS write FVALOR_JUROS;
    property ValorMulta: Extended  read FVALOR_MULTA write FVALOR_MULTA;
    property ValorDesconto: Extended  read FVALOR_DESCONTO write FVALOR_DESCONTO;
    property TotalParcela: Extended  read FTOTAL_PARCELA write FTOTAL_PARCELA;
    property Historico: String  read FHISTORICO write FHISTORICO;
    property Situacao: String  read FSITUACAO write FSITUACAO;
  end;

type
TContasParcelasListaVO = class(specialize TFPGObjectList<TContasParcelasVO>);

implementation



end.
