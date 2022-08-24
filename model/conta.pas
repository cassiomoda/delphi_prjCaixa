unit conta;

interface

uses
  System.SysUtils, Classes, itemConsumido;

type
  TConta = class

  private
    FCodigo: string;
    FNome: string;
    FData: TDateTime;
    FItems: TList;

    constructor Create;
    procedure setCodigo(value: string);
    procedure setNome(value: string);
    procedure setData(value: TDateTime);

  public
    procedure adicionarItem(item: TItemConsumido);
    procedure removerItem(item: TItemConsumido);
    function pesquisarItem(item: TItemConsumido): integer;
    function getTotal(): double;

  published
    property Codigo: string read FCodigo write setCodigo;
    property Nome: string read FNome write setNome;
    property Data: TDateTime read FData write setData;
    property Items: TList read FItems;

end;

implementation

{TConta}

constructor TConta.Create;
begin
  FCodigo := '';
  FNome := '';
  FData := Now;
  FItems := TList.Create;
end;

procedure TConta.setCodigo(value: string);
begin
  FCodigo := value;
end;

procedure TConta.setNome(value: string);
begin
  FNome := value;
end;

procedure TConta.setData(value: TDateTime);
begin
  FData := value;
end;

procedure TConta.adicionarItem(item: TItemConsumido);
var
  index: integer;
  itemLista: TItemConsumido;
begin
  if (FItems = nil) then
    FItems := TList.Create;

  index := -1;
  index := pesquisarItem(item);

  if (index < 0) then
    FItems.Add(item)
  else
  begin
    itemLista := FItems[index];
    itemLista.Quantidade := itemLista.Quantidade + item.Quantidade;
    itemLista.Total := itemLista.Total + item.Total;
    FItems[index] := itemLista;
  end;
end;

procedure TConta.removerItem(item: TItemConsumido);
begin
  FItems.Remove(item);
end;

function TConta.pesquisarItem(item: TItemConsumido): integer;
var
  index: integer;
  itemConsumido: TItemConsumido;
begin
  result := -1;

  if (FItems <> nil) then
  begin
    for index := 0 to FItems.Count - 1 do
    begin
      itemConsumido := FItems[index];

      if (item.Codigo = itemConsumido.Codigo) then
      begin
        result := index;
        break;
      end;
    end;
  end;
end;

function TConta.getTotal(): double;
var
  itemConsumido: TItemConsumido;
  index: integer;
begin
  result := 0;

  if (FItems.Count > 0) then
  begin
    for index := 0 to FItems.Count - 1 do
    begin
      itemConsumido := FItems[index];
      result := result + itemConsumido.Total;
    end;
  end;
end;

initialization
  TConta.ClassName;

end.
