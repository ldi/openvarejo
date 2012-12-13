unit ImpressoraVO;

{$MODE Delphi}

interface

Uses Fgl;

type
  TImpressoraVO = class
  private
    FID: Integer;
    FNUMERO: Integer;
    FCODIGO: String;
    FSERIE: String;
    FIDENTIFICACAO: String;
    FMC: String;
    FMD: String;
    FVR: String;
    FTIPO: String;
    FMARCA: String;
    FMODELO: String;
    FMODELO_ACBR: String;
    FMODELO_DOCUMENTO_FISCAL: String;
    FVERSAO: String;
    FLE: String;
    FLEF: String;
    FMFD: String;
    FLACRE_NA_MFD: String;
    FDOCTO: String;
    FNUMERO_ECF: String;
    FDATA_INSTALACAO_SB: String;
    FHORA_INSTALACAO_SB: String;
  published
    property Id: Integer read FID write FID;
    property Numero: Integer read FNUMERO write FNUMERO;
    property Codigo: String read FCODIGO write FCODIGO;
    property Serie: String read FSERIE write FSERIE;
    property Identificacao: String read FIDENTIFICACAO write FIDENTIFICACAO;
    property MC: String read FMC write FMC;
    property MD: String read FMD write FMD;
    property VR: String read FVR write FVR;
    property Tipo: String read FTIPO write FTIPO;
    property Marca: String read FMARCA write FMARCA;
    property Modelo: String read FMODELO write FMODELO;
    property ModeloACBr: String read FMODELO_ACBR write FMODELO_ACBR;
    property ModeloDocumentoFiscal: String read FMODELO_DOCUMENTO_FISCAL write FMODELO_DOCUMENTO_FISCAL;
    property Versao: String read FVERSAO write FVERSAO;
    property LE: String read FLE write FLE;
    property LEF: String read FLEF write FLEF;
    property MFD: String read FMFD write FMFD;
    property LacreNaMFD: String read FLACRE_NA_MFD write FLACRE_NA_MFD;
    property DOCTO: String read FDOCTO write FDOCTO;
    property NumeroEcf: String  read FNUMERO_ECF write FNUMERO_ECF;
    property DataInstalacaoSb: String read FDATA_INSTALACAO_SB write FDATA_INSTALACAO_SB;
    property HoraInstalacaoSb: String read FHORA_INSTALACAO_SB write FHORA_INSTALACAO_SB;

end;

type
TImpressoraListaVO = class(specialize TFPGObjectList<TImpressoraVO>);

implementation

end.
