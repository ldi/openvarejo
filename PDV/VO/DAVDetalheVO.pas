unit DavDetalheVO;

{$MODE Delphi}

interface

uses Fgl;

type
  TDavDetalheVO = class
  private
    FID: Integer;
    FID_DAV_CABECALHO: Integer;
    FID_PRODUTO: Integer;
    FNUMERO_DAV: String;
    FDATA_EMISSAO: String;
    FITEM: Integer;
    FQUANTIDADE: Extended;
    FVALOR_UNITARIO: Extended;
    FVALOR_TOTAL: Extended;
    FCANCELADO: String;
    FMESCLA_PRODUTO: String;
    FGTIN_PRODUTO: String;
    FNOME_PRODUTO: String;
    FUNIDADE_PRODUTO: String;
    FTOTALIZADOR_PARCIAL: String;
    FHASH_TRIPA: String;
    FHASH_INCREMENTO: Integer;
  public 
    property Id: Integer  read FID write FID;
    property IdDavCabecalho: Integer  read FID_DAV_CABECALHO write FID_DAV_CABECALHO;
    property IdProduto: Integer  read FID_PRODUTO write FID_PRODUTO;
    property NumeroDav: String  read FNUMERO_DAV write FNUMERO_DAV;
    property DataEmissao: String  read FDATA_EMISSAO write FDATA_EMISSAO;
    property Item: Integer  read FITEM write FITEM;
    property Quantidade: Extended  read FQUANTIDADE write FQUANTIDADE;
    property ValorUnitario: Extended  read FVALOR_UNITARIO write FVALOR_UNITARIO;
    property ValorTotal: Extended  read FVALOR_TOTAL write FVALOR_TOTAL;
    property Cancelado: String  read FCANCELADO write FCANCELADO;
    property MesclaProduto: String  read FMESCLA_PRODUTO write FMESCLA_PRODUTO;
    property GtinProduto: String  read FGTIN_PRODUTO write FGTIN_PRODUTO;
    property NomeProduto: String  read FNOME_PRODUTO write FNOME_PRODUTO;
    property UnidadeProduto: String  read FUNIDADE_PRODUTO write FUNIDADE_PRODUTO;
    property TotalizadorParcial: String  read FTOTALIZADOR_PARCIAL write FTOTALIZADOR_PARCIAL;
    property HashTripa: String  read FHASH_TRIPA write FHASH_TRIPA;
    property HashIncremento: Integer  read FHASH_INCREMENTO write FHASH_INCREMENTO;
  end;

type
TDavDetalheListaVO = class(specialize TFPGObjectList<TDavDetalheVO>);

implementation

end.
