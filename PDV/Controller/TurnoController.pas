unit TurnoController;

{$MODE Delphi}

interface

uses
  Classes, sqldb, SysUtils;

type
  TTurnoController = class
  protected
  public
    class function ConsultaIdTurno(Id: Integer): Boolean;
    class function GravaCargaTurno(vTupla: String): Boolean;
  end;

implementation

uses UDataModule, Biblioteca;

var
  ConsultaSQL : String;
  Query: TSQLQuery;

class function TTurnoController.ConsultaIdTurno(Id: Integer): boolean;
begin
  ConsultaSQL := 'select ID from ECF_TURNO where (ID = :pID) ';
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
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

class function TTurnoController.GravaCargaTurno(vTupla: String): Boolean;
var
  ID: Integer;
begin
  try
    try
      if FDataModule.BancoPAF = 'FIREBIRD' then
      begin
        ConsultaSQL :=
        ' UPDATE OR INSERT INTO ECF_TURNO '+
        ' (ID, '+
        'DESCRICAO, '+
        'HORA_INICIO, '+
        'HORA_FIM) '+
        'values ('+
        DevolveConteudoDelimitado('|',vTupla)+','+  //    ID           INTEGER NOT NULL,
        DevolveConteudoDelimitado('|',vTupla)+','+  //    DESCRICAO    VARCHAR(10),
        DevolveConteudoDelimitado('|',vTupla)+','+  //    HORA_INICIO  VARCHAR(8),
        DevolveConteudoDelimitado('|',vTupla)+')';  //    HORA_FIM     VARCHAR(8)
      end
      else if FDataModule.BancoPAF = 'MYSQL' then
      begin
        ID := StrToInt(DevolveConteudoDelimitado('|',vTupla));   //    ID              INTEGER NOT NULL,

        if not ConsultaIdTurno(ID) then
          ConsultaSQL :=
          'INSERT INTO ECF_TURNO '+
          ' (ID, '+
          'DESCRICAO, '+
          'HORA_INICIO, '+
          'HORA_FIM) '+
          'values ('+
          IntToStr(ID)+', '+                            //    ID                    INTEGER NOT NULL,
          DevolveConteudoDelimitado('|',vTupla)+','+  //    DESCRICAO    VARCHAR(10),
          DevolveConteudoDelimitado('|',vTupla)+','+  //    HORA_INICIO  VARCHAR(8),
          DevolveConteudoDelimitado('|',vTupla)+')'  //    HORA_FIM     VARCHAR(8)
        else
          ConsultaSQL := ' update ECF_TURNO set '+
          'DESCRICAO ='+     DevolveConteudoDelimitado('|',vTupla)+','+  //    DESCRICAO    VARCHAR(10),
          'HORA_INICIO ='+   DevolveConteudoDelimitado('|',vTupla)+','+  //    HORA_INICIO  VARCHAR(8),
          'HORA_FIM ='+      DevolveConteudoDelimitado('|',vTupla)+      //    HORA_FIM     VARCHAR(8)
          ' where ID ='+IntToStr(ID);
      end;

      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
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
