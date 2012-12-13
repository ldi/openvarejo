unit Sintegra61RVO;

interface

Uses Fgl;

type
  TSintegra61RVO = class
  private
    FGTIN: String;
    FDataEmissao: String;
    FMesEmissao: String;
    FAnoEmissao: String;
    FSomaQuantidade: Extended;
    FSomaValor: Extended;
    FSomaBaseICMS: Extended;
    FSituacaoTributaria: String;
  published
    property GTIN: String read FGTIN write FGTIN;
    property DataEmissao: String read FDataEmissao write FDataEmissao;
    property MesEmissao: String read FMesEmissao write FMesEmissao;
    property AnoEmissao: String read FAnoEmissao write FAnoEmissao;
    property SomaQuantidade: Extended read FSomaQuantidade write FSomaQuantidade;
    property SomaValor: Extended read FSomaValor write FSomaValor;
    property SomaBaseICMS: Extended read FSomaBaseICMS write FSomaBaseICMS;
    property SituacaoTributaria: String read FSituacaoTributaria write FSituacaoTributaria;
end;

type
TSintegra61RListaVO = class(specialize TFPGObjectList<TSintegra61RVO>);

implementation

end.
