unit R04VO;

{$MODE Delphi}

interface

Uses Fgl;

type
  TR04VO = class
  private

    FId: Integer;
    FIdOperador: Integer;
    FSERIE_ECF: String;
    FCCF: Integer;
    FCOO: Integer;
    FDataEmissao: String;
    FSubTotal: Extended;
    FDesconto: Extended;
    FIndicadorDesconto: String;
    FAcrescimo: Extended;
    FIndicadorAcrescimo: String;
    FValorLiquido: Extended;
{TODO : VERIFICAR COM MOARCYR}
   // FCancelado: String;
    FCancelamentoAcrescimo: Extended;
    FOrdemDescontoAcrescimo: String;
    FCliente: String;
    FCPFCNPJ: String;
    FHASH_TRIPA: String;
    FHASH_INCREMENTO: Integer;
    FCUPOM_CANCELADO: String;
    FSTATUS_VENDA: String;

    //Utilizados pelo Sped Fiscal
    FPIS: Extended;
    FCOFINS: Extended;

  published

    property Id: Integer read FID write FID;
    property IdOperador: Integer read FIdOperador write FIdOperador;
    property SerieEcf: String  read FSERIE_ECF write FSERIE_ECF;
    property CCF: Integer read FCCF write FCCF;
    property COO: Integer read FCOO write FCOO;
    property DataEmissao: String read FDataEmissao write FDataEmissao;
    property SubTotal: Extended read FSubTotal write FSubTotal;
    property Desconto: Extended read FDesconto write FDesconto;
    property IndicadorDesconto: String read FIndicadorDesconto write FIndicadorDesconto;
    property Acrescimo: Extended read FAcrescimo write FAcrescimo;
    property IndicadorAcrescimo: String read FIndicadorAcrescimo write FIndicadorAcrescimo;
    property ValorLiquido: Extended read FValorLiquido write FValorLiquido;
    property Cancelado: String read FCUPOM_CANCELADO write FCUPOM_CANCELADO;
    property CancelamentoAcrescimo: Extended read FCancelamentoAcrescimo write FCancelamentoAcrescimo;
    property OrdemDescontoAcrescimo: String read FOrdemDescontoAcrescimo write FOrdemDescontoAcrescimo;
    property Cliente: String read FCliente write FCliente;
    property CPFCNPJ: String read FCPFCNPJ write FCPFCNPJ;
    property HashTripa: String read FHASH_TRIPA write FHASH_TRIPA;
    property HashIncremento: Integer read FHASH_INCREMENTO write FHASH_INCREMENTO;
    property StatusVenda: String read FSTATUS_VENDA write FSTATUS_VENDA;

    //Utilizados pelo Sped Fiscal
    property PIS: Extended read FPIS write FPIS;
    property COFINS: Extended read FCOFINS write FCOFINS;

end;

type
TR04ListaVO = class(specialize TFPGObjectList<TR04VO>);

implementation

end.
