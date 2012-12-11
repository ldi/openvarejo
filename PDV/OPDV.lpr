program OPDV;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, rxnew, rx, zcomponent, UfrmBase, UfrmCheckout, UdmPrincipal,
  UdmPrincipalBase, Utiposdados, Uvariaveisbase, UfrmEfetuaPagamento,
ufrmSplash, UfrmMenuFiscal;

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TfrmCheckout, frmCheckout);
  Application.CreateForm(TfrmSplash, frmSplash);
  Application.CreateForm(TfrmMenuFiscal, frmMenuFiscal);
  Application.Run;
end.

