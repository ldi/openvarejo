unit R05VO;

{$MODE Delphi}

interface

Uses Fgl;

type
  TR05VO = class
  private

    FID: Integer;
    FCOO: Integer;
    FCCF: Integer;
    FSERIE_ECF: String;
    FItem: Integer;
    FGTIN: String;
    FDescricaoPDV: String;
    FQuantidade: Extended;
    FSiglaUnidade: String;
    FValorUnitario: Extended;
    FDesconto: Extended;
    FAcrescimo: Extended;
    FTotalItem: Extended;
    FTotalizadorParcial: String;
    FIndicadorCancelamento: String;
    FQuantidadeCancelada: Extended;
    FValorCancelado: Extended;
    FCancelamentoAcrescimo: Extended;
    FIAT: String;
    FIPPT: String;
    FCasasDecimaisQuantidade: Integer;
    FCasasDecimaisValor: Integer;
    FHASH_TRIPA: String;
    FHASH_INCREMENTO: Integer;
    
    //Utilizados pelo Sped Fiscal
   	FIdProduto: Integer;
    FIdUnidade : Integer;
    FCST: String;
    FCFOP: Integer;
    FAliquotaICMS: Extended;
    FPIS: Extended;
    FCOFINS: Extended;

  published

    property Id: Integer read FID write FID;
    property COO: Integer read FCOO write FCOO;
    property CCF: Integer read FCCF write FCCF;
    property Item: Integer read FItem write FItem;
    property SerieEcf: String  read FSERIE_ECF write FSERIE_ECF;
    property GTIN: String read FGTIN write FGTIN;
    property DescricaoPDV: String read FDescricaoPDV write FDescricaoPDV;
    property Quantidade: Extended read FQuantidade write FQuantidade;
    property SiglaUnidade: String read FSiglaUnidade write FSiglaUnidade;
    property ValorUnitario: Extended read FValorUnitario write FValorUnitario;
    property Desconto: Extended read FDesconto write FDesconto;
    property Acrescimo: Extended read FAcrescimo write FAcrescimo;
    property TotalItem: Extended read FTotalItem write FTotalItem;
    property TotalizadorParcial: String read FTotalizadorParcial write FTotalizadorParcial;
    property IndicadorCancelamento: String read FIndicadorCancelamento write FIndicadorCancelamento;
    property QuantidadeCancelada: Extended read FQuantidadeCancelada write FQuantidadeCancelada;
    property ValorCancelado: Extended read FValorCancelado write FValorCancelado;
    property CancelamentoAcrescimo: Extended read FCancelamentoAcrescimo write FCancelamentoAcrescimo;
    property IAT: String read FIAT write FIAT;
    property IPPT: String read FIPPT write FIPPT;
    property CasasDecimaisQuantidade: Integer read FCasasDecimaisQuantidade write FCasasDecimaisQuantidade;
    property CasasDecimaisValor: Integer read FCasasDecimaisValor write FCasasDecimaisValor;
    property HashTripa: String read FHASH_TRIPA write FHASH_TRIPA;
    property HashIncremento: Integer read FHASH_INCREMENTO write FHASH_INCREMENTO;


    //Utilizados pelo Sped Fiscal
    property IdProduto: Integer read FIdProduto write FIdProduto;
    property IdUnidade: Integer read FIdUnidade write FIdUnidade;
    property CST: String read FCST write FCST;
    property CFOP: Integer read FCFOP write FCFOP;
    property AliquotaICMS: Extended read FAliquotaICMS write FAliquotaICMS;
    property PIS: Extended read FPIS write FPIS;
    property COFINS: Extended read FCOFINS write FCOFINS;

end;

type
TR05ListaVO = class(specialize TFPGObjectList<TR05VO>);

implementation

end.
