unit SintegraVO;

{$MODE Delphi}

interface

Uses Fgl;

type
  TSintegraVO = class
  private
    FID: Integer;
    FID_SINTEGRA_60M: Integer;
    FSITUACAO_TRIBUTARIA: String;
    FOutras: Double;
    FSituacao: string;
    FAliquota: Double;
    FIsentas: Double;
    FIcms: Double;
    FValorContabil: Double;
    FBasedeCalculo: Double;
    FEmissorDocumento: string;
    FCfop: string;
    FInscricao: string;
    FUF: string;
    FSerie: string;
    FCPFCNPJ: string;
    FModelo: string;
    FNumero: string;
    FDataDocumento: TDateTime;
    FString: string;
    FEstado: string;
    FCodigoAntecipacao: string;
    FBaseST: Double;
    FEmitente: string;
    FDespesas: Double;
    FIcmsRetido: Double;
    FValorIpi: Double;
    FValorIsentas: Double;
    FValorOutras: Double;

    FNumeroItem : String;
    FDescricao  : String;
    FCST        : String;
    FCodigo     : String;
    FQuantidade : Extended;
    FValor       : Extended;
    FValorDescontoDespesa : Extended;
    FNCM          : String;
    FUnidade      : String;
    FAliquotaIpi  : Extended;
    FAliquotaICMS : Extended;
    FReducao      : Extended;

  published
    property Id: Integer read FID write FID;
    property Id60M: Integer read FID_SINTEGRA_60M write FID_SINTEGRA_60M;
    property SituacaoTributaria: String read FSITUACAO_TRIBUTARIA write FSITUACAO_TRIBUTARIA;
    property CPFCNPJ: string read FCPFCNPJ write FCPFCNPJ;
    property Inscricao: string read FInscricao write FInscricao;
    property DataDocumento: TDateTime read FDataDocumento write FDataDocumento;
    property UF: string read FUF write FUF;
    property Modelo: string read FModelo write FModelo;
    property Serie: string read FSerie write FSerie;
    property Numero: string read FNumero write FNumero;
    property Cfop: string read FCfop write FCfop;
    property EmissorDocumento: string read FEmissorDocumento write FEmissorDocumento;
    property ValorContabil: Double read FValorContabil write FValorContabil;
    property BasedeCalculo: Double read FBasedeCalculo write FBasedeCalculo;
    property Icms: Double read FIcms write FIcms;
    property Isentas: Double read FIsentas write FIsentas;
    property Outras: Double read FOutras write FOutras;
    property Aliquota: Double read FAliquota write FAliquota;
    property Situacao: string read FSituacao write FSituacao;
    property Emitente: string read FEmitente write FEmitente;
    property BaseST: Double read FBaseST write FBaseST;
    property IcmsRetido: Double read FIcmsRetido write FIcmsRetido;
    property Despesas: Double read FDespesas write FDespesas;
    property CodigoAntecipacao: string read FCodigoAntecipacao write FCodigoAntecipacao;
    property ValorIpi: Double read FValorIpi write FValorIpi;
    property ValorOutras: Double read FValorOutras write FValorOutras;
    property ValorIsentas: Double read FValorIsentas write FValorIsentas;

    property NumeroItem: string read FNumeroItem write FNumeroItem;
    property Descricao: string read FDescricao write FDescricao;
    property CST: string read FCST write FCST;
    property Codigo: string read FCodigo write FCodigo;
    property NCM: string read FNCM write FNCM;
    property Unidade: string read FUnidade write FUnidade;
    property Quantidade: Extended read FQuantidade write FQuantidade;
    property Valor: Extended read FValor write FValor;
    property AliquotaIpi: Extended read FAliquotaIpi write FAliquotaIpi;
    property AliquotaICMS: Extended read FAliquotaICMS write FAliquotaICMS;
    property Reducao: Extended read FReducao write FReducao;
end;

type
TSintegraListaVO = class(specialize TFPGObjectList<TSintegraVO>);

implementation

end.
