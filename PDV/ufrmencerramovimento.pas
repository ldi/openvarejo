unit UfrmEncerraMovimento;

{$mode objfpc}{$H+}

interface

uses
  LCLIntf, LCLType, LMessages, Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Buttons, DBGrids, ActnList, curredit, rxmemds, sqldb, db, UfrmBase,
  MovimentoVO, Fgl;

type

  { TfrmEncerraMovimento }

  TfrmEncerraMovimento = class(TfrmBase)
    actRemover: TAction;
    actAdicionar: TAction;
    actConfirmar: TAction;
    actCancelar: TAction;
    actlEncerrar: TActionList;
    botaoConfirma: TBitBtn;
    botaoCancela: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    CDSResumoCALCULADO: TFloatField;
    CDSResumoDECLARADO: TFloatField;
    CDSResumoDIFERENCA: TFloatField;
    CDSResumoTIPO_PAGAMENTO: TStringField;
    ComboTipoPagamento: TComboBox;
    edtValor: TCurrencyEdit;
    edtTotal: TCurrencyEdit;
    dsFechamento: TDatasource;
    DSResumo: TDatasource;
    DBGrid1: TDBGrid;
    editSenhaOperador: TEdit;
    editLoginGerente: TEdit;
    editSenhaGerente: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Image1: TImage;
    ImglEncerrar: TImageList;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    LabelTurno: TLabel;
    Label3: TLabel;
    LabelTerminal: TLabel;
    Label5: TLabel;
    LabelImpressora: TLabel;
    Label7: TLabel;
    LabelOperador: TLabel;
    Label9: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    CDSResumo: TRxMemoryData;
    qryFechamento: TSQLQuery;
    qryFechamentoID: TLongintField;
    qryFechamentoTIPO_PAGAMENTO: TStringField;
    qryFechamentoVALOR: TFMTBCDField;
    procedure actAdicionarExecute(Sender: TObject);
    procedure actCancelarExecute(Sender: TObject);
    procedure actConfirmarExecute(Sender: TObject);
    procedure actRemoverExecute(Sender: TObject);
    procedure edtValorExit(Sender: TObject);
    procedure editSenhaGerenteExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FPodeFechar : Boolean;
  public
    Movimento: TMovimentoVO;
    FechouMovimento, AbreMovimento: Boolean;

    procedure TotalizaFechamento;
    procedure ImprimeFechamento;
    procedure Confirma;
  end;

var
  frmEncerraMovimento: TfrmEncerraMovimento;


implementation

uses Udmprincipal, OperadorController, OperadorVO,
  MovimentoController, UfrmCheckout, UfrmIniciaMovimento,
  TipoPagamentoController, TipoPagamentoVO, FechamentoVO,
  FechamentoController, MeiosPagamentoVO,
  TotalTipoPagamentoController, UPAF;

{$R *.lfm}

{ TfrmEncerraMovimento }

procedure TfrmEncerraMovimento.actRemoverExecute(Sender: TObject);
begin
  if not qryFechamento.IsEmpty then
  begin
    if TFechamentoController.ExcluiFechamento(qryFechamentoID.AsInteger) then
      TotalizaFechamento;
  end;
  ComboTipoPagamento.SetFocus;
end;

procedure TfrmEncerraMovimento.edtValorExit(Sender: TObject);
begin
  if edtValor.Value = 0  then
    editSenhaOperador.SetFocus;
end;

procedure TfrmEncerraMovimento.editSenhaGerenteExit(Sender: TObject);
begin
  botaoConfirma.SetFocus;
end;

procedure TfrmEncerraMovimento.FormActivate(Sender: TObject);
begin
  Color := StringToColor(Configuracao.CorJanelasInternas);
  ComboTipoPagamento.SetFocus;
end;

procedure TfrmEncerraMovimento.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  if FechouMovimento then
    ModalResult := mrOk
  else
    ModalResult := mrCancel;
  if Assigned(Movimento) then
    FreeAndNil(Movimento);
  closeAction := caFree;
  FrmEncerraMovimento := Nil;
end;

procedure TfrmEncerraMovimento.FormCloseQuery(Sender: TObject;
  var CanClose: boolean);
begin
  CanClose := FPodeFechar;
  if AbreMovimento then
  begin
    Application.CreateForm(TFrmIniciaMovimento, FrmIniciaMovimento);
    FrmIniciaMovimento.ShowModal;
  end;
end;

procedure TfrmEncerraMovimento.FormCreate(Sender: TObject);
  var
  i: Integer;
  ListaTipoPagamento: TTipoPagamentoListaVO;
begin
  inherited;
  FPodeFechar := false;
  AbreMovimento := True;
  FechouMovimento := False;
  Movimento := TMovimentoController.VerificaMovimento;
  LabelTurno.Caption := Movimento.DescricaoTurno;
  LabelTerminal.Caption := Movimento.NomeCaixa;
  LabelOperador.Caption := Movimento.LoginOperador;
  LabelImpressora.Caption := Movimento.IdentificacaoImpressora;

  TotalizaFechamento;
  try
    ListaTipoPagamento := TTipoPagamentoController.TabelaTipoPagamento;
    for i := 0 to ListaTipoPagamento.Count - 1 do
      ComboTipoPagamento.Items.Add(TTipoPagamentoVO(ListaTipoPagamento.Items[i]).Descricao);
    ComboTipoPagamento.ItemIndex := 0;
  finally
    FreeAndNil(ListaTipoPagamento);
  end;
end;

procedure TfrmEncerraMovimento.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 123 then
    Confirma;
end;

procedure TfrmEncerraMovimento.TotalizaFechamento;
var
  Total: Real;
begin
  Total := 0;

  qryFechamento.Close;
  qryFechamento.Params.ParamByName('pID_ECF_MOVIMENTO').AsInteger := Movimento.Id;
  qryFechamento.Open;

  if not qryFechamento.IsEmpty then
  begin
    qryFechamento.DisableControls;
    qryFechamento.First;
    while not qryFechamento.Eof do
    begin
      Total := Total + qryFechamentoVALOR.AsFloat;
      qryFechamento.Next;
    end;
    qryFechamento.EnableControls;
  end;
  edtTotal.Value := Total;

end;

procedure TfrmEncerraMovimento.ImprimeFechamento;
var
  i: Integer;
  TotalGerado: TMeiosPagamentoListaVO;
  TotalDeclarado: TMeiosPagamentoListaVO;
  Calculado, Declarado, Diferenca, Meio: AnsiString;
  TotCalculado, TotDeclarado, TotDiferenca: Currency;
  Suprimento,Sangria,NaoFiscal,TotalVenda,Desconto,
  Acrescimo,Recebido,Troco,Cancelado,TotalFinal: AnsiString;
begin
  try
    dmprincipal.ACBrECF.AbreRelatorioGerencial(Configuracao.GerencialX);
    dmprincipal.ACBrECF.LinhaRelatorioGerencial(StringOfChar('=',48));
    dmprincipal.ACBrECF.LinhaRelatorioGerencial('             FECHAMENTO DE CAIXA                ');
    dmprincipal.ACBrECF.PulaLinhas(1);
    dmprincipal.ACBrECF.LinhaRelatorioGerencial('DATA DE ABERTURA  : '+Movimento.DataAbertura);
    dmprincipal.ACBrECF.LinhaRelatorioGerencial('HORA DE ABERTURA  : '+Movimento.HoraAbertura);
    dmprincipal.ACBrECF.LinhaRelatorioGerencial('DATA DE FECHAMENTO: '+Movimento.DataFechamento);
    dmprincipal.ACBrECF.LinhaRelatorioGerencial('HORA DE FECHAMENTO: '+Movimento.HoraFechamento);
    dmprincipal.ACBrECF.LinhaRelatorioGerencial(Movimento.NomeCaixa+'  OPERADOR: '+Movimento.LoginOperador);
    dmprincipal.ACBrECF.LinhaRelatorioGerencial('MOVIMENTO: '+IntToStr(Movimento.id));
    dmprincipal.ACBrECF.LinhaRelatorioGerencial(StringOfChar('=',48));
    dmprincipal.ACBrECF.PulaLinhas(1);

    Suprimento := FloatToStrF(Movimento.TotalSuprimento,ffNumber,11,2);
    Suprimento := StringOfChar(' ', 13 - Length(Suprimento)) + Suprimento;
    Sangria    := FloatToStrF(Movimento.TotalSangria,ffNumber,11,2);
    Sangria    := StringOfChar(' ', 13 - Length(Sangria)) + Sangria;
    NaoFiscal  := FloatToStrF(Movimento.TotalNaoFiscal,ffNumber,11,2);
    NaoFiscal  := StringOfChar(' ', 13 - Length(NaoFiscal)) + NaoFiscal;
    TotalVenda := FloatToStrF(Movimento.TotalVenda,ffNumber,11,2);
    TotalVenda := StringOfChar(' ', 13 - Length(TotalVenda)) + TotalVenda;
    Desconto   := FloatToStrF(Movimento.TotalDesconto,ffNumber,11,2);
    Desconto   := StringOfChar(' ', 13 - Length(Desconto)) + Desconto;
    Acrescimo  := FloatToStrF(Movimento.TotalAcrescimo,ffNumber,11,2);
    Acrescimo  := StringOfChar(' ', 13 - Length(Acrescimo)) + Acrescimo;
    Recebido   := FloatToStrF(Movimento.TotalRecebido,ffNumber,11,2);
    Recebido   := StringOfChar(' ', 13 - Length(Recebido)) + Recebido;
    Troco      := FloatToStrF(Movimento.TotalTroco,ffNumber,11,2);
    Troco      := StringOfChar(' ', 13 - Length(Troco)) + Troco;
    Cancelado  := FloatToStrF(Movimento.TotalCancelado,ffNumber,11,2);
    Cancelado  := StringOfChar(' ', 13 - Length(Cancelado)) + Cancelado;
    TotalFinal := FloatToStrF(Movimento.TotalFinal,ffNumber,11,2);
    TotalFinal := StringOfChar(' ', 13 - Length(TotalFinal)) + TotalFinal;

    dmprincipal.ACBrECF.LinhaRelatorioGerencial('SUPRIMENTO...: '+Suprimento);
    dmprincipal.ACBrECF.LinhaRelatorioGerencial('SANGRIA......: '+Sangria);
    dmprincipal.ACBrECF.LinhaRelatorioGerencial('NAO FISCAL...: '+NaoFiscal);
    dmprincipal.ACBrECF.LinhaRelatorioGerencial('TOTAL VENDA..: '+TotalVenda);
    dmprincipal.ACBrECF.LinhaRelatorioGerencial('DESCONTO.....: '+Desconto);
    dmprincipal.ACBrECF.LinhaRelatorioGerencial('ACRESCIMO....: '+Acrescimo);
    dmprincipal.ACBrECF.LinhaRelatorioGerencial('RECEBIDO.....: '+Recebido);
    dmprincipal.ACBrECF.LinhaRelatorioGerencial('TROCO........: '+Troco);
    dmprincipal.ACBrECF.LinhaRelatorioGerencial('CANCELADO....: '+Cancelado);
    dmprincipal.ACBrECF.LinhaRelatorioGerencial('TOTAL FINAL..: '+TotalFinal);
    dmprincipal.ACBrECF.PulaLinhas(3);
    dmprincipal.ACBrECF.LinhaRelatorioGerencial('                 CALCULADO  DECLARADO  DIFERENCA');

    TotalGerado := TTotalTipoPagamentoController.EncerramentoTotal(Movimento.Id,1);

    if CDSResumo.Active then
    begin
      CDSResumo.EmptyTable;
    end
    else
      CDSResumo.Active:= True;

    //BY CLAUSQUELLER  - calcula a sangria e o suprimento.
    CDSResumo.Append;
    CDSResumoTIPO_PAGAMENTO.AsString := 'DINHEIRO';
    CDSResumoCALCULADO.AsFloat := Movimento.TotalSuprimento - Movimento.TotalSangria;
    CDSResumo.Post;
    //****************************

    for i := 0 to Pred(TotalGerado.Count) do
    begin
      if CDSResumo.Locate('TIPO_PAGAMENTO',TMeiosPagamentoVO(TotalGerado.Items[I]).Descricao,[loCaseInsensitive]) then
      begin
        CDSResumo.Edit;
        CDSResumoCALCULADO.AsFloat := CDSResumoCALCULADO.AsFloat + TMeiosPagamentoVO(TotalGerado.Items[I]).Total;
        CDSResumo.Post;
      end
      else
      begin
        CDSResumo.Append;
        CDSResumoTIPO_PAGAMENTO.AsString := TMeiosPagamentoVO(TotalGerado.Items[I]).Descricao;
        CDSResumoCALCULADO.AsFloat := TMeiosPagamentoVO(TotalGerado.Items[I]).Total;
        CDSResumo.Post;
      end;
    end;

    TotalDeclarado := TTotalTipoPagamentoController.EncerramentoTotal(Movimento.Id,2);

    for i := 0 to Pred(TotalDeclarado.Count) do
    begin
      if CDSResumo.Locate('TIPO_PAGAMENTO',TMeiosPagamentoVO(TotalDeclarado.Items[I]).Descricao,[loCaseInsensitive]) then
      begin
        CDSResumo.Edit;
        CDSResumoDECLARADO.AsFloat := CDSResumoDECLARADO.AsFloat + TMeiosPagamentoVO(TotalDeclarado.Items[I]).Total;
        CDSResumo.Post;
      end
      else
      begin
        CDSResumo.Append;
        CDSResumoTIPO_PAGAMENTO.AsString := TMeiosPagamentoVO(TotalDeclarado.Items[I]).Descricao;
        CDSResumoDECLARADO.AsFloat := TMeiosPagamentoVO(TotalDeclarado.Items[I]).Total;
        CDSResumo.Post;
      end;
    end;

    TotCalculado := 0;
    TotDeclarado := 0;
    TotDiferenca := 0;

    CDSResumo.First;
    while not CDSResumo.Eof do
    begin
      Calculado := FloatToStrF(CDSResumoCALCULADO.AsFloat,ffNumber,9,2);
      Calculado := StringOfChar(' ', 11 - Length(Calculado)) + Calculado;

      Declarado := FloatToStrF(CDSResumoDECLARADO.AsFloat,ffNumber,9,2);
      Declarado := StringOfChar(' ', 11 - Length(Declarado)) + Declarado;

      Diferenca := FloatToStrF(CDSResumoDIFERENCA.AsFloat,ffNumber,9,2);
      Diferenca := StringOfChar(' ', 11 - Length(Diferenca)) + Diferenca;

      Meio := Copy(CDSResumoTIPO_PAGAMENTO.AsString,1,15);
      Meio := StringOfChar(' ', 15 - Length(Meio)) + Meio;

      TotCalculado := TotCalculado + CDSResumoCALCULADO.AsFloat;
      TotDeclarado := TotDeclarado + CDSResumoDECLARADO.AsFloat;
      TotDiferenca := TotDiferenca + CDSResumoDIFERENCA.AsFloat;

      dmprincipal.ACBrECF.LinhaRelatorioGerencial(Meio+Calculado+Declarado+Diferenca);

      CDSResumo.Next;
    end;

    dmprincipal.ACBrECF.LinhaRelatorioGerencial(StringOfChar('-',48));

    Calculado := FloatToStrF(TotCalculado,ffNumber,9,2);
    Calculado := StringOfChar(' ', 11 - Length(Calculado)) + Calculado;
    Declarado := FloatToStrF(TotDeclarado,ffNumber,9,2);
    Declarado := StringOfChar(' ', 11 - Length(Declarado)) + Declarado;
    Diferenca := FloatToStrF(TotDiferenca,ffNumber,9,2);
    Diferenca := StringOfChar(' ', 11 - Length(Diferenca)) + Diferenca;

    dmprincipal.ACBrECF.LinhaRelatorioGerencial('TOTAL.........:'+Calculado+Declarado+Diferenca);
    dmprincipal.ACBrECF.PulaLinhas(4);
    dmprincipal.ACBrECF.LinhaRelatorioGerencial('    ________________________________________    ');
    dmprincipal.ACBrECF.LinhaRelatorioGerencial('                 VISTO DO CAIXA                 ');
    dmprincipal.ACBrECF.PulaLinhas(3);
    dmprincipal.ACBrECF.LinhaRelatorioGerencial('    ________________________________________    ');
    dmprincipal.ACBrECF.LinhaRelatorioGerencial('               VISTO DO SUPERVISOR              ');

    dmprincipal.ACBrECF.FechaRelatorio;
    UPAF.GravaR06('RG');
    Application.ProcessMessages;

  finally
    if Assigned(TotalGerado) then
      FreeAndNil(TotalGerado);
    if Assigned(TotalDeclarado) then
      FreeAndNil(TotalDeclarado);
  end;


end;

procedure TfrmEncerraMovimento.Confirma;
var
  Operador: TOperadorVO;
  Gerente: TOperadorVO;
begin
  try
    Operador := TOperadorVO.Create;
    Gerente := TOperadorVO.Create;

    try
      // verifica se senha do operador esta correta
      Operador := TOperadorController.ConsultaUsuario(Movimento.LoginOperador, editSenhaOperador.Text);
      if Operador.Id <> 0 then
      begin
        // verifica se senha do gerente esta correta
        Gerente := TOperadorController.ConsultaUsuario(editLoginGerente.Text,editSenhaGerente.Text);
        if Gerente.Id <> 0 then
        begin
          if (Gerente.Nivel = 'G') or (Gerente.Nivel = 'S') then
          begin
            //encerra movimento
            Movimento.DataFechamento := FormatDateTime('yyyy-mm-dd', dmprincipal.ACBrECF.DataHora);
            Movimento.HoraFechamento := FormatDateTime('hh:nn:ss', dmprincipal.ACBrECF.DataHora);
            Movimento.Status := 'F';
            TMovimentoController.EncerraMovimento(Movimento);
            Movimento := TMovimentoController.VerificaMovimento(Movimento.Id);
            ImprimeFechamento;
            Movimento := Movimento;
            Application.MessageBox('Movimento encerrado com sucesso.','Informação do Sistema', MB_OK + MB_ICONINFORMATION);
            FechouMovimento := True;
            FPodeFechar := true;
            botaoConfirma.ModalResult := mrOK;
            self.ModalResult := mrOK;
            Close;
          end
          else
          begin
            Application.MessageBox('Gerente ou Supervisor: nível de acesso incorreto.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
            editLoginGerente.SetFocus;
          end;//if (Gerente.Nivel = 'G') or (Gerente.Nivel = 'S') then
        end
        else
        begin
          Application.MessageBox('Gerente ou Supervisor: dados incorretos.','Informação do Sistema', MB_OK + MB_ICONINFORMATION);
          editLoginGerente.SetFocus;
        end;//if Gerente.Id <> 0 then
      end
      else
      begin
        Application.MessageBox('Operador: dados incorretos.','Informação do Sistema', MB_OK + MB_ICONINFORMATION);
        editSenhaOperador.SetFocus;
      end;//if Operador.Id <> 0 then
    except
    end;
  finally
    if Assigned(Operador) then
      FreeAndNil(Operador);
    if Assigned(Gerente) then
      FreeAndNil(Gerente);
  end;

end;

procedure TfrmEncerraMovimento.actAdicionarExecute(Sender: TObject);
  var
    Fechamento: TFechamentoVO;
begin
  if trim(ComboTipoPagamento.Text) = '' then
  begin
    Application.MessageBox('Informe uma forma de Pagamento Válida!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    ComboTipoPagamento.SetFocus;
    Exit;
  end;

  if edtValor.Value <= 0 then
  begin
    Application.MessageBox('Informe um Valor Válido!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    edtValor.SetFocus;
    Exit;
  end;

  try
    Fechamento := TFechamentoVO.Create;
    Fechamento.IdMovimento := Movimento.Id;
    Fechamento.TipoPagamento := ComboTipoPagamento.Text;
    Fechamento.Valor := edtValor.Value;

    if TFechamentoController.GravaFechamento(Fechamento) then
      TotalizaFechamento;
  finally
    FreeAndNil(Fechamento);
  end;
  edtValor.Clear;
  ComboTipoPagamento.SetFocus;
end;

procedure TfrmEncerraMovimento.actCancelarExecute(Sender: TObject);
begin
  FPodeFechar := true;
  Close;
end;

procedure TfrmEncerraMovimento.actConfirmarExecute(Sender: TObject);
begin
  Confirma;
end;


end.

