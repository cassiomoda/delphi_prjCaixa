unit contasUnt;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, estilosUnt,
  FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, dmUnt,
  System.Rtti, FMX.Grid.Style, FMX.Grid, FMX.ScrollBox, conta, itemConsumido,
  Vcl.Dialogs;

type
  TcontasFrm = class(TForm)
    tituloPnl: TPanel;
    tituloTxt: TText;
    Layout1: TLayout;
    sairBtn: TButton;
    atualizarBtn: TButton;
    excluirBtn: TButton;
    contasFinalizadasTxt: TText;
    itensContaTxt: TText;
    contasGrid: TStringGrid;
    codigoClm: TStringColumn;
    nomeClm: TStringColumn;
    dataClm: TStringColumn;
    itensGrid: TStringGrid;
    produtoClm: TStringColumn;
    quantidadeClm: TFloatColumn;
    subTotalClm: TFloatColumn;
    unidadeMedidaClm: TStringColumn;
    totalClm: TFloatColumn;
    procedure sairBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure contasGridSelChanged(Sender: TObject);
    procedure atualizarBtnClick(Sender: TObject);
    procedure excluirBtnClick(Sender: TObject);
  private
    { Private declarations }
    contasList: TList;
    procedure listarContas();
  public
    { Public declarations }
  end;

var
  contasFrm: TcontasFrm;

implementation

{$R *.fmx}

procedure TcontasFrm.listarContas();
var
  linha: integer;
  conta: TConta;
begin
  contasGrid.RowCount := 0;
  contasList := dm.getListaContas();

  for linha := 0 to contasList.Count - 1 do
  begin
    conta := contasList[linha];

    contasGrid.RowCount := contasGrid.RowCount + 1;
    contasGrid.Cells[0, linha] := conta.Codigo;
    contasGrid.Cells[1, linha] := conta.Nome;
    contasGrid.Cells[2, linha] := DateTimeToStr(conta.Data);
    contasGrid.Cells[3, linha] := FormatFloat('0.00', conta.getTotal);
  end;
end;

procedure TcontasFrm.atualizarBtnClick(Sender: TObject);
begin
  listarContas();
end;

procedure TcontasFrm.contasGridSelChanged(Sender: TObject);
var
  conta: TConta;
  itemConsumido: TItemConsumido;
  linha: integer;
  codConta: string;
begin
//  itensGrid.ClearContent;
  itensGrid.RowCount := 0;
  codConta := contasGrid.Cells[0, contasGrid.Row];

  if (codConta <> '') then
  begin
    for linha := 0 to contasList.Count - 1 do
    begin
      conta := contasList[linha];

      if (codConta = conta.Codigo) then
        break
      else
        conta := nil;
    end;

    if (conta <> nil) then
    begin
      for linha := 0 to conta.Items.Count - 1 do
      begin
        itemConsumido := conta.Items[linha];
        itensGrid.RowCount := itensGrid.RowCount + 1;
        itensGrid.Cells[0, linha] := itemConsumido.Nome;
        itensGrid.Cells[1, linha] := FormatFloat('0.00', itemConsumido.Quantidade);
        itensGrid.Cells[2, linha] := FormatFloat('0.00', itemConsumido.Total);
        itensGrid.Cells[3, linha] := itemConsumido.CodUnidadeMedida;
      end;
    end;
  end;
end;

procedure TcontasFrm.excluirBtnClick(Sender: TObject);
var
  codConta: string;
begin
  codConta := contasGrid.Cells[0, contasGrid.Row];

  if (codConta <> '') then
  begin
    if MessageDlg('Deseja excluir a conta selecionada?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      if (dm.excluirConta(codConta)) then
      begin
        MessageDlg('Conta excluida com sucesso!', mtInformation, [mbOk], 0);
        listarContas();
      end
      else
        MessageDlg('N�o foi poss�vel excluir a conta. Tente novamente.', mtWarning, [mbOk], 0);
    end;
  end;
end;

procedure TcontasFrm.FormShow(Sender: TObject);
begin
  listarContas();
end;

procedure TcontasFrm.sairBtnClick(Sender: TObject);
begin
  Close;
end;

end.
