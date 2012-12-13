unit PreVendaCabecalhoVO;

{$MODE Delphi}

interface

Uses Fgl;

type
  TPreVendaCabecalhoVO = class
  private
    FID: Integer;
    FID_PESSOA: Integer;
    FID_EMPRESA: Integer;
    FDATA_PV: String;
    FHORA_PV: String;
    FSITUACAO: String;
    FCCF: Integer;
    FVALOR: Extended;
    FNOME_DESTINATARIO: String;
    FCPF_CNPJ_DESTINATARIO: String;
    FSUBTOTAL: Extended;
    FDESCONTO: Extended;
    FACRESCIMO: Extended;
    FTAXA_ACRESCIMO: Extended;
    FTAXA_DESCONTO: Extended;
  published
    property Id: Integer read FID write FID;
    property IdPessoa: Integer read FID_PESSOA write FID_PESSOA;
    property IdEmpresa: Integer read FID_EMPRESA write FID_EMPRESA;
    property DataEmissao: String read FDATA_PV write FDATA_PV;
    property HoraEmissao: String read FHORA_PV write FHORA_PV;
    property Situacao: String read FSITUACAO write FSITUACAO;
    property CCF: Integer read FCCF write FCCF;
    property Valor: Extended read FVALOR write FVALOR;
    property NomeDestinatario: String read FNOME_DESTINATARIO write FNOME_DESTINATARIO;
    property CpfCnpjDestinatario: String read FCPF_CNPJ_DESTINATARIO write FCPF_CNPJ_DESTINATARIO;
    property SubTotal: Extended read FSUBTOTAL write FSUBTOTAL;
    property Desconto: Extended read FDESCONTO write FDESCONTO;
    property Acrescimo: Extended read FACRESCIMO write FACRESCIMO;
    property TaxaAcrescimo: Extended read FTAXA_ACRESCIMO write FTAXA_ACRESCIMO;
    property TaxaDesconto: Extended read FTAXA_DESCONTO write FTAXA_DESCONTO;
end;

type
TPreVendaCabecalhoListaVO = class(specialize TFPGObjectList<TPreVendaCabecalhoVO>);

implementation

end.
