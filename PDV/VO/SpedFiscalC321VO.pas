unit SpedFiscalC321VO;

{$MODE Delphi}

interface

Uses Fgl;

type
  TSpedFiscalC321VO = class
  private
    FIdProduto: Integer;
    FSomaQuantidade: Extended;
    FDescricaoUnidade: String;
    FSomaValor: Extended;
    FSomaDesconto: Extended;
    FSomaBaseICMS: Extended;
    FSomaICMS: Extended;
    FSomaPIS: Extended;
    FSomaCOFINS: Extended;

  published

    property IdProduto: Integer  read FIDProduto write FIDProduto;
    property SomaQuantidade: Extended  read FSomaQuantidade write FSomaQuantidade;
    property DescricaoUnidade: String  read FDescricaoUnidade write FDescricaoUnidade;
    property SomaValor: Extended  read FSomaValor write FSomaValor;
    property SomaDesconto: Extended  read FSomaDesconto write FSomaDesconto;
    property SomaBaseICMS: Extended  read FSomaBaseICMS write FSomaBaseICMS;
    property SomaICMS: Extended  read FSomaICMS write FSomaICMS;
    property SomaPIS: Extended  read FSomaPIS write FSomaPIS;
    property SomaCOFINS: Extended  read FSomaCOFINS write FSomaCOFINS;

end;

type
TSpedFiscalC321ListaVO = class(specialize TFPGObjectList<TSpedFiscalC321VO>);

implementation

end.
