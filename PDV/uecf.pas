unit UECF;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, LMessages, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  VendaDetalheVO, TotalTipoPagamentoVO, Biblioteca,
  ACBrDevice;

  procedure AbreCupom(CPFouCNPJ, Nome, Endereco : String);
  procedure VendeItem(VendaDetalhe: TVendaDetalheVO);
  procedure CancelaItem(Item: Integer);
  procedure EfetuaFormaPagamento(TotalTipoPagamento: TTotalTipoPagamentoVo);
  procedure SubTotalizaCupom(AscDesc: Extended);
  procedure FechaCupom(Observacao: String);
  procedure CancelaCupom;
  procedure ReducaoZ;
  procedure LeituraX;
  procedure Suprimento(Valor: Extended; Descricao: String);
  procedure Sangria(Valor: Extended; Descricao: String);
  procedure PrimeiraReducaoDoMes;
  function ImpressoraOK(Msg : Integer = 1): Boolean;

const
  Estados : array[TACBrECFEstado] of string =
    ('Não Inicializada', 'Desconhecido', 'Livre', 'Venda',
    'Pagamento', 'Relatório', 'Bloqueada', 'Requer Z', 'Requer X', 'Nao Fiscal');

implementation

uses Udmprincipal, UfrmCheckout, PreVendaController, UPAF, ImpressoraVO,
  ImpressoraController, RegistroRController, MovimentoVO, MovimentoController, UfrmEncerraMovimento,
  UfrmIniciaMovimento;

procedure Suprimento(Valor: Extended; Descricao: String);
begin
  try
    dmprincipal.ACBrECF.Suprimento(Valor, 'SUPRIMENTO', Descricao, 'DINHEIRO');
  except
    Application.MessageBox('Falha ao Registrar o Suprimento de Caixa! Verifique a impressora e tente novamente!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    Abort;
  end;
end;

procedure Sangria(Valor: Extended; Descricao: String);
begin
  try
    dmprincipal.ACBrECF.Sangria(Valor, 'SANGRIA', Descricao, 'DINHEIRO');
  except
    Application.MessageBox('Falha ao Registrar a Sangria de Caixa! Verifique a impressora e tente novamente!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    Abort;
  end;
end;

procedure CancelaCupom;
begin
  try
    dmprincipal.ACBrECF.CancelaCupom;
  except
    Application.MessageBox('Falha ao Cancelar Cupom! Verifique a impressora e tente novamente!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    Abort;
  end;
  UPAF.AtualizaGT;
end;

procedure ReducaoZ;
var
  Impressora : TImpressoraVO;
  Estado, DataMovimento:String;
  Movimento: TMovimentoVO;
  ADate : TDateTime ;
begin
  if ImpressoraOK then
  begin
    ADate := dmprincipal.ACBrECF.DataMovimento;
    Estado := UECF.Estados[dmprincipal.ACBrECF.Estado];
    if Estado <> 'Requer Z' then
    begin
      try
        Movimento := TMovimentoController.VerificaMovimento;
        if Movimento.Id <> 0 then
        begin
          try
            Impressora := TImpressoraController.PegaImpressora(Movimento.IdImpressora);
            Application.CreateForm(TfrmEncerraMovimento, frmEncerraMovimento);
            frmEncerramovimento.AbreMovimento := False;
            if frmEncerraMovimento.ShowModal <> MROk then
            begin
              Application.MessageBox('É Necessário Encerrar o Movimento Para Emitir a Redução Z!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
              Exit;
            end
            else
            begin
              TPreVendaController.CancelaPreVendasPendentes(ADate);
            end; //if FEncerraMovimento.ShowModal <> MROk then
          finally
            FreeAndNil(frmEncerraMovimento);
          end;
          frmCheckout.StatusCaixa := 3;
        end; //if Movimento.Id <> 0 then
      finally
        if Assigned(Movimento) then
          FreeAndNil(Movimento);
      end;
    end;//if Estado <> 'Requer Z' then

    frmCheckout.labelMensagens.Caption := 'Redução Z - Aguarde!';

    dmprincipal.ACBrECF.Desativar;
    dmprincipal.ACBrECF.Ativar;

    UPAF.GravaR02R03;

    dmprincipal.ACBrECF.ReducaoZ;

    Estado := UECF.Estados[dmprincipal.ACBrECF.Estado];

    if Estado <> 'Bloqueada' then
    begin
      try
        TPreVendaController.CancelaPreVendasPendentes(ADate);
        Movimento := TMovimentoController.VerificaMovimento;
        if Movimento.Id <> 0 then
        begin
          Impressora := TImpressoraController.PegaImpressora(Movimento.IdImpressora);
          Movimento.DataFechamento := FormatDateTime('yyyy-mm-dd', dmprincipal.ACBrECF.DataHora);
          Movimento.HoraFechamento := FormatDateTime('hh:nn:ss', dmprincipal.ACBrECF.DataHora);
          Movimento.Status := 'F';
          TMovimentoController.EncerraMovimento(Movimento);
          try
            Application.CreateForm(TFrmEncerraMovimento, FrmEncerraMovimento);
            frmEncerraMovimento.Movimento := TMovimentoController.VerificaMovimento(Movimento.Id);
            FrmEncerraMovimento.ImprimeFechamento;
          finally
            FreeAndNil(FrmEncerraMovimento);
          end;
          Application.CreateForm(TFrmIniciaMovimento, FrmIniciaMovimento);
          FrmIniciaMovimento.ShowModal;
        end;//if Movimento.Id <> 0 then
      finally
        if Assigned(Movimento) then
          FreeAndNil(Movimento);
      end;
    end;//if Estado <> 'Bloqueada' then

    try
      DataMovimento := FormatDateTime('dd/mm/yyyy',ADate);
      UPAF.GeraMovimentoECF(DataMovimento, DataMovimento, DataMovimento, Impressora);
    finally
      if Assigned(Impressora) then
        FreeAndNil(Impressora);
    end;

    if not dmprincipal.ACBrECF.MFD then
      PrimeiraReducaoDoMes;

    frmCheckout.labelMensagens.Caption := 'Movimento do ECF Encerrado.';
  end;
end;

procedure LeituraX;
begin
  try
    dmprincipal.ACBrECF.LeituraX;
  except
    Application.MessageBox('Falha ao Realizar a Leitura X! Verifique a impressora e tente novamente!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    Abort;
  end;
end;

procedure AbreCupom(CPFouCNPJ, Nome, Endereco : String);
begin
  try
    dmprincipal.ACBrECF.AbreCupom(CPFouCNPJ, Nome, Endereco);
  except
    Application.MessageBox('Falha ao Abrir o Cupom! Verifique a impressora e tente novamente!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    Abort;
  end;
end;

procedure VendeItem(VendaDetalhe: TVendaDetalheVO);
begin
  try
    dmprincipal.ACBrECF.VendeItem(VendaDetalhe.GTIN, VendaDetalhe.DescricaoPDV, VendaDetalhe.ECFICMS, VendaDetalhe.Quantidade, VendaDetalhe.ValorUnitario);
  except
    Application.MessageBox('Falha ao Registrar Item!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    Abort;
  end;
end;

procedure EfetuaFormaPagamento(TotalTipoPagamento: TTotalTipoPagamentoVo);
begin
  try
    dmprincipal.ACBrECF.EfetuaPagamento(TotalTipoPagamento.CodigoPagamento,TotalTipoPagamento.Valor);
  except
    Application.MessageBox('Falha ao Efetuar Pagamento!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);  //Adicionar
    Abort;
  end;
end;

procedure SubTotalizaCupom(AscDesc: Extended);
begin
  try
    dmprincipal.ACBrECF.SubtotalizaCupom(AscDesc);
  except
    Application.MessageBox('Falha ao Sub Totalizar o Cupom!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);  //Adicionar
    Abort;
  end;
end;

procedure FechaCupom(Observacao: String);
begin
  try
    dmprincipal.ACBrECF.FechaCupom(Observacao);
  except
    Application.MessageBox('Falha ao Fechar o Cupom!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);  //Adicionar
    Abort;
  end;
  UPAF.AtualizaGT;
end;

procedure CancelaItem(Item: Integer);
begin
  try
    dmprincipal.ACBrECF.CancelaItemVendido(Item);
  except
    Application.MessageBox('Falha no Cancelamento do Ítem!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);  //Adicionar
    Abort;
  end;
end;

procedure PrimeiraReducaoDoMes;
var
  TotalRegistrosR02: Integer;
  DataInicio, DataFim: String;
begin
  DataInicio := '01' + Copy(DateToStr(dmprincipal.ACBrECF.DataHora),3,8);
  DataFim := UltimoDiaMes(dmprincipal.ACBrECF.DataHora) + Copy(DateToStr(dmprincipal.ACBrECF.DataHora),3,8);
  TotalRegistrosR02 := TRegistroRController.TotalR02(DataInicio,DataFim);
  if TotalRegistrosR02 = 1 then
    dmprincipal.ACBrECF.LeituraMemoriaFiscal(StrToDateTime(DataInicio),StrToDateTime(DataFim),True)
end;

function ImpressoraOK(Msg: Integer = 1): Boolean;  // por padrão Msg vai ser 1 não modificando o funcionamento atual da função.
var
  Mensagem, Estado: String;
begin
  result := true;
  Estado := UECF.Estados[dmprincipal.ACBrECF.Estado];
  if
  (Estado = 'Não Inicializada') or
  (Estado = 'Desconhecido') or
  (Estado = 'Bloqueada')
  then
  begin
    if Msg = 1 then
      Mensagem := 'Estado da Impressora: ' + Estado + '.'
    else if Msg = 2 then  // caso a chamada seja feita passando o parâmetro Msg com o valor 2 exibe uma mensagem diferente.
      Mensagem := 'Não é possível iniciar o movimento pois o estado da impressora é: ' + Estado + '.';
    Application.MessageBox(PChar(Mensagem), 'Erro do Sistema', MB_OK + MB_ICONERROR);
    result := false;
  end;
end;

end.
