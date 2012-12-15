unit SpedFiscalC370VO;

{$MODE Delphi}

interface

Uses Fgl;

type
  TSpedFiscalC370VO = class
  private
    FID_NF_CABECALHO : Integer;
    //FDATA_EMISSAOdateYES
    FID_PRODUTO: Integer;
    FITEM : Integer;
    FID_UNIDADE_PRODUTO : Integer;
    FQUANTIDADE : Extended;
    FVALOR_TOTAL : Extended;
    FDESCONTO : Extended;
  published
    property IdCabecalho : Integer read FID_NF_CABECALHO write FID_NF_CABECALHO;
    property IdProduto: Integer read FID_PRODUTO write FID_PRODUTO;
    property Item: Integer read FITEM write FITEM;
    property IdUnidade: Integer read FID_PRODUTO write FID_PRODUTO;
    property Quantidade: Extended read FQuantidade write FQuantidade;
    property Valor: Extended read FVALOR_TOTAL write FVALOR_TOTAL;
    property Desconto: Extended read FDESCONTO write FDESCONTO;
end;

type
TSpedFiscalC370ListaVO = class(specialize TFPGObjectList<TSpedFiscalC370VO>);

implementation

end.
