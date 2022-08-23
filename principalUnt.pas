unit principalUnt;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, Vcl.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Layouts, FMX.ListBox,
  FMX.Edit, dmUnt, produto;

type
  TprincipalFrm = class(TForm)
    principalSTB: TStyleBook;
    tituloPnl: TPanel;
    tituloTxt: TText;
    rodapeLyt: TLayout;
    produtosBtn: TButton;
    unidadesMedidaBtn: TButton;
    tiposProdutoBtn: TButton;
    sairBtn: TButton;
    produtosLyt: TLayout;
    produtosTxt: TText;
    produtosList: TListBox;
    camposLyt: TLayout;
    contasBtn: TButton;
    novaContaBtn: TButton;
    itensLyt: TLayout;
    itensTxt: TText;
    itensList: TListBox;
    cancelarSalvarLyt: TLayout;
    cancelarBtn: TButton;
    salvarBtn: TButton;
    okBtn: TButton;
    nomeEdt: TEdit;
    nomeLbl: TLabel;
    dataLbl: TLabel;
    espacoDireitoLyt: TLayout;
    espacoEsquerdoLyt: TLayout;
    codigoContaLbl: TLabel;
    itemLbl: TLabel;
    precoLbl: TLabel;
    quantidadeEdt: TEdit;
    quantidadeLbl: TLabel;
    produtosSplitter: TSplitter;
    totalTxt: TText;
    totalLbl: TLabel;
    procedure FormShow(Sender: TObject);
    procedure sairBtnClick(Sender: TObject);
    procedure novaContaBtnClick(Sender: TObject);
    procedure produtosListDblClick(Sender: TObject);
    procedure okBtnClick(Sender: TObject);
  private
    { Private declarations }
    produtoSelecionado: TProduto;
    total: double;

    function atualizarListaProdutos(): boolean;
    function novoCodigoConta(): string;
    function getProdutoLista(linhaSelecionada: string): TProduto;
    function completarComEspacos(str: string; qtdMax: integer): string;
    procedure atualizarTotal();
  public
    { Public declarations }
  end;

var
  principalFrm: TprincipalFrm;

implementation

{$R *.fmx}

function TprincipalFrm.atualizarListaProdutos(): boolean;
begin
  try
    result := false;

    produtosList.Items.Clear;

    dm.produtosQry.Close;
    dm.produtosQry.Open;

    dm.tiposProdutoQry.Close;
    dm.tiposProdutoQry.Open;

    while not dm.tiposProdutoQry.Eof do
    begin
      produtosList.Items.Add(dm.tiposProdutoQryNOME.AsString);

      dm.produtosQry.Filtered := false;
      dm.produtosQry.Filter := 'tipoProduto = ' + QuotedStr(dm.tiposProdutoQryNOME.AsString);
      dm.produtosQry.Filtered := true;

      while not dm.produtosQry.Eof do
      begin
        produtosList.Items.Add(
          '  ' + dm.produtosQryCODIGO.AsString
          + ' - ' + dm.produtosQryNOME.AsString
          + ' R$ ' + FormatFloat('0.00', dm.produtosQryPRECO.Value)
          + '/' + UpperCase(dm.produtosQryCODUNIDADEMEDIDA.AsString)
        );

        dm.produtosQry.Next;
      end;

      dm.tiposProdutoQry.Next;
    end;

    result := true;
  finally
    dm.tiposProdutoQry.Close;

    dm.produtosQry.Filtered := false;
    dm.produtosQry.Filter := '';
    dm.produtosQry.Close;
  end;
end;

function TprincipalFrm.novoCodigoConta(): string;
begin
  result := FormatDateTime('yyyyMMdd', Now) + '1';
end;

procedure TprincipalFrm.okBtnClick(Sender: TObject);
var
  quantidade: double;
  subTotal: double;
begin
  if (quantidadeEdt.Text = '') then
  begin
    MessageDlg('Informe a quantidade', mtInformation, [mbOk], 0);
    quantidadeEdt.SetFocus;
  end
  else
  begin
    quantidade := StrToFloat(quantidadeEdt.Text);
    subTotal := quantidade * produtoSelecionado.Preco;
    total := total + subTotal;

    itensList.Items.Add(
      completarComEspacos(IntToStr(produtoSelecionado.Codigo) + ' - ' + produtoSelecionado.Nome, 19)
      + completarComEspacos(FormatFloat('0.00', quantidade), 8)
      + completarComEspacos(FormatFloat('0.00', subTotal), 10)
    );

    itemLbl.Text := 'Item: ';
    precoLbl.Text := 'Pre�o: ';
    quantidadeEdt.Text := '';
    quantidadeEdt.Enabled := false;
    okBtn.Enabled := false;

    atualizarTotal();
  end;
end;

function TprincipalFrm.getProdutoLista(linhaSelecionada: string): TProduto;
begin
  result := TProduto.Create();

  if (linhaSelecionada <> '') then
  begin
    result.Codigo := StrToInt(Copy(
      produtosList.Selected.Text, 2, Pos('-', produtosList.Selected.Text) - 3
    ));

    result.Nome := Copy(
      produtosList.Selected.Text,
      Pos('-', produtosList.Selected.Text) + 2,
      Pos('$', produtosList.Selected.Text) - 9
    );

    result.Preco := StrToFloat(Copy(
      produtosList.Selected.Text,
      Pos('$', produtosList.Selected.Text) + 2,
      Length(produtosList.Selected.Text) - (Pos('$', produtosList.Selected.Text) + 4)
    ));

    result.CodUnidadeMedida := UpperCase(Copy(
      produtosList.Selected.Text,
      Pos('/', produtosList.Selected.Text) + 1, 2
    ));
  end;
end;

function TprincipalFrm.completarComEspacos(str: string; qtdMax: integer): string;
begin
  if (Length(str) > qtdMax) then
  begin
    result := Copy(str, 0, qtdMax);
  end
  else
  begin
    while (Length(str) < qtdMax) do
    begin
      str := str + ' ';
    end;

    result := str;
  end;
end;

procedure TprincipalFrm.atualizarTotal();
begin
  totalLbl.Text := FormatFloat('0.00', total);
end;

procedure TprincipalFrm.produtosListDblClick(Sender: TObject);
begin
  if (produtosList.Selected.Text <> '') then
  begin
    produtoSelecionado := getProdutoLista(produtosList.Selected.Text);

    itemLbl.Text := 'Item: ' + produtoSelecionado.Nome;
    precoLbl.Text := 'Pre�o: R$ '
      + produtoSelecionado.getPrecoFormatado
      + ' por ' + produtoSelecionado.CodUnidadeMedida;

    okBtn.Enabled := true;
    quantidadeEdt.Enabled := true;
    quantidadeEdt.SetFocus;
  end;
end;

procedure TprincipalFrm.FormShow(Sender: TObject);
var
  titulo: string;
begin
  try
    if (dm = nil) then
      Application.CreateForm(Tdm, dm);

    if not dm.connectDB(GetCurrentDir) then
    begin
      MessageDlg('N�o foi poss�vel conectar a base de dados. '
        + 'Verifique o seu arquivo de configura��o.',
        mtInformation, [mbOk], 0
      );
    end;
  except
    on E: Exception do
    begin
      MessageDlg('Erro: ' + e.Message + '. Ao tentar conectar a base de dados.',
        mtError, [mbOk], 0
      );
    end;
  end;

  titulo := 'Caixa - ' + DateToStr(Now);
  principalFrm.Caption := titulo;
  tituloTxt.Text := titulo;
  codigoContaLbl.Text := '';
  dataLbl.Text := '';
end;

procedure TprincipalFrm.novaContaBtnClick(Sender: TObject);
begin
  if atualizarListaProdutos() then
  begin
    produtosList.Enabled := true;
    codigoContaLbl.Text := novoCodigoConta();
    dataLbl.Text := DateToStr(Now);
    nomeEdt.Enabled := true;
    nomeEdt.SetFocus;
    novaContaBtn.Enabled := false;
    itensList.Items.Add(
      completarComEspacos('Item', 22)
      + completarComEspacos('Qtd', 10)
      + completarComEspacos('Valor R$', 10)
    );
    total := 0;
    atualizarTotal();
    cancelarBtn.Enabled := true;
    salvarBtn.Enabled := true;
    itensList.Enabled := true;
  end;
end;

procedure TprincipalFrm.sairBtnClick(Sender: TObject);
begin
  Close;
end;

end.