unit UfrmCargaPDV;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  ExtCtrls, UfrmBase, ContasParcelasVO;

type

  { TfrmCargaPDV }

  TfrmCargaPDV = class(TfrmBase)
    ProgressBar: TProgressBar;
    Timer1: TTimer;
    function ImportaCarga(RemoteApp: String): Boolean;
    function ExportaCarga(RemoteApp: String): Boolean;
    function ExportaCancelamentoCupom(RemoteApp: String): Boolean;
    procedure Timer1Timer(Sender: TObject);
    procedure ImprimeParcelasECF(Nome, CPF, COO: String; TotalParcela:currency; ListaParcela: TContasParcelasListaVO);
    function ExportaTabela(PathTabela: String): Boolean;
  private
    PathVenda: String;
    { private declarations }
  public
    Tipo: Integer;
    NomeArquivo:string;
  end;

var
  frmCargaPDV: TfrmCargaPDV;

implementation

uses Biblioteca, UnidadeController,LogImportacaoController,
   ProdutoController, SituacaoClienteController, ClienteController,EmpresaController,
   ContadorController, TurnoController,
     VendedorController, OperadorController, BancoController,
     CFOPController, FichaTecnicaController,
     ProdutoPromocaoController,
     UfrmPenDrive, ResolucaoController, ContasPagarReceberVO,  ParcelaController,
     ComponentesController, ImpressoraController, ConfiguracaoVO;

{$R *.lfm}

{ TfrmCargaPDV }

function TfrmCargaPDV.ImportaCarga(RemoteApp: String): Boolean;
var
  i : Integer;
  LocalApp, Tupla, Compara, LogTupla: String;
  atcarga: TextFile;
begin
  Result := False;
  i := 0;
  LocalApp:=  ExtractFilePath(Application.ExeName)+'Script\carga.txt';

  if CopyFile(PChar(RemoteApp), PChar(LocalApp), False) then
  begin
    Application.ProcessMessages;
    AssignFile(atcarga,LocalApp);
    Reset(atcarga);
    while not Eof(atcarga) do
    begin
      Readln(atcarga);
      inc(i);
    end;

    ProgressBar.Max := i;
    i := 0;
    Reset(atcarga);
    try

      ProgressBar.Position := i;
      while not Eof(atcarga) do
      begin
        inc(i);
        ProgressBar.Position:= i;
        Read(atcarga, Tupla);
        LogTupla:=copy(Tupla,1,250);
        Compara:= DevolveConteudoDelimitado('|',Tupla);
        Application.ProcessMessages;

        if Compara = 'UNIDADE' then
        begin
          if not TUnidadeController.GravaCargaUnidadeProduto(Tupla) then
            TLogImportacaoController.GravaLogImportacao(LogTupla);
        end

        else if Compara = 'PRODUTO' then
        begin
          if not TProdutoController.GravaCargaProduto(Tupla) then
            TLogImportacaoController.GravaLogImportacao(LogTupla);
        end

        else if Compara = 'SITUACAO_CLI' then
        begin
          if not TSituacaoClienteController.GravaCargaSituacaoCliente(Tupla) then
            TLogImportacaoController.GravaLogImportacao(LogTupla);
        end
        else if Compara = 'CLIENTE' then
        begin
          if not TClienteController.GravaCargaCliente(Tupla)then
            TLogImportacaoController.GravaLogImportacao(LogTupla);
        end

        else if Compara = 'EMPRESA' then
        begin
          if not TEmpresaController.GravaCargaEmpresa(Tupla)then
            TLogImportacaoController.GravaLogImportacao(LogTupla);
        end

        else if Compara = 'CONTADOR' then
        begin
          if not TContadorController.GravaCargaContador(Tupla)then
            TLogImportacaoController.GravaLogImportacao(LogTupla);
        end

        else if Compara = 'TURNO' then
        begin
          if not TTurnoController.GravaCargaTurno(Tupla)then
            TLogImportacaoController.GravaLogImportacao(LogTupla);
        end

        else if Compara = 'FUNCIONARIO' then
        begin
          if not TVendedorController.GravaCargaFuncionario(Tupla)then
            TLogImportacaoController.GravaLogImportacao(LogTupla);
        end

        else if Compara = 'OPERADOR' then
        begin
          if not TOperadorController.GravaCargaOperador(Tupla)then
            TLogImportacaoController.GravaLogImportacao(LogTupla);
        end

        else if Compara = 'BANCO' then
        begin
          if not TBancoController.GravaCargaBanco(Tupla) then
            TLogImportacaoController.GravaLogImportacao(LogTupla);
        end

        else if Compara = 'CFOP' then
        begin
          if not TCFOPController.GravaCargaCFOP(Tupla) then
            TLogImportacaoController.GravaLogImportacao(LogTupla);
        end

        else if Compara = 'FICHA' then
        begin
          if not TFichaTecnicaController.GravaCargaFichaTecnica(Tupla) then
            TLogImportacaoController.GravaLogImportacao(LogTupla);
        end

        else if Compara = 'PROMOCAO' then
        begin
          if not TProdutoPromocaoController.GravaCargaProdutoPromocao(Tupla) then
            TLogImportacaoController.GravaLogImportacao(LogTupla);
        end

        else if Compara = 'RESOLUCAO' then
        begin
          if not TResolucaoController.GravaCargaResolucao(Tupla) then
            TLogImportacaoController.GravaLogImportacao(LogTupla);
        end

        else if Compara = 'COMPONENTES' then
        begin
          if not TComponentesController.GravaCargaComponentes(Tupla) then
            TLogImportacaoController.GravaLogImportacao(LogTupla);
        end

        else if Compara = 'IMPRESSORA' then
        begin
          if not TImpressoraController.GravaCargaImpressora(Tupla) then
            TLogImportacaoController.GravaLogImportacao(LogTupla);
        end

        else if Compara = 'CONFIGURACAO' then
        begin
          if not TComponentesController.GravaCargaComponentes(Tupla) then
            TLogImportacaoController.GravaLogImportacao(LogTupla);
        end;

      Readln(atcarga);
    end;
    finally
      CloseFile(atcarga);
      Result := true;
    end;
    Result := true;
  end;
end;

function TfrmCargaPDV.ExportaCarga(RemoteApp: String): Boolean;
begin

end;

function TfrmCargaPDV.ExportaCancelamentoCupom(RemoteApp: String): Boolean;
begin

end;

procedure TfrmCargaPDV.Timer1Timer(Sender: TObject);
begin

end;

procedure TfrmCargaPDV.ImprimeParcelasECF(Nome, CPF, COO: String;
  TotalParcela: currency; ListaParcela:  TContasParcelasListaVO);
begin

end;

function TfrmCargaPDV.ExportaTabela(PathTabela: String): Boolean;
begin

end;

end.

