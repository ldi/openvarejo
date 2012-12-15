unit NfeCupomFiscalVO;

{$MODE Delphi}

interface

Uses Fgl;

type
  TNfeCupomFiscalVO = class
  private
    FID: Integer;
    FID_NFE_CABECALHO: Integer;
    FMODELO_DOCUMENTO_FISCAL: String;
    FDATA_EMISSAO_CUPOM: String;
    FNUMERO_ORDEM_ECF: Integer;
    FCOO: Integer;
    FNUMERO_CAIXA: Integer;
    FNUMERO_SERIE_ECF: String;

  public
    property Id: Integer  read FID write FID;
    property IdNfeCabecalho: Integer  read FID_NFE_CABECALHO write FID_NFE_CABECALHO;
    property ModeloDocumentoFiscal: String  read FMODELO_DOCUMENTO_FISCAL write FMODELO_DOCUMENTO_FISCAL;
    property DataEmissaoCupom: String  read FDATA_EMISSAO_CUPOM write FDATA_EMISSAO_CUPOM;
    property NumeroOrdemEcf: Integer  read FNUMERO_ORDEM_ECF write FNUMERO_ORDEM_ECF;
    property Coo: Integer  read FCOO write FCOO;
    property NumeroCaixa: Integer  read FNUMERO_CAIXA write FNUMERO_CAIXA;
    property NumeroSerieEcf: String  read FNUMERO_SERIE_ECF write FNUMERO_SERIE_ECF;
  end;

type
TNfeCupomFiscalListaVO = class(specialize TFPGObjectList<TNfeCupomFiscalVO>);

implementation


end.
