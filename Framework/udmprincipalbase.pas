unit UdmPrincipalBase;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Menus, ZConnection, IBConnection, sqldb;

type

  { TdmPrincipalBase }

  TdmPrincipalBase = class(TDataModule)
    IBCon: TSQLConnector;
    procedure DataModuleCreate(Sender: TObject);
  private
    { private declarations }
  public
    procedure Conecta_DB; virtual;
  end;

var
  dmPrincipalBase: TdmPrincipalBase;

implementation

{$R *.lfm}

{ TdmPrincipalBase }

procedure TdmPrincipalBase.DataModuleCreate(Sender: TObject);
begin
  Conecta_DB;
end;

procedure TdmPrincipalBase.Conecta_DB;
begin

end;

end.

