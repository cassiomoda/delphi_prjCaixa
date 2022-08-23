object dm: Tdm
  OldCreateOrder = False
  Height = 203
  Width = 238
  object conn: TFDConnection
    Params.Strings = (
      'DriverID=FB'
      'User_Name=SYSDBA'
      'Password=Tigre401!'
      'Database=C:\dev\delphi\prjCaixa\db\CAIXA.FDB'
      'Server=localhost')
    Connected = True
    LoginPrompt = False
    Left = 24
    Top = 16
  end
  object produtosTr: TFDTransaction
    Connection = conn
    Left = 24
    Top = 80
  end
  object produtosQry: TFDQuery
    Connection = conn
    Transaction = produtosTr
    SQL.Strings = (
      'SELECT * FROM produtos')
    Left = 24
    Top = 136
    object produtosQryCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object produtosQryNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Required = True
      Size = 255
    end
    object produtosQryPRECO: TFloatField
      FieldName = 'PRECO'
      Origin = 'PRECO'
      Required = True
    end
    object produtosQryCODUNIDADEMEDIDA: TStringField
      FieldName = 'CODUNIDADEMEDIDA'
      Origin = 'CODUNIDADEMEDIDA'
      Required = True
      Size = 5
    end
    object produtosQryTIPOPRODUTO: TStringField
      FieldName = 'TIPOPRODUTO'
      Origin = 'TIPOPRODUTO'
      Required = True
      Size = 255
    end
  end
  object unidadesMedidaTr: TFDTransaction
    Connection = conn
    Left = 96
    Top = 80
  end
  object unidadesMedidaQry: TFDQuery
    Connection = conn
    Transaction = unidadesMedidaTr
    SQL.Strings = (
      'SELECT * FROM unidades_medida')
    Left = 96
    Top = 136
    object unidadesMedidaQryCODIGO: TStringField
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 5
    end
    object unidadesMedidaQryNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Required = True
      Size = 255
    end
  end
  object tiposProdutoTr: TFDTransaction
    Connection = conn
    Left = 168
    Top = 80
  end
  object tiposProdutoQry: TFDQuery
    Connection = conn
    Transaction = tiposProdutoTr
    SQL.Strings = (
      'SELECT * FROM tipos_produto')
    Left = 168
    Top = 136
    object tiposProdutoQryNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 255
    end
  end
end
