unit OperadorController;

interface

uses
  Classes, SQLdb, SysUtils, OperadorVO, FuncionarioVO;

type
  TOperadorController = class
  protected
  public
    class function ConsultaFuncionario(Id: Integer): String;
    class function ConsultaUsuario(Login: String; Senha: String): TOperadorVO;
    class function RetornaFuncionario: TFuncionarioListaVO;
    class function ConsultaIdOperador(Id: Integer): Boolean;
    class function GravaCargaOperador(vTupla: String): Boolean;

  end;

implementation

uses UdmPrincipal, Biblioteca;

var
  ConsultaSQL: String;
  Query: TSQLQuery;

class function TOperadorController.ConsultaFuncionario(Id: Integer): String;
begin

  ConsultaSQL :=
    'select ID, NOME  from ECF_FUNCIONARIO where ID ='+IntToStr(ID);

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.DataBase := dmPrincipal.IBCon;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      Result:= Query.FieldByName('NOME').Asstring;
    except
      Result := '';
    end;
  finally
    Query.Free;
  end;
end;

class function TOperadorController.ConsultaIdOperador(Id: Integer): Boolean;
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

class function TOperadorController.ConsultaUsuario(Login: String; Senha: String): TOperadorVO;
var
  Operador: TOperadorVO;
begin
  ConsultaSQL := 'select '+
                 ' O.ID, '+
                 ' O.ID_ECF_FUNCIONARIO, '+
                 ' O.LOGIN, '+
                 ' O.SENHA, '+
                 ' F.NIVEL_AUTORIZACAO '+
                 'from '+
                 ' ECF_OPERADOR O, ECF_FUNCIONARIO F '+
                 'where '+
                 ' O.ID_ECF_FUNCIONARIO=F.ID '+
                 ' and LOGIN=' + QuotedStr(Login) +
                 ' and SENHA=' + QuotedStr(Senha);
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.DataBase := dmPrincipal.IBCon;
      Query.sql.Text := ConsultaSQL;
      Query.Open;

      Operador := TOperadorVO.Create;
      Operador.Id := Query.FieldByName('ID').AsInteger;
      Operador.IdFuncionario := Query.FieldByName('ID_ECF_FUNCIONARIO').AsInteger;
      Operador.Login := Query.FieldByName('LOGIN').AsString;
      Operador.Senha := Query.FieldByName('SENHA').AsString;
      Operador.Nivel := Query.FieldByName('NIVEL_AUTORIZACAO').AsString;

      result := Operador;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TOperadorController.RetornaFuncionario: TFuncionarioListaVO;
var
  ListaFuncionario: TFuncionarioListaVO;
  Funcionario: TFuncionarioVO;
begin

  ConsultaSQL := 'select ID, NOME from ECF_FUNCIONARIO order by NOME ';

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.DataBase := dmPrincipal.IBCon;
      Query.sql.Text := ConsultaSQL;
      Query.Open;

      if Query.IsEmpty then
      begin
        Result := nil;
      end
      else
      begin
        ListaFuncionario := TFuncionarioListaVO.Create(True);
        Query.First;

        while not Query.Eof do
        begin
          Funcionario := TFuncionarioVO.Create;
          Funcionario.Id := Query.FieldByName('ID').AsInteger;
          Funcionario.Nome := Query.FieldByName('NOME').Asstring;
          ListaFuncionario.Add(Funcionario);
          Query.next;
        end;
        result := ListaFuncionario;
      end;
    except
      Result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TOperadorController.GravaCargaOperador(vTupla:string):boolean;
var
  ID: integer;
begin
  try
    try
      if dmprincipal.BancoPAF = 'FIREBIRD' then
      begin
        ConsultaSQL:= ' UPDATE OR INSERT INTO ECF_OPERADOR '+
        ' (ID, '+
        'ID_ECF_FUNCIONARIO, '+
        'LOGIN, '+
        'SENHA )'+
        ' VALUES ('+
        DevolveConteudoDelimitado('|',vTupla)+', '+  //     ID                  INTEGER NOT NULL,
        DevolveConteudoDelimitado('|',vTupla)+', '+  //     ID_ECF_FUNCIONARIO  INTEGER NOT NULL,
        DevolveConteudoDelimitado('|',vTupla)+', '+  //     LOGIN               VARCHAR(20),
        DevolveConteudoDelimitado('|',vTupla)+')';  //     SENHA               VARCHAR(20)
      end
      else if dmprincipal.BancoPAF = 'MYSQL' then
      begin
        ID := StrToInt(DevolveConteudoDelimitado('|',vTupla));   //    ID              INTEGER NOT NULL,

        if not ConsultaIdOperador(ID) then
          ConsultaSQL := 'INSERT INTO ECF_OPERADOR '+
          ' (ID, '+
          'ID_ECF_FUNCIONARIO, '+
          'LOGIN, '+
          'SENHA )'+
          ' VALUES ('+
          IntToStr(ID)+', '+                            //    ID                    INTEGER NOT NULL,
          DevolveConteudoDelimitado('|',vTupla)+', '+  //     ID_ECF_FUNCIONARIO  INTEGER NOT NULL,
          DevolveConteudoDelimitado('|',vTupla)+', '+  //     LOGIN               VARCHAR(20),
          DevolveConteudoDelimitado('|',vTupla)+')'  //     SENHA               VARCHAR(20)
        else
          ConsultaSQL := ' update ECF_OPERADOR set '+
          'ID_ECF_FUNCIONARIO ='+ DevolveConteudoDelimitado('|',vTupla)+', '+  //     ID_ECF_FUNCIONARIO  INTEGER NOT NULL,
          'LOGIN ='+              DevolveConteudoDelimitado('|',vTupla)+', '+  //     LOGIN               VARCHAR(20),
          'SENHA ='+              DevolveConteudoDelimitado('|',vTupla)+  //     SENHA               VARCHAR(20)
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
