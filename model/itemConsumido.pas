unit itemConsumido;

interface

type
  TItemConsumido = class

  private
    FCodigo: integer;
    FNome: string;
    FQuantidade: double;
    FCodUnidadeMedida: string;
    FTotal: double;

    constructor Create;
    procedure setCodigo(value: integer);
    procedure setNome(value: string);
    procedure setQuantidade(value: double);
    procedure setCodUnidadeMedida(value: string);
    procedure setTotal(value: double);

  public
    function getQuantidadeFormatada(): string;
    function getTotalFormatado(): string;

  published
    property Codigo: integer read FCodigo write setCodigo;
    property Nome: string read FNome write setNome;
    property Quantidade: double read FQuantidade write setQuantidade;
    property CodUnidadeMedida: string read FCodUnidadeMedida write setCodUnidadeMedida;
    property Total: double read FTotal write setTotal;

end;

implementation

uses
  System.SysUtils;

{TItemConsumido}

constructor TItemConsumido.Create;
begin
  FCodigo := 0;
  FNome := '';
  FQuantidade := 0;
  FCodUnidadeMedida := '';
  FTotal := 0;
end;

procedure TItemConsumido.setCodigo(value: integer);
begin
  FCodigo := value;
end;

procedure TItemConsumido.setNome(value: string);
begin
  FNome := value;
end;

procedure TItemConsumido.setQuantidade(value: double);
begin
  FQuantidade := value;
end;

procedure TItemConsumido.setCodUnidadeMedida(value: string);
begin
  FCodUnidadeMedida := value;
end;

procedure TItemConsumido.setTotal(value: double);
begin
  FTotal := value;
end;

function TItemConsumido.getQuantidadeFormatada: string;
begin
  result := FormatFloat('0.00', FQuantidade);
end;

function TItemConsumido.getTotalFormatado: string;
begin
  result := FormatFloat('0.00', FTotal);
end;

initialization
  TItemConsumido.ClassName;

end.
