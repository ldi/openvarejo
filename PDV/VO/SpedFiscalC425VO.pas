unit SpedFiscalC425VO;

{$MODE Delphi}

interface

type
  TSpedFiscalC425VO = class
  private
    FIdProduto: Integer;
    FIdUnidade: Integer;
    FSomaQuantidade: Extended;
    FDescricaoUnidade: String;
    FSomaValor: Extended;
    FSomaPIS: Extended;
    FSomaCOFINS: Extended;

  published

    property IdProduto: Integer read FIDProduto write FIDProduto;
    property IdUnidade: Integer read FIdUnidade write FIdUnidade;
    property SomaQuantidade: Extended read FSomaQuantidade write FSomaQuantidade;
    property DescricaoUnidade: String read FDescricaoUnidade write FDescricaoUnidade;
    property SomaValor: Extended read FSomaValor write FSomaValor;
    property SomaPIS: Extended read FSomaPIS write FSomaPIS;
    property SomaCOFINS: Extended read FSomaCOFINS write FSomaCOFINS;

end;

implementation

end.
