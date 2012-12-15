unit CaixaVO;

{$MODE Delphi}

interface

type
  TCaixaVO = class
  private
    FID: Integer;
    FNOME: String;
    FDATA_CADASTRO: String;

  published

    property Id: Integer read FID write FID;
    property Nome: String read FNOME write FNOME;
    property DataCadastro: String read FDATA_CADASTRO write FDATA_CADASTRO;

  end;

implementation

end.
