unit CFOPController;

{$MODE Delphi}

interface

uses
  Classes, sqldb, SysUtils;

type
  TCFOPController = class
  protected
  public
    class function ConsultaIdCFOP(Id: Integer): Boolean;
    class function GravaCargaCFOP(vTupla: String): Boolean;
  end;

implementation

uses Udmprincipal, Biblioteca;

var
  ConsultaSQL : String;
  Query: TSQLQuery;

class function TCFOPController.ConsultaIdCFOP(Id: Integer): boolean;
begin
  ConsultaSQL := 'select ID from cfop where (ID = :pID) ';
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

class function TCFOPController.GravaCargaCFOP(vTupla: String): Boolean;
var
  ID: integer;
begin
  try
    try
      if dmPrincipal.BancoPAF = 'FIREBIRD' then
      begin
        ConsultaSQL:= 'UPDATE OR INSERT INTO cfop '+
        ' (ID, '+
        'CFOP, '+
        'DESCRICAO, '+
        'APLICACAO )'+
        ' VALUES ('+
        DevolveConteudoDelimitado('|',vTupla)+', '+  //     ID         INTEGER NOT NULL,
        DevolveConteudoDelimitado('|',vTupla)+', '+  //     CFOP       INTEGER,
        DevolveConteudoDelimitado('|',vTupla)+', '+  //     DESCRICAO  VARCHAR(250),
        DevolveConteudoDelimitado('|',vTupla)+')';   //     APLICACAO  VARCHAR(250)

      end
      else if dmPrincipal.BancoPAF = 'MYSQL' then
      begin
        ID := StrToInt(DevolveConteudoDelimitado('|',vTupla));   //    ID              INTEGER NOT NULL,

        if not ConsultaIdCFOP(ID) then
          ConsultaSQL := 'INSERT INTO cfop '+
          ' (ID, '+
          'CFOP, '+
          'DESCRICAO, '+
          'APLICACAO )'+
          ' VALUES ('+
          IntToStr(ID)+', '+                            //    ID                    INTEGER NOT NULL,
          DevolveConteudoDelimitado('|',vTupla)+', '+  //     CFOP       INTEGER,
          DevolveConteudoDelimitado('|',vTupla)+', '+  //     DESCRICAO  VARCHAR(250),
          DevolveConteudoDelimitado('|',vTupla)+')'   //     APLICACAO  VARCHAR(250)
        else
          ConsultaSQL := ' update cfop set '+
          'CFOP ='+      DevolveConteudoDelimitado('|',vTupla)+', '+  //     CFOP       INTEGER,
          'DESCRICAO ='+ DevolveConteudoDelimitado('|',vTupla)+', '+  //     DESCRICAO  VARCHAR(250),
          'APLICACAO ='+ DevolveConteudoDelimitado('|',vTupla)+   //     APLICACAO  VARCHAR(250)
          ' where ID ='+IntToStr(ID);
      end;

      Query := TSQLQuery.Create(nil);
      Query.DataBase := dmPrincipal.IBCon;
      Query.sql.Text := ConsultaSQL;
      Query.ExecSQL();

      result := True;
    except
      result := false;
    end;
  finally
     Query.Free;
  end;
end;

end.
