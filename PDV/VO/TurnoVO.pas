unit TurnoVO;

{$MODE Delphi}

interface

type
  TTurnoVO = class
  private
    FID: Integer;
  	FDESCRICAO: String;
  	FHORA_INICIO: String;
  	FHORA_FIM: String;

  published
    property Id: Integer read FID write FID;
    property Descricao: String read FDESCRICAO write FDESCRICAO;
    property HoraInicio: String read FHORA_INICIO write FHORA_INICIO;
    property HoraFim: String read FHORA_FIM write FHORA_FIM;

  end;

implementation

end.
