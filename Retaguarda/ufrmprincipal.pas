unit Ufrmprincipal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus,
  ActnList, UfrmBase;

type

  { Tfrmprincipal }

  Tfrmprincipal = class(TfrmBase)
    actCadProdutos: TAction;
    actlVarejo: TActionList;
    ImglVarejo: TImageList;
    MenuItem2: TMenuItem;
    MenuItem1: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    mmVarejo: TMainMenu;
    procedure MenuItem2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmprincipal: Tfrmprincipal;

implementation

uses Uvariaveisbase;

{$R *.lfm}

{ Tfrmprincipal }

procedure Tfrmprincipal.FormCreate(Sender: TObject);
begin
  nomeform := 'Frente de Loja';
  inherited;
end;

procedure Tfrmprincipal.MenuItem2Click(Sender: TObject);
begin

end;

end.

