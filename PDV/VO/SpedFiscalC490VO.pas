unit SpedFiscalC490VO;

interface

type
  TSpedFiscalC490VO = class
  private
    FCST: String;
    FCFOP: Integer;
    FTaxaICMS: Extended;
    FSomaValor: Extended;
    FSomaBaseICMS: Extended;
    FSomaICMS: Extended;

  published

    property CST: String read FCST write FCST;
    property CFOP: Integer read FCFOP write FCFOP;
    property TaxaICMS: Extended read FTaxaICMS write FTaxaICMS;
    property SomaValor: Extended read FSomaValor write FSomaValor;
    property SomaBaseICMS: Extended read FSomaBaseICMS write FSomaBaseICMS;
    property SomaICMS: Extended read FSomaICMS write FSomaICMS;

end;

implementation

end.
