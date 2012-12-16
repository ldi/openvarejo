unit UfrmPenDrive;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, StdCtrls, FileCtrl, UfrmBase;

type

  { TfrmPenDrive }

  TfrmPenDrive = class(TfrmBase)
    botaoCancela: TBitBtn;
    editPath: TEdit;
    ListTXT: TFileListBox;
    GroupBox1: TGroupBox;
    Image1: TImage;
    pnlBottom: TPanel;
    SelectDirectoryDialog: TSelectDirectoryDialog;
    SpeedButton1: TSpeedButton;
    procedure botaoCancelaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { private declarations }
  public
    Rotina :string;
  end;

var
  frmPenDrive: TfrmPenDrive;

implementation

uses UfrmCheckout, UfrmCargaPDV;

{$R *.lfm}

{ TfrmPenDrive }

procedure TfrmPenDrive.FormActivate(Sender: TObject);
begin
  Color := StringToColor(Configuracao.CorJanelasInternas);
end;

procedure TfrmPenDrive.botaoCancelaClick(Sender: TObject);
begin

end;

procedure TfrmPenDrive.FormShow(Sender: TObject);
begin
  if Rotina = 'IMPORTA' then
    Caption := 'Rotina de importação de dados do Pen-Drive'
  else if Rotina = 'EXPORTA' then
    Caption := 'Rotina de exportação de dados para Pen-Drive';

  editPath.Text := '';
end;

procedure TfrmPenDrive.SpeedButton1Click(Sender: TObject);
var
  iContaTXT: Integer;
  LocalApp, RemoteApp: String;
begin
  if SelectDirectoryDialog.Execute then
  begin
    editPath.Text:= trim(SelectDirectoryDialog.FileName);
    if Rotina = 'IMPORTA' then
    begin
      if FileExists(editPath.Text+'\carga.txt') then
      begin
        if FrmCargaPDV = nil then
          Application.CreateForm(TFrmCargaPDV, FrmCargaPDV);
        FrmCargaPDV.Tipo := 4;
        FrmCargaPDV.ShowModal;
        Application.ProcessMessages;
      end;//if FileExists(editPath.Text+'\carga.txt') then
    end
    else
    if Rotina = 'EXPORTA' then
    begin
      if DirectoryExists(editPath.Text) then
      begin
        ListTXT.Mask      := 'C*.txt';
        ListTXT.Directory := ExtractFilePath(Application.ExeName)+'Script\';
        ListTXT.Update;
        Application.ProcessMessages;
        for iContaTXT := 0 to ListTXT.Count -1 do
        begin
          LocalApp :=  ExtractFilePath(Application.ExeName)+'Script\'+ListTXT.Items[iContaTXT];
          RemoteApp := editPath.Text+'\'+ListTXT.Items[iContaTXT];
          if (FileExists(LocalApp)) and (LocalApp <> ExtractFilePath(Application.ExeName)+'Script\carga.txt') then
             if CopyFile(PChar(LocalApp), PChar(RemoteApp), False) then
                Application.ProcessMessages;
          LocalApp := '';
        end;//for iContaTXT := 0 to ListTXT.Count -1 do
        ShowMessage('Arquivos copiados para o Pen-Drive');
      end;//if DirectoryExists(editPath.Text) then
    end;//if Rotina = 'IMPORTA' then
  end;//if FolderDialog.Execute then
end;

end.

