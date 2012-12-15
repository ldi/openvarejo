unit SpedFiscalC390VO;

{$MODE Delphi}

interface

Uses Fgl;

type
  TSpedFiscalC390VO = class
  private
    FCST: String;
    FCFOP: Integer;
    FTaxaICMS: Extended;
    FSomaValor: Extended;
    FSomaBaseICMS: Extended;
    FSomaICMS: Extended;
    FSomaICMSOutras: Extended;

  published

    property CST: String read FCST write FCST;
    property CFOP: Integer read FCFOP write FCFOP;
    property TaxaICMS: Extended read FTaxaICMS write FTaxaICMS;
    property SomaValor: Extended read FSomaValor write FSomaValor;
    property SomaBaseICMS: Extended read FSomaBaseICMS write FSomaBaseICMS;
    property SomaICMS: Extended read FSomaICMS write FSomaICMS;
    property SomaICMSOutras: Extended read FSomaICMSOutras write FSomaICMSOutras;

end;

type
TSpedFiscalC390ListaVO = class(specialize TFPGObjectList<TSpedFiscalC390VO>);

implementation

end.
