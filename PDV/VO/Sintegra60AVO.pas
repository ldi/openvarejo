unit Sintegra60AVO;

{$MODE Delphi}

interface

Uses Fgl;

type
  TSintegra60AVO = class
  private
    FID: Integer;
    FID_SINTEGRA_60M: Integer;
    FSITUACAO_TRIBUTARIA: String;
    FVALOR: Extended;
  published
    property Id: Integer read FID write FID;
    property Id60M: Integer read FID_SINTEGRA_60M write FID_SINTEGRA_60M;
    property SituacaoTributaria: String read FSITUACAO_TRIBUTARIA write FSITUACAO_TRIBUTARIA;
    property Valor: Extended read FVALOR write FVALOR;
end;

type
TSintegra60AListaVO = class(specialize TFPGObjectList<TSintegra60AVO>);

implementation

end.
