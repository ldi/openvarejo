unit UnidadeProdutoVO;

{$MODE Delphi}

interface

Uses Fgl;

type
  TUnidadeProdutoVO = class
  private
    FID: Integer;
    FNOME: String;
    FDESCRICAO: String;
    FPODE_FRACIONAR: String;
  published
    property Id: Integer read FID write FID;
    property Nome: String read FNOME write FNOME;
    property Descricao: String read FDESCRICAO write FDESCRICAO;
    property PodeFracionar: String read FPODE_FRACIONAR write FPODE_FRACIONAR;
  end;

type
TUnidadeProdutoListaVO = class(specialize TFPGObjectList<TUnidadeProdutoVO>);
 
implementation

end.
