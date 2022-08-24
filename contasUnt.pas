unit contasUnt;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, estilosUnt,
  FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, dmUnt,
  System.Rtti, FMX.Grid.Style, FMX.Grid, FMX.ScrollBox, conta, itemConsumido;

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
    procedure sairBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure contasGridSelChanged(Sender: TObject);
  private
    { Private declarations }
    contasList: TList;
  public
    { Public declarations }
  end;

var
  contasFrm: TcontasFrm;

implementation

{$R *.fmx}

procedure TcontasFrm.contasGridSelChanged(Sender: TObject);
begin
//atualizar grid de itens
end;

procedure TcontasFrm.FormShow(Sender: TObject);
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
  end;
end;

procedure TcontasFrm.sairBtnClick(Sender: TObject);
begin
  Close;
end;

end.
