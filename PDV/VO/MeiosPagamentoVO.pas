unit MeiosPagamentoVO;

{$MODE Delphi}

interface

Uses Fgl;

type
  TMeiosPagamentoVO = class
  private

    FDataHora: String;
    FDescricao: String;
    FTotal: Extended;

  published

    property DataHora: String read FDataHora write FDataHora;
    property Descricao: String read FDescricao write FDescricao;
    property Total: Extended read FTotal write FTotal;

end;

type
TMeiosPagamentoListaVO = class(specialize TFPGObjectList<TMeiosPagamentoVO>);

implementation

end.
