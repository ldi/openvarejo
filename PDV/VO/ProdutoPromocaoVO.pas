unit ProdutoPromocaoVO;

{$MODE Delphi}

interface

type
  TProdutoPromocaoVO = class
  private
    FID: Integer;
    FID_PRODUTO: Integer;
    FDATA_INICIO: String;
    FDATA_FIM: String;
    FQUANTIDADE_EM_PROMOCAO: Extended;
    QUANTIDADE_MAXIMA_CLIENTE: Extended;
    FVALOR: Extended;

  published

    property Id: Integer read FID write FID;
    property IdProduto: Integer read FID_PRODUTO write FID_PRODUTO;
    property DataInicio: String read FDATA_INICIO write FDATA_INICIO;
    property DataFim: String read FDATA_FIM write FDATA_FIM;
    property QuantidadeEmPromocao: Extended read FQUANTIDADE_EM_PROMOCAO write FQUANTIDADE_EM_PROMOCAO;
    property QuantidadeMaximaPorCliente: Extended read QUANTIDADE_MAXIMA_CLIENTE write QUANTIDADE_MAXIMA_CLIENTE;
    property Valor: Extended read FVALOR write FVALOR;

end;

implementation

end.
