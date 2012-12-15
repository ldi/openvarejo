unit SituacaoClienteController;

interface

uses
  Classes, SQLdb, SysUtils, SituacaoClienteVO;

type
  TSituacaoClienteController = class
  protected
  public
    class function TabelaSituacaoCliente:  TSituacaoClienteListaVO;
    class function ConsultaIdSituacaoCliente(Id: Integer): Boolean;
    class function GravaCargaSituacaoCliente(vTupla: String): Boolean;
  end;

implementation

uses Udmprincipal, Biblioteca;

var
  ConsultaSQL: String;
  Query: TSQLQuery;


class function TSituacaoClienteController.TabelaSituacaoCliente:  TSituacaoClienteListaVO;
var
  ListaSituacaoCliente:  TSituacaoClienteListaVO;
  SituacaoCliente: TSituacaoClienteVO;
begin
  try
    try
      ConsultaSQL := 'select * from SITUACAO_CLIENTE';
      Query := TSQLQuery.Create(nil);
      Query.DataBase := dmPrincipal.IBCon;
      Query.sql.Text := ConsultaSQL;
      Query.Open;

      ListaSituacaoCliente :=  TSituacaoClienteListaVO.Create;

      Query.First;
      while not Query.Eof do
      begin
        SituacaoCliente := TSituacaoClienteVO.Create;
        SituacaoCliente.Id := Query.FieldByName('ID').AsInteger;
        SituacaoCliente.Nome := Query.FieldByName('NOME').AsString;
        SituacaoCliente.Descricao := Query.FieldByName('DESCRICAO').AsString;
        ListaSituacaoCliente.Add(SituacaoCliente);
        Query.next;
      end;
      result := ListaSituacaoCliente;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TSituacaoClienteController.ConsultaIdSituacaoCliente(Id: Integer): Boolean;
begin
  ConsultaSQL := 'select ID from SITUACAO_CLIENTE where (ID = :pID) ';
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.DataBase := dmPrincipal.IBCon;
      Query.sql.Text := ConsultaSQL;
      Query.ParamByName('pID').AsInteger:=Id;
      Query.Open;
      if not Query.IsEmpty then
        result := true
      else
        result := false;
    except
    end;
  finally
    Query.Free;
  end;

end;

class function TSituacaoClienteController.GravaCargaSituacaoCliente(vTupla: String): Boolean;
var
  ID: Integer;
begin
  try
    try
      if dmprincipal.BancoPAF = 'FIREBIRD' then
      begin
        ConsultaSQL := 'UPDATE OR INSERT INTO SITUACAO_CLIENTE '+
        ' (ID, '+
        'NOME, '+
        'DESCRICAO)'+
        ' values ('+
        DevolveConteudoDelimitado('|',vTupla)+','+  //   ID         INTEGER NOT NULL,
        DevolveConteudoDelimitado('|',vTupla)+','+  //   NOME       VARCHAR(20),
        DevolveConteudoDelimitado('|',vTupla)+')';  //   DESCRICAO  VARCHAR(250)
      end
      else if dmprincipal.BancoPAF = 'MYSQL' then
      begin
        ID := StrToInt(DevolveConteudoDelimitado('|',vTupla));
        if not ConsultaIdSituacaoCliente(ID) then
          ConsultaSQL := ' INSERT INTO SITUACAO_CLIENTE '+
          ' (ID, '+
          'NOME, '+
          'DESCRICAO)'+
          ' values ('+
          IntToStr(ID)+', '+                            //    ID                    INTEGER NOT NULL,
          DevolveConteudoDelimitado('|',vTupla)+','+  //   NOME       VARCHAR(20),
          DevolveConteudoDelimitado('|',vTupla)+')'  //   DESCRICAO  VARCHAR(250)
        else
          ConsultaSQL := ' update SITUACAO_CLIENTE set '+
          ' NOME ='     + DevolveConteudoDelimitado('|',vTupla)+','+
          'DESCRICAO =' + DevolveConteudoDelimitado('|',vTupla)+')'+
          ' where ID ='+IntToStr(ID);
      end;

      Query := TSQLQuery.Create(nil);
      Query.DataBase := dmPrincipal.IBCon;
      Query.sql.Text := ConsultaSQL;
      Query.ExecSQL();

      result := true;

    except
      result := false;
    end;
  finally
    Query.Free;
  end;
end;

end.
