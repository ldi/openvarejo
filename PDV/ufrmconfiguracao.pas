unit UfrmConfiguracao;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, DbCtrls,
  ComCtrls, StdCtrls, ExtCtrls, DBGrids, Buttons, UfrmBase;

type

  { TfrmConfiguracao }

  TfrmConfiguracao = class(TfrmBase)
    botaoConfirma: TBitBtn;
    botaoCancela: TBitBtn;
    botaoBancoDados: TBitBtn;
    btFormaPgtoECF: TSpeedButton;
    btSincPgto: TSpeedButton;
    cmbBalanca: TComboBox;
    cmbBaudLeitorSerial: TComboBox;
    cmbBaudRate: TComboBox;
    cmbDataBits: TComboBox;
    cmbFilaLeitorSerial: TComboBox;
    cmbGavetaDinheiro: TComboBox;
    cmbHandShakeLeitorSerial: TComboBox;
    cmbHandShaking: TComboBox;
    cmbHardFlowSerial: TComboBox;
    cmbImprimeParcela: TComboBox;
    cmbNF2: TComboBox;
    cmbParidadeLeitorSerial: TComboBox;
    cmbParity: TComboBox;
    cmbPedeCPF: TComboBox;
    cmbPesquisaSQL: TComboBox;
    cmbPortaLeitorSerial: TComboBox;
    cmbPortaSerial: TComboBox;
    cmbSinalInvertido: TComboBox;
    cmbSoftFlowSerial: TComboBox;
    cmbStopBits: TComboBox;
    cmbStopLeitorSerial: TComboBox;
    cmbSufixoLeitorSerial: TComboBox;
    cmbTecladoReduzido: TComboBox;
    cmbTimerIntegracao: TComboBox;
    cmbTipoConfiguracaoBalanca: TComboBox;
    cmbTipoIntegracao: TComboBox;
    cmbUsaLeitorSerial: TComboBox;
    DBCheckBox1: TDBCheckBox;
    DBComboBox1: TDBComboBox;
    DBEdit1: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit13: TDBEdit;
    DBEdit14: TDBEdit;
    DBEdit15: TDBEdit;
    DBEdit16: TDBEdit;
    DBEdit17: TDBEdit;
    DBEdit18: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit20: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    DBGrid3: TDBGrid;
    DBLookupComboBox1: TDBLookupComboBox;
    DBLookupComboBox2: TDBLookupComboBox;
    DBLookupComboBox3: TDBLookupComboBox;
    DBLookupComboBox4: TDBLookupComboBox;
    DBLookupComboBox5: TDBLookupComboBox;
    DBLookupComboBox6: TDBLookupComboBox;
    editDataLeitorSerial: TEdit;
    editIntervaloLeitorSerial: TEdit;
    editSufixoLeitorSerial: TEdit;
    editTimeOut: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    Label1: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label3: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label4: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Label5: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    Label6: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    PageControl1: TPageControl;
    pnlbotoes: TPanel;
    ScrollBox1: TScrollBox;
    SelectDirectoryDialog1: TSelectDirectoryDialog;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    TbsDiversos: TTabSheet;
    tbsConfGeral: TTabSheet;
    TbsTef: TTabSheet;
    TbsComponentes: TTabSheet;
    TbsFormasPagamento: TTabSheet;
    TbsBalanca: TTabSheet;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmConfiguracao: TfrmConfiguracao;

implementation

{$R *.lfm}

end.

