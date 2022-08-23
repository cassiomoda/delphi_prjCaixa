unit dmUnt;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.FMXUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.FB, FireDAC.Phys.FBDef,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.VCLUI.Wait, System.IniFiles;

type
  Tdm = class(TDataModule)
    conn: TFDConnection;
    produtosTr: TFDTransaction;
    produtosQry: TFDQuery;
    produtosQryCODIGO: TIntegerField;
    produtosQryNOME: TStringField;
    produtosQryPRECO: TFloatField;
    produtosQryCODUNIDADEMEDIDA: TStringField;
    produtosQryTIPOPRODUTO: TStringField;
    unidadesMedidaTr: TFDTransaction;
    unidadesMedidaQry: TFDQuery;
    unidadesMedidaQryCODIGO: TStringField;
    unidadesMedidaQryNOME: TStringField;
    tiposProdutoTr: TFDTransaction;
    tiposProdutoQry: TFDQuery;
    tiposProdutoQryNOME: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
    function connectDB(appPath: string): boolean;
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

function Tdm.connectDB(appPath: string): boolean;
var
  confs: TIniFile;
begin
  conn.Connected := false;

  try
    confs := TIniFile.Create(appPath + '\confs.ini');

    conn.Params.Database := confs.ReadString('PARAMS', 'database', 'c:\dev\delphi\prjCaixa\db\caixa.fdb');
    conn.Params.UserName := confs.ReadString('PARAMS', 'userName', 'SYSDBA');
    conn.Params.Password := confs.ReadString('PARAMS', 'password', 'masterkey');

    conn.Connected := true;

    result := conn.Connected;
  except
    result := false;
  end;
end;

end.
