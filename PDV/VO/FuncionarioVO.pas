unit FuncionarioVO;

{$MODE Delphi}

interface

Uses Fgl;

type
  TFuncionarioVO = class
  private
    FID: Integer;
    FNOME: String;
    FTELEFONE: String;
    FCELULAR: String;
    FEMAIL: String;
    FCOMISSAO_VISTA: Extended;
    FCOMISSAO_PRAZO: Extended;
    FNIVEL_AUTORIZACAO: String;
  published
    property Id: Integer read FID write FID;
    property Nome: String read FNOME write FNOME;
    property Telefone: String read FTELEFONE write FTELEFONE;
    property Celular: String read FCELULAR write FCELULAR;
    property Email: String read FEMAIL write FEMAIL;
    property ComissaoVista: Extended read FCOMISSAO_VISTA write FCOMISSAO_VISTA;
    property ComissaoPrazo: Extended read FCOMISSAO_PRAZO write FCOMISSAO_PRAZO;
    property NivelAutorizacao: String read FNIVEL_AUTORIZACAO write FNIVEL_AUTORIZACAO;
  end;

type
TFuncionarioListaVO = class(specialize TFPGObjectList<TFuncionarioVO>);

implementation

end.
