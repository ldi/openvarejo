unit SituacaoClienteVO;

{$MODE Delphi}

interface

Uses Fgl;

type
  TSituacaoClienteVO = class
  private
    FID: Integer;
    FNOME: String;
    FDESCRICAO: String;
  published
    property Id: Integer read FID write FID;
    property Nome: String read FNOME write FNOME;
    property Descricao: String read FDESCRICAO write FDESCRICAO;
  end;

type
TSituacaoClienteListaVO = class(specialize TFPGObjectList<TSituacaoClienteVO>);

implementation

end.
