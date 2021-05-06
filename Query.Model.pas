unit Query.Model;

interface

uses
  Query.Interfaces, Conexao.Model, Conexao.Interfaces, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.VCLUI.Wait, FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteDef, FireDAC.Phys.FBDef, FireDAC.Phys.IBBase, FireDAC.Phys.FB, FireDAC.Phys.SQLite, FireDAC.Comp.UI, FireDAC.Comp.Client, FireDAC.Stan.StorageXML,
  FireDAC.Stan.StorageJSON, Data.DB, FireDAC.Comp.DataSet;

Type
  TQueryModel = class(TInterfacedObject, IQueryModel)
  private
    FConexaoModel: IConexaoBancoModel;
    FQuery: TFDQuery;
    FIsFound : Boolean;
    procedure CriarQuery;
  public
    Constructor Create(ConexaoModel: IConexaoBancoModel);
    Destructor Destroy; override;
    Class Function New(ConexaoModel: IConexaoBancoModel): IQueryModel;
    Function ObterResultSet(Const sql: String): TFDQuery;
    Function ObterDataSet(Var DataSet: TFDMemTable; const sql: String): IQueryModel;
    function Pesquisar(Const sql: String): IQueryModel;
    function Atribuir(Destino: TField; Const nomeCampo: String): IQueryModel;

    Function ResultQuery: TFDQuery;
    function IsFound : Boolean;

  end;

implementation

{ TQueryModel }

function TQueryModel.Atribuir(Destino: TField; const nomeCampo: String): IQueryModel;
begin
  if Not FQuery.IsEmpty then
  begin
    case Destino.DataType of
      ftUnknown: Destino.Value := FQuery.FieldByName(nomeCampo).Value;
      ftString: Destino.AsString := FQuery.FieldByName(nomeCampo).AsString;
      ftSmallint: Destino.Value := FQuery.FieldByName(nomeCampo).Value ;
      ftInteger:Destino.Value := FQuery.FieldByName(nomeCampo).Value ;
      ftWord: Destino.Value := FQuery.FieldByName(nomeCampo).Value;
      ftBoolean: Destino.AsBoolean := FQuery.FieldByName(nomeCampo).AsBoolean;
      ftFloat: Destino.AsFloat := FQuery.FieldByName(nomeCampo).AsFloat;
      ftCurrency:Destino.AsCurrency := FQuery.FieldByName(nomeCampo).AsCurrency;
      ftBCD: Destino.AsBCD := FQuery.FieldByName(nomeCampo).AsBCD;
      ftDate: Destino.AsDateTime := FQuery.FieldByName(nomeCampo).AsDateTime;
      ftTime:  Destino.AsDateTime := FQuery.FieldByName(nomeCampo).AsDateTime;
      ftDateTime:  Destino.AsDateTime := FQuery.FieldByName(nomeCampo).AsDateTime;
      ftBytes: Destino.AsBytes := FQuery.FieldByName(nomeCampo).AsBytes;
      ftVarBytes: Destino.value := FQuery.FieldByName(nomeCampo).value;
      ftAutoInc: Destino.Value := FQuery.FieldByName(nomeCampo).Value;
      ftBlob: Destino.Value := FQuery.FieldByName(nomeCampo).Value;
      ftMemo: Destino.Value := FQuery.FieldByName(nomeCampo).Value;
      ftGraphic: Destino.Value := FQuery.FieldByName(nomeCampo).Value;
      ftFmtMemo: Destino.Value := FQuery.FieldByName(nomeCampo).Value;
      ftParadoxOle: Destino.Value := FQuery.FieldByName(nomeCampo).Value;
      ftDBaseOle: Destino.Value := FQuery.FieldByName(nomeCampo).Value;
      ftTypedBinary: Destino.Value := FQuery.FieldByName(nomeCampo).Value ;
      ftCursor: Destino.Value := FQuery.FieldByName(nomeCampo).Value;
      ftFixedChar: Destino.AsString := FQuery.FieldByName(nomeCampo).AsString;
      ftWideString: Destino.AsString := FQuery.FieldByName(nomeCampo).AsString;
      ftLargeint: Destino.AsCurrency := FQuery.FieldByName(nomeCampo).AsCurrency;
      ftADT: Destino.Value := FQuery.FieldByName(nomeCampo).Value;
      ftArray: Destino.Value := FQuery.FieldByName(nomeCampo).Value;
      ftReference: Destino.Value := FQuery.FieldByName(nomeCampo).Value;
      ftDataSet: Destino.Value := FQuery.FieldByName(nomeCampo).Value;
      ftOraBlob: Destino.Value := FQuery.FieldByName(nomeCampo).Value;
      ftOraClob: Destino.Value := FQuery.FieldByName(nomeCampo).Value;
      ftVariant: Destino.Value := FQuery.FieldByName(nomeCampo).Value;
      ftInterface: Destino.Value := FQuery.FieldByName(nomeCampo).Value;
      ftIDispatch: Destino.Value := FQuery.FieldByName(nomeCampo).Value;
      ftGuid: Destino.AsGuid := FQuery.FieldByName(nomeCampo).AsGuid;
      ftTimeStamp: Destino.AsDateTime := FQuery.FieldByName(nomeCampo).AsDateTime;
      ftFMTBcd: Destino.Value := FQuery.FieldByName(nomeCampo).Value;
      ftFixedWideChar: Destino.AsString := FQuery.FieldByName(nomeCampo).AsString;
      ftWideMemo:Destino.Value := FQuery.FieldByName(nomeCampo).Value ;
      ftOraTimeStamp: Destino.Value := FQuery.FieldByName(nomeCampo).Value;
      ftOraInterval: Destino.Value := FQuery.FieldByName(nomeCampo).Value;
      ftLongWord:Destino.Value := FQuery.FieldByName(nomeCampo).Value ;
      ftShortint: Destino.Value := FQuery.FieldByName(nomeCampo).Value;
      ftByte: Destino.Value := FQuery.FieldByName(nomeCampo).Value;
      ftExtended: Destino.Value := FQuery.FieldByName(nomeCampo).Value;
      ftConnection: Destino.Value := FQuery.FieldByName(nomeCampo).Value;
      ftParams: Destino.Value := FQuery.FieldByName(nomeCampo).Value;
      ftStream: Destino.Value := FQuery.FieldByName(nomeCampo).Value;
      ftTimeStampOffset: Destino.Value := FQuery.FieldByName(nomeCampo).Value;
      ftObject: Destino.Value := FQuery.FieldByName(nomeCampo).Value;
      ftSingle: Destino.Value := FQuery.FieldByName(nomeCampo).Value;
    end;
  end;
  result := self;
end;

constructor TQueryModel.Create(ConexaoModel: IConexaoBancoModel);
begin
  FConexaoModel := ConexaoModel
end;

destructor TQueryModel.Destroy;
begin
  if Assigned(FQuery) then
    FQuery.Free;

  inherited;
end;

function TQueryModel.IsFound: Boolean;
begin
  result := FIsFound;
end;

class function TQueryModel.New(ConexaoModel: IConexaoBancoModel): IQueryModel;
begin
  result := self.Create(ConexaoModel);
end;

function TQueryModel.ObterDataSet(var DataSet: TFDMemTable; const sql: String): IQueryModel;
begin
  ObterResultSet(sql);
  result := self;
  DataSet.Data := FQuery.Data;
  FIsFound := Not FQuery.IsEmpty;
end;

function TQueryModel.ObterResultSet(Const sql: String): TFDQuery;
begin
  CriarQuery;
  FQuery.Open(sql);
  result := FQuery;
  FIsFound := Not FQuery.IsEmpty;
end;

function TQueryModel.Pesquisar(const sql: String): IQueryModel;
begin
  CriarQuery;
  FQuery.Open(sql);
  result := self;
  FIsFound := Not FQuery.IsEmpty;
end;

procedure TQueryModel.CriarQuery;
begin
  if not Assigned(FQuery) then
  begin
    FQuery := TFDQuery.Create(nil);
    FQuery.Connection := FConexaoModel.obterConexao;
  end;
end;

function TQueryModel.ResultQuery: TFDQuery;
begin

  result := FQuery;
end;

end.
