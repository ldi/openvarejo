unit TotalTipoPagamentoController;

interface

uses
  Classes, SQLdb, SysUtils, Fgl, TotalTipoPagamentoVO,
  DB, MeiosPagamentoVO;

type
  TTotalTipoPagamentoController = class
  protected
  public
    class procedure GravaTotaisVenda(ListaTotalTipoPagamento: TTotalTipoPagamentoListaVO);
    class procedure GravaTotalTipoPagamento(TotalTipoPagamento: TTotalTipoPagamentoVO);
    class function MeiosPagamento(DataInicio: String; DataFim: String; IdImpressora: Integer): TMeiosPagamentoListaVO;
    class function MeiosPagamentoTotal(DataInicio: String; DataFim: String; IdImpressora: Integer): TMeiosPagamentoListaVO;
    class function EncerramentoTotal(IdMovimento:Integer; Tipo: Integer):TMeiosPagamentoListaVO;
    class function QuantidadeRegistroTabela: Integer;
    class function RetornaMeiosPagamentoDaUltimaVenda(IdCabecalho: Integer): TTotalTipoPagamentoListaVO;
  end;

implementation

uses Udmprincipal, ACBrTEFD,
ImpressoraVO, ImpressoraController, UfrmCheckout, Biblioteca;

var
  Query: TSQLQuery;
  ConsultaSQL: String;

class Procedure TTotalTipoPagamentoController.GravaTotalTipoPagamento(TotalTipoPagamento: TTotalTipoPagamentoVO);
var
  Tripa, Hash: String;
  Impressora: TImpressoraVO;
  Coo, Ccf, Gnf: Integer;
begin
  ConsultaSQL := 'insert into '+
                 ' ECF_TOTAL_TIPO_PGTO ( '+
                 ' ID_ECF_VENDA_CABECALHO, '+
                 ' ID_ECF_TIPO_PAGAMENTO, '+
                 ' VALOR, '+
                 ' NSU, '+
                 ' ESTORNO, '+
                 ' REDE, '+
                 ' CARTAO_DC) '+
                 ' values ( '+
                 ' :pIdVendaCabecalho, '+
                 ' :pIdTipoPagamento, '+
                 ' :pValor, '+
                 ' :pNSU, '+
                 ' :pEstorno, '+
                 ' :pRede, '+
                 ' :pDebitoCredito)';

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.DataBase := dmPrincipal.IBCon;
      Query.sql.Text := ConsultaSQL;
      Query.ParamByName('pIdVendaCabecalho').AsInteger := TotalTipoPagamento.IdVenda;
      Query.ParamByName('pIdTipoPagamento').AsInteger := TotalTipoPagamento.IdTipoPagamento;
      Query.ParamByName('pValor').AsFloat := TotalTipoPagamento.Valor;
      Query.ParamByName('pEstorno').AsString := TotalTipoPagamento.Estorno;
      //NSU
      if TotalTipoPagamento.NSU <> '' then
        Query.ParamByName('pNSU').AsString := TotalTipoPagamento.NSU
      else
      begin
        Query.ParamByName('pNSU').DataType := ftString;
        Query.ParamByName('pNSU').Clear;
      end;
      //Rede
      if TotalTipoPagamento.Rede <> '' then
        Query.ParamByName('pRede').AsString := TotalTipoPagamento.Rede
      else
      begin
        Query.ParamByName('pNSU').DataType := ftString;
        Query.ParamByName('pNSU').Clear;
      end;
      //debito ou credito
      if TotalTipoPagamento.CartaoDebitoOuCredito <> '' then
        Query.ParamByName('pDebitoCredito').AsString := TotalTipoPagamento.CartaoDebitoOuCredito
      else
      begin
        Query.ParamByName('pDebitoCredito').DataType := ftString;
        Query.ParamByName('pDebitoCredito').Clear;
      end;
      Query.ExecSQL();

      ConsultaSQL := 'select max(ID) as ID from ECF_TOTAL_TIPO_PGTO';
      Query.sql.Text := ConsultaSQL;
      Query.Open();
      TotalTipoPagamento.Id := Query.FieldByName('ID').AsInteger;

      Query.Free;

      Impressora := TImpressoraController.PegaImpressora(Configuracao.IdImpressora);
      //calcula e grava o hash
      ConsultaSQL :=
        'update ECF_TOTAL_TIPO_PGTO set ' +
        'SERIE_ECF = :pSERIE_ECF, ' +
        'COO = :pCOO, ' +
        'CCF = :pCCF, ' +
        'GNF = :pGNF, ' +
        'HASH_TRIPA = :pHashTripa, ' +
        'HASH_INCREMENTO = :pHashIncremento ' +
        ' where ID = :pId';

      Coo := StrToInt(dmprincipal.ACBrECF.NumCOO);
      Ccf := StrToInt(dmprincipal.ACBrECF.NumCCF);
      Gnf := StrToInt(dmprincipal.ACBrECF.NumGNF);

      Tripa :=  Impressora.Serie +
                IntToStr(Coo) +
                IntToStr(Ccf) +
                IntToStr(Gnf) +
                '0';
      //Hash := MD5String(Tripa);

      Query := TSQLQuery.Create(nil);
      Query.DataBase := dmPrincipal.IBCon;
      Query.sql.Text := ConsultaSQL;
      Query.ParamByName('pHashIncremento').AsInteger := -1;
      Query.ParamByName('pHashTripa').AsString := Hash;
      Query.ParamByName('pId').AsInteger := TotalTipoPagamento.Id;
      Query.ParamByName('pSERIE_ECF').AsString := Impressora.Serie;
      Query.ParamByName('pCOO').AsInteger := StrToInt(dmprincipal.ACBrECF.NumCOO);
      Query.ParamByName('pCCF').AsInteger := StrToInt(dmprincipal.ACBrECF.NumCCF);
      Query.ParamByName('pGNF').AsInteger := StrToInt(dmprincipal.ACBrECF.NumGNF);
      Query.ExecSQL();

    except
    end;
  finally
    Query.Free;
  end;
end;

class procedure TTotalTipoPagamentoController.GravaTotaisVenda(ListaTotalTipoPagamento: TTotalTipoPagamentoListaVO);
var
  i: Integer;
  TotalTipoPagamento: TTotalTipoPagamentoVO;
  Tripa, Hash: String;
  Impressora: TImpressoraVO;
  Coo, Ccf, Gnf: Integer;
begin
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.DataBase := dmPrincipal.IBCon;
      for i := 0 to ListaTotalTipoPagamento.Count - 1 do
      begin
        ConsultaSQL := 'insert into '+
                       ' ECF_TOTAL_TIPO_PGTO ( '+
                       ' ID_ECF_VENDA_CABECALHO, '+
                       ' ID_ECF_TIPO_PAGAMENTO, '+
                       ' VALOR, '+
                       ' NSU, '+
                       ' ESTORNO, '+
                       ' REDE, '+
                       ' CARTAO_DC) '+
                       ' values ( '+
                       ' :pIdVendaCabecalho, '+
                       ' :pIdTipoPagamento, '+
                       ' :pValor, '+
                       ' :pNSU, '+
                       ' :pEstorno, '+
                       ' :pRede, '+
                       ' :pDebitoCredito)';

        TotalTipoPagamento := ListaTotalTipoPagamento.Items[i];
        Query.sql.Text := ConsultaSQL;
        Query.ParamByName('pIdVendaCabecalho').AsInteger := TotalTipoPagamento.IdVenda;
        Query.ParamByName('pIdTipoPagamento').AsInteger := TotalTipoPagamento.IdTipoPagamento;
        Query.ParamByName('pValor').AsFloat := TotalTipoPagamento.Valor;
        Query.ParamByName('pEstorno').AsString := TotalTipoPagamento.Estorno;
        //NSU
        if TotalTipoPagamento.NSU <> '' then
          Query.ParamByName('pNSU').AsString := TotalTipoPagamento.NSU
        else
        begin
          Query.ParamByName('pNSU').DataType := ftString;
          Query.ParamByName('pNSU').Clear;
        end;
        //Rede
        if TotalTipoPagamento.Rede <> '' then
          Query.ParamByName('pRede').AsString := TotalTipoPagamento.Rede
        else
        begin
          Query.ParamByName('pRede').DataType := ftString;
          Query.ParamByName('pRede').Clear;
        end;
        //debito ou credito
        if TotalTipoPagamento.CartaoDebitoOuCredito <> '' then
          Query.ParamByName('pDebitoCredito').AsString := TotalTipoPagamento.CartaoDebitoOuCredito
        else
        begin
          Query.ParamByName('pDebitoCredito').DataType := ftString;
          Query.ParamByName('pDebitoCredito').Clear;
        end;
        Query.ExecSQL();

        ConsultaSQL := 'select max(ID) as ID from ECF_TOTAL_TIPO_PGTO';
        Query.sql.Text := ConsultaSQL;
        Query.Open();
        TotalTipoPagamento.Id := Query.FieldByName('ID').AsInteger;

        Query.Free;

        Impressora := TImpressoraController.PegaImpressora(Configuracao.IdImpressora);
        //calcula e grava o hash
        ConsultaSQL :=
          'update ECF_TOTAL_TIPO_PGTO set ' +
          'SERIE_ECF = :pSERIE_ECF, ' +
          'COO = :pCOO, ' +
          'CCF = :pCCF, ' +
          'GNF = :pGNF, ' +
          'HASH_TRIPA = :pHashTripa, ' +
          'HASH_INCREMENTO = :pHashIncremento ' +
          ' where ID = :pId';

        Coo := StrToInt(dmprincipal.ACBrECF.NumCOO);
        Ccf := StrToInt(dmprincipal.ACBrECF.NumCCF);
        Gnf := StrToInt(dmprincipal.ACBrECF.NumGNF);

        Tripa :=  Impressora.Serie +
                  IntToStr(Coo) +
                  IntToStr(Ccf) +
                  IntToStr(Gnf) +
                  '0';
        //Hash := MD5String(Tripa);

        Query := TSQLQuery.Create(nil);
        Query.DataBase := dmPrincipal.IBCon;
        Query.sql.Text := ConsultaSQL;
        Query.ParamByName('pHashIncremento').AsInteger := -1;
        Query.ParamByName('pHashTripa').AsString := Hash;
        Query.ParamByName('pId').AsInteger := TotalTipoPagamento.Id;
        Query.ParamByName('pCOO').AsInteger := StrToInt(dmprincipal.ACBrECF.NumCOO);
        Query.ParamByName('pCCF').AsInteger := StrToInt(dmprincipal.ACBrECF.NumCCF);
        Query.ParamByName('pGNF').AsInteger := StrToInt(dmprincipal.ACBrECF.NumGNF);
        Query.ParamByName('pSERIE_ECF').AsString := Impressora.Serie;
        Query.ExecSQL();

      end;
    except
    end;
  finally
    Query.Free;
  end;
end;

class function TTotalTipoPagamentoController.MeiosPagamento(DataInicio: String; DataFim: String; IdImpressora: Integer): TMeiosPagamentoListaVO;
var
  ListaMeiosPagamento: TMeiosPagamentoListaVO;
  MeiosPagamentoV: TMeiosPagamentoVO;
begin
  DataInicio := FormatDateTime('yyyy-mm-dd', StrToDate(DataInicio));
  DataFim := FormatDateTime('yyyy-mm-dd', StrToDate(DataFim));

  ConsultaSQL :=
    'SELECT * from VIEW_MEIOS_PAGAMENTO ' +
    'WHERE '+
    'ID_ECF_IMPRESSORA = '+ IntToStr(idImpressora) + ' AND '+
    '(DATA_ACUMULADO BETWEEN ' + QuotedStr(DataInicio) + ' and ' + QuotedStr(DataFim) +
    ') order by DATA_ACUMULADO';
  try
    try
      ListaMeiosPagamento := TMeiosPagamentoListaVO.Create(True);

      Query := TSQLQuery.Create(nil);
      Query.DataBase := dmPrincipal.IBCon;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      Query.First;
      while not Query.Eof do
      begin
        MeiosPagamentov := TMeiosPagamentoVO.Create;
        MeiosPagamentov.Descricao := Query.FieldByName('DESCRICAO').AsString;
        MeiosPagamentov.DataHora := Query.FieldByName('DATA_ACUMULADO').AsString;
        MeiosPagamentov.Total := Query.FieldByName('TOTAL').AsFloat;
        ListaMeiosPagamento.Add(MeiosPagamentov);
        Query.next;
      end;
      result := ListaMeiosPagamento;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TTotalTipoPagamentoController.MeiosPagamentoTotal(DataInicio: String; DataFim: String; IdImpressora: Integer): TMeiosPagamentoListaVO;
var
  ListaMeiosPagamento: TMeiosPagamentoListaVO;
  MeiosPagamentov: TMeiosPagamentoVO;
begin
  DataInicio := FormatDateTime('yyyy-mm-dd', StrToDate(DataInicio));
  DataFim := FormatDateTime('yyyy-mm-dd', StrToDate(DataFim));

  // alterado by Gilson
  ConsultaSQL :=
//    'SELECT * from VIEW_MEIOS_PAGAMENTO_TOTAL ' +
  'select m.ID_ECF_IMPRESSORA,p.DESCRICAO, '+
  'sum(tp.VALOR) AS TOTAL '+
  'from ecf_venda_cabecalho v '+
     ' INNER JOIN ecf_movimento m ON (v.ID_ECF_MOVIMENTO = m.ID) '+
     ' INNER JOIN ecf_total_tipo_pgto tp ON (v.ID = tp.ID_ECF_VENDA_CABECALHO) '+
     ' INNER JOIN ecf_tipo_pagamento p ON (tp.ID_ECF_TIPO_PAGAMENTO = p.ID) '+
    'WHERE '+
    'm.ID_ECF_IMPRESSORA = '+ IntToStr(idImpressora) + ' AND '+
    '(v.DATA_VENDA BETWEEN ' + QuotedStr(DataInicio) + ' and ' + QuotedStr(DataFim) +')  '+
    'GROUP BY m.ID_ECF_IMPRESSORA,p.DESCRICAO order by p.DESCRICAO ';
  try
    try
      ListaMeiosPagamento := TMeiosPagamentoListaVO.Create(True);

      Query := TSQLQuery.Create(nil);
      Query.DataBase := dmPrincipal.IBCon;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      Query.First;
      while not Query.Eof do
      begin
        MeiosPagamentov := TMeiosPagamentoVO.Create;
        MeiosPagamentov.Descricao := Query.FieldByName('DESCRICAO').AsString;
        MeiosPagamentov.DataHora := '' ; //Query.FieldByName('DATA_ACUMULADO').AsString;
        MeiosPagamentov.Total := Query.FieldByName('TOTAL').AsFloat;
        ListaMeiosPagamento.Add(MeiosPagamentov);
        Query.next;
      end;
      result := ListaMeiosPagamento;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TTotalTipoPagamentoController.EncerramentoTotal(IdMovimento:Integer; Tipo: Integer): TMeiosPagamentoListaVO;
var
  ListaMeiosPagamento: TMeiosPagamentoListaVO;
  MeiosPagamentov: TMeiosPagamentoVO;
begin
  if Tipo = 1 then
  ConsultaSQL :=
    'select v.DATA_VENDA AS DATA_ACUMULADO,m.ID_ECF_IMPRESSORA,p.DESCRICAO, '+
    'COALESCE(sum(tp.VALOR),0) AS TOTAL '+
    'from ecf_venda_cabecalho v '+
          'INNER JOIN ecf_movimento m ON (v.ID_ECF_MOVIMENTO = m.ID) '+
          'INNER JOIN ecf_total_tipo_pgto tp ON (v.ID = tp.ID_ECF_VENDA_CABECALHO) '+
          'INNER JOIN ecf_tipo_pagamento p ON (tp.ID_ECF_TIPO_PAGAMENTO = p.ID) '+
    ' WHERE v.ID_ECF_MOVIMENTO = '+IntToStr(IdMovimento)+
    ' GROUP BY p.DESCRICAO,m.ID_ECF_IMPRESSORA,v.DATA_VENDA'
  else
  ConsultaSQL :=
    'SELECT '+QuotedStr('DATA')+' AS DATA_ACUMULADO, TIPO_PAGAMENTO AS DESCRICAO, '+
    ' COALESCE(sum(VALOR),0) AS TOTAL  FROM ECF_FECHAMENTO'+
    ' WHERE ID_ECF_MOVIMENTO = '+IntToStr(IdMovimento)+
    ' GROUP BY TIPO_PAGAMENTO';

  try
    try
      ListaMeiosPagamento := TMeiosPagamentoListaVO.Create;

      Query := TSQLQuery.Create(nil);
      Query.DataBase := dmPrincipal.IBCon;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      Query.First;
      while not Query.Eof do
      begin
        MeiosPagamentov := TMeiosPagamentoVO.Create;
        MeiosPagamentov.Descricao := Query.FieldByName('DESCRICAO').AsString;
        MeiosPagamentov.DataHora := Query.FieldByName('DATA_ACUMULADO').AsString;
        MeiosPagamentov.Total := Query.FieldByName('TOTAL').AsFloat;
        ListaMeiosPagamento.Add(MeiosPagamentov);
        Query.next;
      end;
      result := ListaMeiosPagamento;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TTotalTipoPagamentoController.QuantidadeRegistroTabela: Integer;
begin
  ConsultaSQL :=
    'SELECT count(*) as TOTAL from ecf_total_tipo_pgto';
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.DataBase := dmPrincipal.IBCon;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      result := Query.FieldByName('TOTAL').AsInteger;
    except
      result := 1;
    end;
  finally
    Query.Free;
  end;
end;

class function TTotalTipoPagamentoController.RetornaMeiosPagamentoDaUltimaVenda(IdCabecalho: Integer): TTotalTipoPagamentoListaVO;
var
  ListaTotalTipoPagamento: TTotalTipoPagamentoListaVO;
  TotalTipoPagamento: TTotalTipoPagamentoVO;
begin
  ConsultaSQL := 'SELECT '+
                 ' T.ID, ' +
                 ' T.ID_ECF_VENDA_CABECALHO, ' +
                 ' T.ID_ECF_TIPO_PAGAMENTO, ' +
                 ' T.VALOR, ' +
                 ' T.NSU, ' +
                 ' T.ESTORNO, ' +
                 ' T.REDE, ' +
                 ' T.CARTAO_DC, ' +
                 ' P.DESCRICAO ' +
                 'FROM '+
                 ' ECF_TIPO_PAGAMENTO  P, ECF_TOTAL_TIPO_PGTO T ' +
                 'WHERE '+
                 ' (ID_ECF_VENDA_CABECALHO = '+ IntToStr(IdCabecalho) + ')  '+
                 ' and (P.ID = T.ID_ECF_TIPO_PAGAMENTO) order by T.ID_ECF_TIPO_PAGAMENTO';
  try
    try
      ListaTotalTipoPagamento := TTotalTipoPagamentoListaVO.Create;

      Query := TSQLQuery.Create(nil);
      Query.DataBase := dmPrincipal.IBCon;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      Query.First;
      while not Query.Eof do
      begin
        TotalTipoPagamento := TTotalTipoPagamentoVO.Create;

        TotalTipoPagamento.Id := Query.FieldByName('ID').AsInteger;
        TotalTipoPagamento.IdVenda := Query.FieldByName('ID_ECF_VENDA_CABECALHO').AsInteger;
        TotalTipoPagamento.IdTipoPagamento := Query.FieldByName('ID_ECF_TIPO_PAGAMENTO').AsInteger;
        TotalTipoPagamento.Valor := Query.FieldByName('VALOR').AsFloat;
        TotalTipoPagamento.NSU := Query.FieldByName('NSU').AsString;
        TotalTipoPagamento.Estorno := Query.FieldByName('ESTORNO').AsString;
        TotalTipoPagamento.Rede := Query.FieldByName('REDE').AsString;
        TotalTipoPagamento.CartaoDebitoOuCredito := Query.FieldByName('CARTAO_DC').AsString;
        TotalTipoPagamento.Descricao := Query.FieldByName('DESCRICAO').AsString;
        ListaTotalTipoPagamento.Add(TotalTipoPagamento);

        Query.next;
      end;
      result := ListaTotalTipoPagamento;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

end.
