program prjCaixa;

uses
  System.StartUpCopy,
  FMX.Forms,
  principalUnt in 'principalUnt.pas' {principalFrm},
  dmUnt in 'dmUnt.pas' {dm: TDataModule},
  produto in 'model\produto.pas',
  itemConsumido in 'model\itemConsumido.pas',
  conta in 'model\conta.pas',
  contasUnt in 'contasUnt.pas' {contasFrm},
  estilosUnt in 'estilosUnt.pas' {estilosFrm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TprincipalFrm, principalFrm);
  Application.CreateForm(TestilosFrm, estilosFrm);
  Application.Run;
end.
