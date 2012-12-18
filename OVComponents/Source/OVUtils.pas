
unit OVUtils;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpjson, jsonparser;

type

  { TOVFile }

  TOVFile = class
  public
    class function Load(const AFileName: string): string;
    class procedure Save(const AInput, AFileName: string; const AOpenMode: word = fmOpenReadWrite);
  end;

  { TOVJSONFile }

  TOVJSONFile = class
  public
    { TODO 1 -oheliosroots -cmake : Create Load Function }
    class procedure Save(const AInput: TJSONData; const AFileName: string);
  end;

  TOVXMLFile = class
    { TODO 2 -oheliosroots -cmake : Create Load and Save Functions }
  end;

function OVRoundDown(const AInput: double; const ADigits: integer = -2): double;
function OVTrunc(const AInput: double; const ADigits: integer = -2): double;

function OVDiffDays(const AStart, AStop: TDateTime): double;

implementation

uses
  Math;

function OVRoundDown(const AInput: double; const ADigits: integer): double;
var
  VRoundingMode: TFPURoundingMode;
begin
  VRoundingMode := GetRoundMode;
  try
    SetRoundMode(rmDown);
    Result := RoundTo(AInput, ADigits);
  finally
    SetRoundMode(VRoundingMode);
  end;
end;

function OVTrunc(const AInput: double; const ADigits: integer): double;
var
  VRoundingMode: TFPURoundingMode;
begin
  VRoundingMode := GetRoundMode;
  try
    SetRoundMode(rmTruncate);
    Result := RoundTo(AInput, ADigits);
  finally
    SetRoundMode(VRoundingMode);
  end;
end;

function OVDiffDays(const AStart, AStop: TDateTime): double;
begin
  { TODO 3 -oheliosroots -cmake : Difference days }
end;


{ TOVFile }

class function TOVFile.Load(const AFileName: string): string;
var
  VStream: TStream;
begin
  VStream := TFileStream.Create(AFileName, fmOpenRead);
  try
    SetLength(Result, vStream.Size);
    VStream.ReadBuffer(Pointer(Result)^, VStream.Size);
  finally
    VStream.Free;
  end;
end;

class procedure TOVFile.Save(const AInput, AFileName: string; const AOpenMode: word);
var
  VStream: TStream;
begin
  vStream := TFileStream.Create(AFileName, AOpenMode);
  try
    VStream.Seek(0, soFromEnd);
    VStream.Write(Pointer(AInput)^, Length(AInput));
  finally
    VStream.Free;
  end;
end;

{ TOVJSONFile }

class procedure TOVJSONFile.Save(const AInput: TJSONData; const AFileName: string);
begin
  TOVFile.Save(AInput.AsJSON, AFileName, fmCreate);
end;

end.



