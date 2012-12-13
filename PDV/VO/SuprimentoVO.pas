unit SuprimentoVO;

{$MODE Delphi}

interface

type
  TSuprimentoVO = class
  private
    FID: Integer;
    FID_ECF_MOVIMENTO: Integer;
    FDATA_SUPRIMENTO: String;
    FVALOR: Extended;
    FSINCRONIZADO: String;

  published

    property Id: Integer read FID write FID;
    property IdMovimento: Integer read FID_ECF_MOVIMENTO write FID_ECF_MOVIMENTO;
    property DataSuprimento: String read FDATA_SUPRIMENTO write FDATA_SUPRIMENTO;
    property Valor: Extended read FVALOR write FVALOR;
    property Sincronizado: String read FSINCRONIZADO write FSINCRONIZADO;

end;

implementation

end.
