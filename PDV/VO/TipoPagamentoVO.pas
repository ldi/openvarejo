unit TipoPagamentoVO;

{$MODE Delphi}

interface

type
  TTipoPagamentoVO = class
  private
    FID: Integer;
    FCODIGO: String;
    FDESCRICAO: String;
    FTEF: String;
    FIMPRIME_VINCULADO: String;
    FPERMITE_TROCO: String;
    FTEF_TIPO_GP: String;
    FGERA_PARCELAS: String;

  published

    property Id: Integer read FID write FID;
    property Codigo: String read FCODIGO write FCODIGO;
    property Descricao: String read FDESCRICAO write FDESCRICAO;
    property TEF: String read FTEF write FTEF;
    property ImprimeVinculado: String read FIMPRIME_VINCULADO write FIMPRIME_VINCULADO;
    property PermiteTroco: String read FPERMITE_TROCO write FPERMITE_TROCO;
    property TipoGP: String read FTEF_TIPO_GP write FTEF_TIPO_GP;
    property GeraParcelas: String read FGERA_PARCELAS write FGERA_PARCELAS;

end;

implementation

end.
