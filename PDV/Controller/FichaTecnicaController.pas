unit FichaTecnicaController;

{$mode objfpc}{$H+}

interface

uses
  Classes, sqldb, SysUtils, FichaTecnicaVO;

type
  TFichaTecnicaController = class
  protected
  public
    class function GravaFichaTecnica(FichaTecnica: TFichaTecnicaVO): Boolean;
    class function ExcluiFichaTecnica(Id: Integer): Boolean;
    class function ConsultaIdFichaTecnica(Id: Integer): Boolean;
    class function GravaCargaFichaTecnica(vTupla: String): Boolean;
  end;

implementation

uses Udmprincipal, Biblioteca;

var
  ConsultaSQL : String;
  Query: TSQLQuery;

class function TFichaTecnicaController.GravaFichaTecnica(FichaTecnica:TFichaTecnicaVO): boolean;
begin

  ConsultaSQL :=  'insert into ficha_tecnica ( '+
                  'ID_PRODUTO,' +
                  'DESCRICAO,' +
                  'ID_PRODUTO_FILHO,' +
                  'QUANTIDADE) '+
                  ' values ('+
                  ':pID_PRODUTO,'+
                  ':pDESCRICAO,'+
                  ':pID_PRODUTO_FILHO,'+
                  ':pQUANTIDADE)';

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.DataBase := dmPrincipal.IBBalcao;
      Query.sql.Text := ConsultaSQL;

      Query.ParamByName('pID_PRODUTO').AsInteger := FichaTecnica.IdProduto;
      Query.ParamByName('pDESCRICAO').AsString   := FichaTecnica.Descricao;
      Query.ParamByName('pID_PRODUTO_FILHO').AsInteger := FichaTecnica.IdProdutoFilho;
      Query.ParamByName('pQUANTIDADE').AsFloat         := FichaTecnica.Quantidade;
      Query.ExecSQL();

      result := True;
    except
      result := false;
    end;
  finally
    Query.Free;
  end;

end;

class function TFichaTecnicaController.ConsultaIdFichaTecnica(Id: Integer): Boolean;
begin
  ConsultaSQL := 'select ID from ficha_tecnica where (ID = :pID) ';
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.DataBase := dmPrincipal.IBBalcao;
      Query.sql.Text := ConsultaSQL;
      Query.ParamByName('pID').AsInteger:=Id;
      Query.Open;
      if not Query.IsEmpty then
        result := true
      else
        result := false;
    except
       result := false;
    end;
  finally
    Query.Free;
  end;
end;

class function TFichaTecnicaController.ExcluiFichaTecnica(Id: Integer): Boolean;
begin
    ConsultaSQL :=  'delete from FICHA_TECNICA where id = :pID ';

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.DataBase := dmPrincipal.IBBalcao;
      Query.sql.Text := ConsultaSQL;
      Query.ParamByName('pID').AsInteger := Id;
      Query.ExecSQL();
      result := True;
    except
      result := false;
    end;
  finally
    Query.Free;
  end;

end;

class function TFichaTecnicaController.GravaCargaFichaTecnica(vTupla:string): Boolean;
var
  ID: Integer;
begin
  try
    try
      if dmprincipal.BancoPAF = 'FIREBIRD' then
      begin
      ConsultaSQL := 'UPDATE OR INSERT INTO FICHA_TECNICA ' +
                    ' (ID, '+
                    'ID_PRODUTO, '+
                    'DESCRICAO, '+
                    'ID_PRODUTO_FILHO, '+
                    'QUANTIDADE )'+
                    ' VALUES ('+
                    DevolveConteudoDelimitado('|',vTupla)+', '+  //    ID                INTEGER NOT NULL,
                    DevolveConteudoDelimitado('|',vTupla)+', '+  //    ID_PRODUTO        INTEGER NOT NULL,
                    DevolveConteudoDelimitado('|',vTupla)+', '+  //    DESCRICAO         VARCHAR(50),
                    DevolveConteudoDelimitado('|',vTupla)+', '+  //    ID_PRODUTO_FILHO  INTEGER,
                    DevolveConteudoDelimitado('|',vTupla)+')';   //    QUANTIDADE        DECIMAL(18,6)
      end
      else if dmprincipal.BancoPAF = 'MYSQL' then
      begin
        ID := StrToInt(DevolveConteudoDelimitado('|',vTupla));   //    ID              INTEGER NOT NULL,

        if not ConsultaIdFichaTecnica(ID) then
          ConsultaSQL := 'INSERT INTO FICHA_TECNICA '+
          ' (ID, '+
          'ID_PRODUTO, '+
          'DESCRICAO, '+
          'ID_PRODUTO_FILHO, '+
          'QUANTIDADE )'+
          ' VALUES ('+
          IntToStr(ID)+', '+                            //    ID                    INTEGER NOT NULL,
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    ID_PRODUTO        INTEGER NOT NULL,
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    DESCRICAO         VARCHAR(50),
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    ID_PRODUTO_FILHO  INTEGER,
          DevolveConteudoDelimitado('|',vTupla)+')'    //    QUANTIDADE        DECIMAL(18,6)
         else
          ConsultaSQL := ' update FICHA_TECNICA set '+
          'ID_PRODUTO ='+        DevolveConteudoDelimitado('|',vTupla)+', '+  //    ID_PRODUTO        INTEGER NOT NULL,
          'DESCRICAO ='+         DevolveConteudoDelimitado('|',vTupla)+', '+  //    DESCRICAO         VARCHAR(50),
          'ID_PRODUTO_FILHO ='+  DevolveConteudoDelimitado('|',vTupla)+', '+  //    ID_PRODUTO_FILHO  INTEGER,
          'QUANTIDADE ='+        DevolveConteudoDelimitado('|',vTupla)+    //    QUANTIDADE        DECIMAL(18,6)
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
