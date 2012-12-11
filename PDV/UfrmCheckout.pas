unit UfrmCheckout;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, MRUList, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ExtCtrls, EditBtn, Spin, Menus, curredit, UfrmBase, LCLType;

type

  { TfrmCheckout }

  TfrmCheckout = class(TfrmBase)
    edtCodigo: TCurrencyEdit;
    edtquantidade: TCurrencyEdit;
    edtsubtotal: TCurrencyEdit;
    curedttotalgeral: TCurrencyEdit;
    edtvalortotal: TCurrencyEdit;
    edtvalorunit: TCurrencyEdit;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    imgOnline: TImage;
    imgOffline: TImage;
    imgProduto: TImage;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lbldescontoacrescimo: TLabel;
    lblMensagem: TLabel;
    LstbBobina: TListBox;
    Panel1: TPanel;
    pnlTOP: TPanel;
    pnlclient: TPanel;
    pnlDescricaoProduto: TPanel;
    pnlMensagens: TPanel;
    pnlTotalGeral: TPanel;
    pmFuncoes: TPopupMenu;
    Timer1: TTimer;
    tmmIntegracao: TTimer;
    procedure FormActivate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure TrataExcecao(Sender: TObject; E: Exception);
  private
    procedure DesabilitaControlesVenda;
    procedure HabilitaControlesVenda;
  public
    { public declarations }
  end;

var
  frmCheckout: TfrmCheckout;
  StatusCaixa: Integer; // 0-aberto | 1-venda em andamento | 2-venda em recuperação ou importação de PV/DAV | 3-So Consulta | 4-Usuario cancelou a tela Movimento Aberto | 5-Informando dados de NF

implementation

uses UdmPrincipal, ufrmSplash;

{$R *.lfm}

{ TfrmCheckout }

procedure TfrmCheckout.FormActivate(Sender: TObject);
begin
  frmCheckout.Repaint;
end;

procedure TfrmCheckout.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  inherited;
  if (StatusCaixa = 0) or (StatusCaixa = 3) then
  begin
    if MessageDlg('Tem Certeza Que Deseja Sair do Sistema?', 'Sair do Sistema',mtInformation,[mbOk,mbCancel],0)=mrOk then
    begin
      dmprincipal.ACBrECF.Desativar;
      Application.Terminate;
    end
    else
      CanClose := False;
  end
 else
  begin
    Application.MessageBox('Existe uma venda em andamento.', 'Informação do Sistema',MB_ICONINFORMATION);
    CanClose := False;
  end;
end;

procedure TfrmCheckout.FormCreate(Sender: TObject);
begin
  inherited;
  Application.CreateForm(TfrmSplash, frmSplash);
  frmSplash.Show;
  //Application.OnException := TrataExcecao;

  Application.CreateForm(TdmPrincipal, dmPrincipal);
end;

procedure TfrmCheckout.TrataExcecao(Sender: TObject; E: Exception);
begin

end;

procedure TfrmCheckout.DesabilitaControlesVenda;
begin

end;

procedure TfrmCheckout.HabilitaControlesVenda;
begin

end;

end.

