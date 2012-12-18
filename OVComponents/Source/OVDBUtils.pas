unit OVDBUtils;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, jsonConf;

type

  { TOVDBConfiguration }

  TOVDBConfiguration = class
    class procedure Load(AConnector: TSQLConnector; const AFileName, ASectionName: string);
    class procedure Save(AConnector: TSQLConnector; const AFileName, ASectionName: string);
  end;

implementation

{ TOVDBConfiguration }

class procedure TOVDBConfiguration.Load(AConnector: TSQLConnector; const AFileName, ASectionName: string);
var
  J: TJSONConfig;
begin
  J := TJSONConfig.Create(nil);
  try
    J.Filename := AFileName;
    J.OpenKey(ASectionName, True);
    AConnector.CharSet := J.GetValue('CharSet', 'Utf8');
    AConnector.ConnectorType := J.GetValue('ConnectorType ', 'Firebird');
    AConnector.DatabaseName := J.GetValue('DatabaseName', '');
    AConnector.HostName := J.GetValue('HostName', 'LocalHost');
    AConnector.Password := J.GetValue('Password', 'mypass');
    AConnector.UserName := J.GetValue('UserName', 'myname');
  finally
    J.Free
  end;
end;

class procedure TOVDBConfiguration.Save(AConnector: TSQLConnector; const AFileName, ASectionName: string);
var
  J: TJSONConfig;
begin
  J := TJSONConfig.Create(nil);
  try
    J.Filename := AFileName;
    J.OpenKey(ASectionName, True);
    J.SetValue('CharSet', AConnector.CharSet);
    J.SetValue('ConnectorType', AConnector.ConnectorType);
    J.SetValue('DatabaseName', AConnector.DatabaseName);
    J.SetValue('HostName', AConnector.HostName);
    J.SetValue('Password', AConnector.Password);
    J.SetValue('UserName', AConnector.UserName);
  finally
    J.Free
  end;
end;

end.
