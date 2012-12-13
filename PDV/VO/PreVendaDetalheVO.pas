unit PreVendaDetalheVO;

{$MODE Delphi}

interface

Uses Fgl;

type
  TPreVendaDetalheVO = class
  private
    FID: Integer;
    FID_PRODUTO: Integer;
    FID_ECF_PRE_VENDA_CABECALHO: Integer;
    FITEM: Integer;
    FQUANTIDADE: Extended;
    FVALOR_UNITARIO: Extended;
    FVALOR_TOTAL: Extended;
    FCANCELADO: string;
    FGTIN_PRODUTO: String;
    FNOME_PRODUTO: String;
    FUNIDADE_PRODUTO: String;
    FECF_ICMS_ST: String;
  published
    property Id: Integer read FID write FID;
    property IdProduto: Integer read FID_PRODUTO write FID_PRODUTO;
    property IdPreVenda: Integer read FID_ECF_PRE_VENDA_CABECALHO write FID_ECF_PRE_VENDA_CABECALHO;
    property Item: Integer read FITEM write FITEM;
    property Quantidade: Extended read FQUANTIDADE write FQUANTIDADE;
    property ValorUnitario: Extended read FVALOR_UNITARIO write FVALOR_UNITARIO;
    property ValorTotal: Extended read FVALOR_TOTAL write FVALOR_TOTAL;
    property Cancelado: string read FCANCELADO write FCANCELADO;
    property GtinProduto: String  read FGTIN_PRODUTO write FGTIN_PRODUTO;
    property NomeProduto: String  read FNOME_PRODUTO write FNOME_PRODUTO;
    property UnidadeProduto: String  read FUNIDADE_PRODUTO write FUNIDADE_PRODUTO;
    property ECFICMS: String read FECF_ICMS_ST write FECF_ICMS_ST;
end;

type
TPreVendaDetalheListaVO = class(specialize TFPGObjectList<TPreVendaDetalheVO>);

implementation

end.
