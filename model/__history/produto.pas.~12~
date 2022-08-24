unit produto;

interface

type
  TProduto = class

  private
    FCodigo: integer;
    FNome: string;
    FPreco: double;
    FCodUnidadeMedida: string;
    FTipoProduto: string;

    constructor Create;
    procedure setCodigo(const PCodigo: integer);
    procedure setNome(const PNome: string);
    procedure setPreco(const PPreco: double);
    procedure setCodUnidadeMedida(const PCodUnidadeMedida: string);
    procedure setTipoProduto(const PTipoProduto: string);

  public
    function getPrecoFormatado: string;

  published
    property Codigo: integer read FCodigo write setCodigo;
    property Nome: string read FNome write setNome;
    property Preco: double read FPreco write setPreco;
    property CodUnidadeMedida: string read FCodUnidadeMedida write setCodUnidadeMedida;
    property TipoProduto: string read FTipoProduto write setTipoProduto;

end;

implementation

uses
  System.SysUtils;

{TProduto}

constructor TProduto.Create;
begin
  FCodigo := 0;
  FNome := '';
  FPreco := 0;
  FCodUnidadeMedida := '';
  FTipoProduto := '';
end;

procedure TProduto.setCodigo(const PCodigo: integer);
begin
  FCodigo := PCodigo;
end;

procedure TProduto.setNome(const PNome: string);
begin
  FNome := PNome;
end;

procedure TProduto.setPreco(const PPreco: double);
begin
  FPreco := PPreco;
end;

procedure TProduto.setCodUnidadeMedida(const PCodUnidadeMedida: string);
begin
  FCodUnidadeMedida := PCodUnidadeMedida;
end;

procedure TProduto.setTipoProduto(const PTipoProduto: string);
begin
  FTipoProduto := PTipoProduto;
end;

function TProduto.getPrecoFormatado: string;
begin
  result := FormatFloat('0.00', FPreco);
end;

initialization
  TProduto.ClassName;

end.
