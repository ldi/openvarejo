unit TipoPagamentoController;

interface

uses
  Classes, SQLdb, SysUtils, TipoPagamentoVO;

type
  TTipoPagamentoController = class
  private
  protected
  public
    class function ConsultaPeloID(pId: Integer): TTipoPagamentoVO;
    class function TabelaTipoPagamento: TTipoPagamentoListaVO;
    class function ConsultaPelaDescricao(pDescricao: String): TTipoPagamentoVO;
  end;

implementation

uses Udmprincipal;

var
  ConsultaSQL: String;
  Query: TSQLQuery;

class function TTipoPagamentoController.ConsultaPeloID(pId: Integer): TTipoPagamentoVO;
var
  TipoPagamento : TTipoPagamentoVO;
begin
  ConsultaSQL :=
    'select * from ECF_TIPO_PAGAMENTO where id=' + QuotedStr(IntToStr(pId));

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.DataBase := dmPrincipal.IBCon;
      Query.sql.Text := ConsultaSQL;
      Query.Open;

      TipoPagamento := TTipoPagamentoVO.Create;
      TipoPagamento.Id := Query.FieldByName('ID').AsInteger;
      TipoPagamento.Codigo := Trim(Query.FieldByName('CODIGO').AsString);
      TipoPagamento.Descricao := Query.FieldByName('DESCRICAO').AsString;
      TipoPagamento.TEF := Query.FieldByName('TEF').AsString;
      TipoPagamento.ImprimeVinculado := Query.FieldByName('IMPRIME_VINCULADO').AsString;
      TipoPagamento.PermiteTroco := Query.FieldByName('PERMITE_TROCO').AsString;
      TipoPagamento.TipoGP := Query.FieldByName('TEF_TIPO_GP').AsString;
      TipoPagamento.GeraParcelas := Query.FieldByName('GERA_PARCELAS').AsString;
      result := TipoPagamento;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TTipoPagamentoController.TabelaTipoPagamento: TTipoPagamentoListaVO;
var
  ListaTipoPagamento: TTipoPagamentoListaVO;
  TipoPagamento: TTipoPagamentoVO;
begin
  try
    try
      ConsultaSQL := 'select * from ECF_TIPO_PAGAMENTO';

      Query := TSQLQuery.Create(nil);
      Query.DataBase := dmPrincipal.IBCon;
      Query.sql.Text := ConsultaSQL;
      Query.Open;

      ListaTipoPagamento := TTipoPagamentoListaVO.Create(True);

      Query.First;
      while not Query.Eof do
      begin
        TipoPagamento := TTipoPagamentoVO.Create;
        TipoPagamento.Id := Query.FieldByName('ID').AsInteger;
        TipoPagamento.Codigo := Trim(Query.FieldByName('CODIGO').AsString);
        TipoPagamento.Descricao := Query.FieldByName('DESCRICAO').AsString;
        TipoPagamento.TEF := Query.FieldByName('TEF').AsString;
        TipoPagamento.ImprimeVinculado := Query.FieldByName('IMPRIME_VINCULADO').AsString;
        TipoPagamento.PermiteTroco := Query.FieldByName('PERMITE_TROCO').AsString;
        TipoPagamento.TipoGP := Query.FieldByName('TEF_TIPO_GP').AsString;
        TipoPagamento.GeraParcelas := Query.FieldByName('GERA_PARCELAS').AsString;
        ListaTipoPagamento.Add(TipoPagamento);
        Query.next;
      end;
      result := ListaTipoPagamento;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TTipoPagamentoController.ConsultaPelaDescricao(pDescricao: String): TTipoPagamentoVO;
var
  TipoPagamento : TTipoPagamentoVO;
begin
  ConsultaSQL :=
    'select * from ECF_TIPO_PAGAMENTO where descricao=' + QuotedStr(pDescricao);

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.DataBase := dmPrincipal.IBCon;
      Query.sql.Text := ConsultaSQL;
      Query.Open;

      if not Query.IsEmpty then
         begin
          TipoPagamento := TTipoPagamentoVO.Create;
          TipoPagamento.Id := Query.FieldByName('ID').AsInteger;
          TipoPagamento.Codigo := Trim(Query.FieldByName('CODIGO').AsString);
          TipoPagamento.Descricao := Query.FieldByName('DESCRICAO').AsString;
          TipoPagamento.TEF := Query.FieldByName('TEF').AsString;
          TipoPagamento.ImprimeVinculado := Query.FieldByName('IMPRIME_VINCULADO').AsString;
          TipoPagamento.PermiteTroco := Query.FieldByName('PERMITE_TROCO').AsString;
          TipoPagamento.TipoGP := Query.FieldByName('TEF_TIPO_GP').AsString;
          TipoPagamento.GeraParcelas := Query.FieldByName('GERA_PARCELAS').AsString;
          result := TipoPagamento;
         end
      else
        result := nil;

    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

end.
