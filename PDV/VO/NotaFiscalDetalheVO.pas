unit NotaFiscalDetalheVO;

{$MODE Delphi}

interface

Uses Fgl;

type

  TNotaFiscalDetalheVO = class
  private
    FID: Integer;
    FID_NF_CABECALHO: Integer;
    FID_PRODUTO: Integer;
    FCFOP: Integer;
    FITEM: Integer;
    FQUANTIDADE: Double;
    FVALOR_UNITARIO: Double;
    FVALOR_TOTAL: Double;
    FBASE_ICMS: Double;
    FTAXA_ICMS: Double;
    FICMS: Double;
    FICMS_OUTRAS: Double;
    FICMS_ISENTO: Double;
    FTAXA_DESCONTO: Double;
    FDESCONTO: Double;
    FTAXA_ISSQN: Double;
    FISSQN: Double;
    FTAXA_PIS: Double;
    FPIS: Double;
    FTAXA_COFINS: Double;
    FCOFINS: Double;
    FTAXA_ACRESCIMO: Double;
    FACRESCIMO: Double;
    FTAXA_IPI: Double;
    FIPI: Double;
    FCANCELADO: String;
    FCST: String;
    FMOVIMENTA_ESTOQUE: String;
    FSINCRONIZADO: String;
    FECF_ICMS_ST: String;
    FDescricaoUnidade: String;
    FTotalizadorParcial: String;
  public
    property Id: Integer  read FID write FID;
    property IdNfCabecalho: Integer  read FID_NF_CABECALHO write FID_NF_CABECALHO;
    property IdProduto: Integer  read FID_PRODUTO write FID_PRODUTO;
    property Cfop: Integer  read FCFOP write FCFOP;
    property Item: Integer  read FITEM write FITEM;
    property Quantidade: Double  read FQUANTIDADE write FQUANTIDADE;
    property ValorUnitario: Double  read FVALOR_UNITARIO write FVALOR_UNITARIO;
    property ValorTotal: Double  read FVALOR_TOTAL write FVALOR_TOTAL;
    property BaseIcms: Double  read FBASE_ICMS write FBASE_ICMS;
    property TaxaIcms: Double  read FTAXA_ICMS write FTAXA_ICMS;
    property Icms: Double  read FICMS write FICMS;
    property IcmsOutras: Double  read FICMS_OUTRAS write FICMS_OUTRAS;
    property IcmsIsento: Double  read FICMS_ISENTO write FICMS_ISENTO;
    property TaxaDesconto: Double  read FTAXA_DESCONTO write FTAXA_DESCONTO;
    property Desconto: Double  read FDESCONTO write FDESCONTO;
    property TaxaIssqn: Double  read FTAXA_ISSQN write FTAXA_ISSQN;
    property Issqn: Double  read FISSQN write FISSQN;
    property TaxaPis: Double  read FTAXA_PIS write FTAXA_PIS;
    property Pis: Double  read FPIS write FPIS;
    property TaxaCofins: Double  read FTAXA_COFINS write FTAXA_COFINS;
    property Cofins: Double  read FCOFINS write FCOFINS;
    property TaxaAcrescimo: Double  read FTAXA_ACRESCIMO write FTAXA_ACRESCIMO;
    property Acrescimo: Double  read FACRESCIMO write FACRESCIMO;
    property TaxaIpi: Double  read FTAXA_IPI write FTAXA_IPI;
    property Ipi: Double  read FIPI write FIPI;
    property Cancelado: String  read FCANCELADO write FCANCELADO;
    property Cst: String  read FCST write FCST;
    property MovimentaEstoque: String  read FMOVIMENTA_ESTOQUE write FMOVIMENTA_ESTOQUE;
    property Sincronizado: String  read FSINCRONIZADO write FSINCRONIZADO;
    property ECFIcmsST: String read FECF_ICMS_ST write FECF_ICMS_ST;
    property DescricaoUnidade : String read FDescricaoUnidade write FDescricaoUnidade;
    property TotalizadorParcial: String read FTotalizadorParcial write FTotalizadorParcial;
  end;

type
TNotaFiscalDetalheListaVO = class(specialize TFPGObjectList<TNotaFiscalDetalheVO>);

implementation

end.

