unit VendedorController;

{$MODE Delphi}

interface

uses
  Classes, sqldb, SysUtils, FuncionarioVO;

type
  TVendedorController = class
  protected
  public
    class function ConsultaVendedor(Id: Integer): TFuncionarioVO;
    class function ConsultaIdVendedor(Id: Integer): Boolean;
    class Function GravaCargaFuncionario(vTupla: String): Boolean;
  end;

implementation

uses Udmprincipal, Biblioteca;

var
  ConsultaSQL: String;
  Query: TSQLQuery;

class function TVendedorController.ConsultaIdVendedor(Id: Integer): Boolean;
begin
  ConsultaSQL := 'select ID from ECF_FUNCIONARIO where (ID = :pID) ';
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

class function TVendedorController.ConsultaVendedor(Id: Integer): TFuncionarioVO;
var
  Vendedor: TFuncionarioVO;
begin
  ConsultaSQL := 'select * from ECF_FUNCIONARIO where '+
                 'ID=' + IntToStr(Id);
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.DataBase := dmPrincipal.IBCon;
      Query.sql.Text := ConsultaSQL;
      Query.Open;

      Vendedor := TFuncionarioVO.Create;
      Vendedor.Id := Query.FieldByName('ID').AsInteger;
      Vendedor.Nome := Query.FieldByName('NOME').AsString;

      result := Vendedor;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TVendedorController.GravaCargaFuncionario(vTupla: String): Boolean;
var
  ID: integer;
begin
  try
    try
      if dmprincipal.BancoPAF = 'FIREBIRD' then
      begin
        ConsultaSQL := 'UPDATE OR INSERT INTO ECF_FUNCIONARIO ' +
        ' (ID, '+
        'NOME, '+
        'TELEFONE, '+
        'CELULAR, '+
        'EMAIL, '+
        'COMISSAO_VISTA, '+
        'COMISSAO_PRAZO, '+
        'NIVEL_AUTORIZACAO) '+
        ' VALUES ('+
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    ID                 INTEGER NOT NULL,
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    NOME               VARCHAR(100),
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    TELEFONE           VARCHAR(10),
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    CELULAR            VARCHAR(10),
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    EMAIL              VARCHAR(250),
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    COMISSAO_VISTA     DECIMAL(18,6),
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    COMISSAO_PRAZO     DECIMAL(18,6),
        DevolveConteudoDelimitado('|',vTupla)+')';   //    NIVEL_AUTORIZACAO  CHAR(1)
      end
      else if dmprincipal.BancoPAF = 'MYSQL' then
      begin
        ID := StrToInt(DevolveConteudoDelimitado('|',vTupla));   //    ID              INTEGER NOT NULL,

        if not ConsultaIdVendedor(ID) then
          ConsultaSQL := 'INSERT INTO ECF_FUNCIONARIO ' +
          ' (ID, '+
          'NOME, '+
          'TELEFONE, '+
          'CELULAR, '+
          'EMAIL, '+
          'COMISSAO_VISTA, '+
          'COMISSAO_PRAZO, '+
          'NIVEL_AUTORIZACAO) '+
          ' VALUES ('+
          IntToStr(ID)+', '+                            //    ID                    INTEGER NOT NULL,
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    NOME               VARCHAR(100),
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    TELEFONE           VARCHAR(10),
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    CELULAR            VARCHAR(10),
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    EMAIL              VARCHAR(250),
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    COMISSAO_VISTA     DECIMAL(18,6),
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    COMISSAO_PRAZO     DECIMAL(18,6),
          DevolveConteudoDelimitado('|',vTupla)+')'    //    NIVEL_AUTORIZACAO  CHAR(1)
        else
          ConsultaSQL := ' update ECF_FUNCIONARIO set '+
          'NOME ='+              DevolveConteudoDelimitado('|',vTupla)+', '+  //    NOME               VARCHAR(100),
          'TELEFONE ='+          DevolveConteudoDelimitado('|',vTupla)+', '+  //    TELEFONE           VARCHAR(10),
          'CELULAR ='+           DevolveConteudoDelimitado('|',vTupla)+', '+  //    CELULAR            VARCHAR(10),
          'EMAIL ='+             DevolveConteudoDelimitado('|',vTupla)+', '+  //    EMAIL              VARCHAR(250),
          'COMISSAO_VISTA ='+    DevolveConteudoDelimitado('|',vTupla)+', '+  //    COMISSAO_VISTA     DECIMAL(18,6),
          'COMISSAO_PRAZO ='+    DevolveConteudoDelimitado('|',vTupla)+', '+  //    COMISSAO_PRAZO     DECIMAL(18,6),
          'NIVEL_AUTORIZACAO ='+ DevolveConteudoDelimitado('|',vTupla)+   //    NIVEL_AUTORIZACAO  CHAR(1)
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
