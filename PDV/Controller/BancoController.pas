unit BancoController;

{$MODE Delphi}

interface

uses
  Classes, sqldb, SysUtils;

type
  TBancoController = class
  protected
  public
    class function ConsultaIDBanco(pId: Integer): Integer;
    class function GravaCargaBanco(vTupla: String): Boolean;
  end;

implementation

uses UdmPrincipal, Biblioteca;

var
  ConsultaSQL : String;
  Query: TSQLQuery;

class function TBancoController.ConsultaIDBanco(pId: Integer): Integer;
begin
  ConsultaSQL := 'select id from banco where id = :pId ';
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.DataBase := dmPrincipal.IBCon;
      Query.sql.Text := ConsultaSQL;
      Query.ParamByName('pId').AsInteger := pId;
      Query.Open;
      if not Query.IsEmpty then
        result := Query.fieldByName('id').AsInteger
      else
        result := 0;
    except

    end;
  finally
    Query.Free;
  end;
end;

class function TBancoController.GravaCargaBanco(vTupla: String): Boolean;
var
  ID: integer;
begin
  try
    try
      if dmPrincipal.BancoPAF = 'FIREBIRD' then
      begin
        ConsultaSQL:= 'UPDATE OR INSERT INTO BANCO '+
        ' (ID, '+
        'CODIGO, '+
        'NOME, '+
        'URL )'+
        ' VALUES ('+
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    ID      INTEGER NOT NULL,
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    CODIGO  VARCHAR(10),
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    NOME    VARCHAR(100),
        DevolveConteudoDelimitado('|',vTupla)+')';   //    URL     VARCHAR(250)
      end
      else if dmPrincipal.BancoPAF = 'MYSQL' then
      begin
        ID := StrToInt(DevolveConteudoDelimitado('|',vTupla));   //    ID              INTEGER NOT NULL,

        if ConsultaIDBanco(ID) = 0 then
          ConsultaSQL := 'INSERT INTO BANCO '+
          ' (ID, '+
          'CODIGO, '+
          'NOME, '+
          'URL )'+
          ' VALUES ('+
          IntToStr(ID)+', '+                            //    ID                    INTEGER NOT NULL,
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    CODIGO  VARCHAR(10),
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    NOME    VARCHAR(100),
          DevolveConteudoDelimitado('|',vTupla)+')'    //    URL     VARCHAR(250)
        else
          ConsultaSQL := ' update BANCO set '+
          'CODIGO ='+DevolveConteudoDelimitado('|',vTupla)+', '+  //    CODIGO  VARCHAR(10),
          'NOME ='+DevolveConteudoDelimitado('|',vTupla)+', '+    //    NOME    VARCHAR(100),
          'URL ='+DevolveConteudoDelimitado('|',vTupla)+          //    URL     VARCHAR(250)
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
