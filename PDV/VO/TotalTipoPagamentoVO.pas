unit TotalTipoPagamentoVO;

{$MODE Delphi}

interface

Uses Fgl;

type
  TTotalTipoPagamentoVO = class
  private
    FID: Integer;
    FID_ECF_VENDA_CABECALHO: Integer;
    FID_ECF_TIPO_PAGAMENTO: Integer;
    FSERIE_ECF: String;
    FCOO: Integer;
    FCCF: Integer;
    FGNF: Integer;
    FVALOR: Extended;
    FNSU: String;
    FESTORNO: String;
    FREDE: String;
    FCARTAO_DC: String;
    FSINCRONIZADO: String;
    FHASH_TRIPA: String;
    FHASH_INCREMENTO: Integer;

    FCodigoPagamento: String;
    FTef: String;
    FVinculado: String;
    FDescricao: String;
    FDataHoraTransacao: String;
    FFinalizacao: String;

  published

    property Id: Integer read FID write FID;
    property IdVenda: Integer read FID_ECF_VENDA_CABECALHO write FID_ECF_VENDA_CABECALHO;
    property IdTipoPagamento: Integer read FID_ECF_TIPO_PAGAMENTO write FID_ECF_TIPO_PAGAMENTO;
    property SerieEcf: String read FSERIE_ECF write FSERIE_ECF;
    property Coo: Integer read FCOO write FCOO;
    property Ccf: Integer read FCCF write FCCF;
    property Gnf: Integer read FGNF write FGNF;
    property Valor: Extended read FVALOR write FVALOR;
    property NSU: String read FNSU write FNSU;
    property Estorno: String read FESTORNO write FESTORNO;
    property Rede: String read FREDE write FREDE;
    property CartaoDebitoOuCredito: String read FCARTAO_DC write FCARTAO_DC;
    property Sincronizado: String read FSINCRONIZADO write FSINCRONIZADO;
    property HashTripa: String read FHASH_TRIPA write FHASH_TRIPA;
    property HashIncremento: Integer read FHASH_INCREMENTO write FHASH_INCREMENTO;

    property CodigoPagamento: String read FCodigoPagamento write FCodigoPagamento;
    property TemTEF: String read FTef write FTef;
    property ImprimeVinculado: String read FVinculado write FVinculado;
    property Descricao: String read FDescricao write FDescricao;
    property DataHoraTransacao: String read FDataHoraTransacao write FDataHoraTransacao;
    property Finalizacao: String read FFinalizacao write FFinalizacao;
end;

type
TTotalTipoPagamentoListaVO = class(specialize TFPGObjectList<TTotalTipoPagamentoVO>);

implementation

end.
