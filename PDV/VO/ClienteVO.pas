unit ClienteVO;

{$MODE Delphi}

interface

Uses Fgl;

type
  TClienteVO = class
  private
    FID: Integer;
    FID_SITUACAO_CLIENTE: Integer;
    FNOME: String;
    FFANTASIA: String;
    FEMAIL: String;
    FCPF_CNPJ: String;
    FRG: String;
    FORGAO_RG: String;
    FDATA_EMISSAO_RG: String;
    FSEXO: String;
    FINSCRICAO_ESTADUAL: String;
    FINSCRICAO_MUNICIPAL: String;
    FTIPO_PESSOA: String;
    FDATA_CADASTRO: String;
    FCONTATO: String;
    FLOGRADOURO: String;
    FNUMERO: String;
    FCOMPLEMENTO: String;
    FCEP: String;
    FBAIRRO: String;
    FCIDADE: String;
    FUF: String;
    FFONE1: String;
    FFONE2: String;
    FCELULAR: String;
    FCODIGO_IBGE_CIDADE: Integer;
    FCODIGO_IBGE_UF: Integer;

  public
    property Id: Integer  read FID write FID;
    property IdSituacaoCliente: Integer  read FID_SITUACAO_CLIENTE write FID_SITUACAO_CLIENTE;
    property Nome: String  read FNOME write FNOME;
    property Fantasia: String  read FFANTASIA write FFANTASIA;
    property Email: String  read FEMAIL write FEMAIL;
    property CpfOuCnpj: String  read FCPF_CNPJ write FCPF_CNPJ;
    property Rg: String  read FRG write FRG;
    property OrgaoRg: String  read FORGAO_RG write FORGAO_RG;
    property DataEmissaoRg: String  read FDATA_EMISSAO_RG write FDATA_EMISSAO_RG;
    property Sexo: String  read FSEXO write FSEXO;
    property InscricaoEstadual: String  read FINSCRICAO_ESTADUAL write FINSCRICAO_ESTADUAL;
    property InscricaoMunicipal: String  read FINSCRICAO_MUNICIPAL write FINSCRICAO_MUNICIPAL;
    property TipoPessoa: String  read FTIPO_PESSOA write FTIPO_PESSOA;
    property DataCadastro: String  read FDATA_CADASTRO write FDATA_CADASTRO;
    property Contato: String  read FCONTATO write FCONTATO;
    property Logradouro: String  read FLOGRADOURO write FLOGRADOURO;
    property Numero: String  read FNUMERO write FNUMERO;
    property Complemento: String  read FCOMPLEMENTO write FCOMPLEMENTO;
    property Cep: String  read FCEP write FCEP;
    property Bairro: String  read FBAIRRO write FBAIRRO;
    property Cidade: String  read FCIDADE write FCIDADE;
    property Uf: String  read FUF write FUF;
    property Fone1: String  read FFONE1 write FFONE1;
    property Fone2: String  read FFONE2 write FFONE2;
    property Celular: String  read FCELULAR write FCELULAR;
    property CodigoIbgeCidade: Integer  read FCODIGO_IBGE_CIDADE write FCODIGO_IBGE_CIDADE;
    property CodigoIbgeUf: Integer  read FCODIGO_IBGE_UF write FCODIGO_IBGE_UF;
  end;

type
TClienteListaVO = class(specialize TFPGObjectList<TClienteVO>);

implementation



end.

