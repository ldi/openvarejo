unit FechamentoController;

{$mode objfpc}{$H+}

interface

uses
  Classes, sqldb, SysUtils, FechamentoVO, Forms, FileUtil;

type
  TFechamentoController = class
  protected
  public
    class function GravaFechamento(Fechamento: TFechamentoVO): Boolean;
    class function ExcluiFechamento(Id: Integer): Boolean;
    class procedure IntegracaoFechamento(Id: Integer; Fecha: TFechamentoVO);
    class procedure IntegracaoExcluiFechamento(Id: Integer);

  end;

implementation

uses Udmprincipal, UfrmCheckout, Biblioteca;

var
  ConsultaSQL : String;
  Query: TSQLQuery;

class function TFechamentoController.GravaFechamento(Fechamento:TFechamentoVO): boolean;
begin

    ConsultaSQL :=  'insert into ecf_fechamento ( '+
                    'ID_ECF_MOVIMENTO,' +
                    'TIPO_PAGAMENTO,' +
                    'VALOR)'+
                    ' values ('+
                    ':pID_ECF_MOVIMENTO,'+
                    ':pTIPO_PAGAMENTO,'+
                    ':pVALOR)';

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.DataBase := dmPrincipal.IBCon;
      Query.sql.Text := ConsultaSQL;

      Query.ParamByName('pID_ECF_MOVIMENTO').AsInteger := Fechamento.IdMovimento;
      Query.ParamByName('pTIPO_PAGAMENTO').AsString    := Fechamento.TipoPagamento;
      Query.ParamByName('pVALOR').AsFloat              := Fechamento.Valor;

      Query.ExecSQL();
      try
        Query.Close;
        Query.SQL.Clear;
        ConsultaSQL := 'select max(ID) as ID from ecf_fechamento';
        Query.sql.Text := ConsultaSQL;
        Query.Open();

        IntegracaoFechamento(Query.FieldByName('ID').AsInteger, Fechamento);
      finally
        //
      end;
      result := True;
    except
      result := false;
    end;
  finally
    Query.Free;
  end;
end;

class function TFechamentoController.ExcluiFechamento(Id: Integer): boolean;
begin
  try
    IntegracaoExcluiFechamento(Id);
  finally
    ConsultaSQL := 'delete from ecf_fechamento where id = :pID ';
    try
      try
        Query := TSQLQuery.Create(nil);
        Query.DataBase := dmPrincipal.IBCon;
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
end;

class procedure TFechamentoController.IntegracaoFechamento(ID: integer;  Fecha: TFechamentoVO);
var
  PathFechamento,  Identificacao, Caixa: String;
  atFechamento: TextFile;
begin
  try
    Caixa := Configuracao.NomeCaixa;
    Identificacao := 'E'+IntToStr(Configuracao.IdEmpresa)+'X'+DevolveInteiro(caixa)+'S'+IntToStr(ID)+'D'+DataParaTexto(Now)+'H'+TimeToStr(now);
    PathFechamento := ExtractFilePath(Application.ExeName)+'Script\Fechamento.txt';
    AssignFile(atFechamento, PathFechamento);
    Application.ProcessMessages;

    if FileExistsUTF8(PathFechamento) { *Converted from FileExists*  } then
      Append(atFechamento)
    else
      Rewrite(atFechamento);

    Write(
      atFechamento,'FECHAMENTO|'+
      Identificacao+
      caixa+'|'+
      IntToStr(ID)+'|'+
      IntToStr(Fecha.IdMovimento)+'|'+
      Fecha.TipoPagamento+'|'+
      FloatToStr(Fecha.Valor)+'|'
    );
    Writeln(atFechamento);
    CloseFile(atFechamento);
    Application.ProcessMessages;
    frmCheckout.ExportaParaRetaguarda('Fechamento.txt',3);
  finally
    //
  end;
end;

class procedure TFechamentoController.IntegracaoExcluiFechamento(ID: integer);
var
  PathFechamento,  Identificacao, Caixa: String;
  atFechamento : TextFile;
begin
  caixa := Configuracao.NomeCaixa;
  Identificacao:='E'+IntToStr(Configuracao.IdEmpresa)+'X'+DevolveInteiro(caixa)+'S'+IntToStr(ID)+'D'+DataParaTexto(Now)+'H'+TimeToStr(now);
  PathFechamento := ExtractFilePath(Application.ExeName)+'Script\Fechamento.txt';
  AssignFile(atFechamento,PathFechamento);
  Application.ProcessMessages;

  ConsultaSQL :=  'select * from ecf_fechamento where ID ='+IntToStr(ID);

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.DataBase := dmPrincipal.IBCon;
      Query.sql.Text := ConsultaSQL;
      Query.Open();
      if not query.IsEmpty then
      begin
        if FileExistsUTF8(PathFechamento) { *Converted from FileExists*  } then
          Append(atFechamento)
        else
          Rewrite(atFechamento);

        Write(
          atFechamento,'EXCLUIFECHAMENTO|'+
          Identificacao+
          caixa+'|'+
          Query.FieldByName('ID').AsString+'|'+
          Query.FieldByName('ID_ECF_MOVIMENTO').AsString+'|'+
          Query.FieldByName('TIPO_PAGAMENTO').AsString+'|'+
          Query.FieldByName('VALOR').AsString+'|'
        );
        Writeln(atFechamento);
        CloseFile(atFechamento);
        Application.ProcessMessages;
        frmCheckout.ExportaParaRetaguarda('Fechamento.txt',3);
      end;
    except
      //
    end;
  finally
     Query.Free;
  end;
end;

end.
