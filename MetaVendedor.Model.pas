unit MetaVendedor.Model;

interface

uses
  Data.DB, Vcl.Controls, FireDAC.Comp.Client, Constantes.ErpNfePlus,
  Vcl.DBCtrls, Lib.Utilitarios, System.DateUtils, System.SysUtils, DadosConexao.Interfaces, MetaVendedor.Dao, DadosConexao.Model;

Type
  IMetaVendedorModel = interface
    ['{4D8B364A-FB74-4C7F-93DF-125B1E2AA0A7}']
    function RegistrarDataSetDtSrc(DtSrc: TDataSource): IMetaVendedorModel;
    function RegistrarDbWareEdit(DbWare: TDBEdit; NomeCapo: String): IMetaVendedorModel;
    function RegistrarDbWareLabel(DbWare: TDBText; NomeCampo: String): IMetaVendedorModel;
    function ObterMetaVendedor(CodVendedor: String; DtBase: TDateTime): IMetaVendedorModel;
    function IsFound: boolean;
    function MetaVendedor: TFDMemTable;
  end;

  TMetaVendedorModel = class(TInterfacedObject, IMetaVendedorModel)
  private
    fMetaVendedorDao: IMetaVendedorDao;
    FTblMetaVendedor: TFDMemTable;
    FDadosConexao: IDadosConexao;
    FIsFound: boolean;
    function CalcularDiasUteis(Hoje: TDateTime): Integer;
    function CalcularDiasUteisAteHoje(Hoje: TDateTime): Integer;
    procedure ObterMetaVendedorTeste(CodVendedor: String; DtBase: TDateTime);
    function MetaVendedor: TFDMemTable;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: IMetaVendedorModel;

    function RegistrarDataSetDtSrc(DtSrc: TDataSource): IMetaVendedorModel;
    function RegistrarDbWareEdit(DbWare: TDBEdit; NomeCampo: String): IMetaVendedorModel;
    function RegistrarDbWareLabel(DbWare: TDBText; NomeCampo: String): IMetaVendedorModel;
    function ObterMetaVendedor(CodVendedor: String; DtBase: TDateTime): IMetaVendedorModel;
    function IsFound: boolean;

  end;

implementation

{ TMetaVendedorModel }

function TMetaVendedorModel.CalcularDiasUteis(Hoje: TDateTime): Integer;
Var
  d, m, a, mm, hh, ss, ms: Word;
  dtInicial, dtFinal: TDateTime;
begin
  result := 0;
  DecodeDateTime(Hoje, a, m, d, hh, mm, ss, ms);
  dtInicial := EncodeDateTime(a, m, 1, 0, 0, 0, 0);
  m := m + 1;
  if m > 12 then
  begin
    m := 1;
    a := a + 1;
  end;

  dtFinal := EncodeDateTime(a, m, 1, 0, 0, 0, 0);
  while dtInicial < dtFinal do
  begin
    if (DayOfTheWeek(dtInicial) > 1) and (DayOfTheWeek(dtInicial) < 7) then
      result := result + 1;
    dtInicial := dtInicial + 1;
  end;
end;

function TMetaVendedorModel.CalcularDiasUteisAteHoje(Hoje: TDateTime): Integer;
Var
  d, m, a, mm, hh, ss, ms: Word;
  dtInicial: TDateTime;
begin
  result := 0;
  DecodeDateTime(Hoje, a, m, d, hh, mm, ss, ms);
  dtInicial := EncodeDateTime(a, m, 1, 0, 0, 0, 0);

  while dtInicial <= Hoje do
  begin
    if (DayOfTheWeek(dtInicial) <= 5) then
      result := result + 1;
    dtInicial := dtInicial + 1;
  end;

end;

constructor TMetaVendedorModel.Create;
Var
  pasta, arqConfiguracao: String;
begin
  FTblMetaVendedor := TFDMemTable.Create(nil);

  // Criar os campos Tabela de Meta Vendedor
  FTblMetaVendedor.FieldDefs.Add(_Id, ftString, 44);
  FTblMetaVendedor.FieldDefs.Add(_CodVendedor, ftString, 3);
  FTblMetaVendedor.FieldDefs.Add(_NomeVendedor, ftString, 60);
  FTblMetaVendedor.FieldDefs.Add(_VlrMetaMensal, ftCurrency);
  FTblMetaVendedor.FieldDefs.Add(_VlrVendaAteHoje, ftCurrency);
  FTblMetaVendedor.FieldDefs.Add(_VlrMetaAteHoje, ftCurrency);
  FTblMetaVendedor.FieldDefs.Add(_VlrDevolucaoAteHoje, ftCurrency);
  FTblMetaVendedor.FieldDefs.Add(_VlrVendaLiquidaAteHoje, ftCurrency);
  FTblMetaVendedor.FieldDefs.Add(_VlrMetaDiaria, ftCurrency);
  FTblMetaVendedor.FieldDefs.Add(_VlrMetaDiariaReajustada, ftCurrency);
  FTblMetaVendedor.FieldDefs.Add(_QtDiasUteisMes, ftInteger);
  FTblMetaVendedor.FieldDefs.Add(_QtdDiasRestanteMes, ftInteger);
  FTblMetaVendedor.CreateDataSet;
  //
  FDadosConexao := TDadosConexao.New;
  FDadosConexao.ObterDadosConexao(pasta, arqConfiguracao);

  fMetaVendedorDao := TMetaVendedorDao.New(FDadosConexao);
end;

destructor TMetaVendedorModel.Destroy;
begin
  FTblMetaVendedor.Free;
  inherited;
end;

function TMetaVendedorModel.IsFound: boolean;
begin
  result := FIsFound;
end;

function TMetaVendedorModel.MetaVendedor: TFDMemTable;
begin
  result := FTblMetaVendedor;
end;

class function TMetaVendedorModel.New: IMetaVendedorModel;
begin
  result := self.Create;
end;

function TMetaVendedorModel.ObterMetaVendedor(CodVendedor: String; DtBase: TDateTime): IMetaVendedorModel;
Var
  Vlr: Currency;
  QtdDiasFaltaFinalizarMes, QtDiasUteisMes, QtdDiasUteisAteHoje: Integer;
begin
  result := self;
  FIsFound := false;
  QtDiasUteisMes := CalcularDiasUteis(Date());
  QtdDiasUteisAteHoje := CalcularDiasUteisAteHoje(Date);
  If Not fMetaVendedorDao.ObterMetaVendedor(CodVendedor, DtBase, FTblMetaVendedor).IsFound then
    Exit;

  FIsFound := true;


  // Ajustes da regra
  FTblMetaVendedor.Edit;
  FTblMetaVendedor.FieldByName(_QtDiasUteisMes).AsInteger := QtDiasUteisMes;
  FTblMetaVendedor.FieldByName(_QtdDiasRestanteMes).AsInteger := QtDiasUteisMes - QtdDiasUteisAteHoje + 1;
  FTblMetaVendedor.FieldByName(_VlrVendaLiquidaAteHoje).AsCurrency := FTblMetaVendedor.FieldByName(_VlrVendaAteHoje).AsCurrency - FTblMetaVendedor.FieldByName(_VlrDevolucaoAteHoje).AsCurrency;
  FTblMetaVendedor.FieldByName(_VlrMetaDiaria).AsCurrency := FTblMetaVendedor.FieldByName(_VlrMetaMensal).AsCurrency / QtDiasUteisMes;
  FTblMetaVendedor.FieldByName(_VlrMetaAteHoje).AsCurrency := FTblMetaVendedor.FieldByName(_VlrMetaDiaria).AsCurrency * QtdDiasUteisAteHoje;

  // Ajustar a Meta Diaria
  Vlr := FTblMetaVendedor.FieldByName(_VlrMetaMensal).AsCurrency - FTblMetaVendedor.FieldByName(_VlrVendaLiquidaAteHoje).AsCurrency;
  QtdDiasFaltaFinalizarMes := QtDiasUteisMes - QtdDiasUteisAteHoje + 1;

  FTblMetaVendedor.FieldByName(_VlrMetaDiariaReajustada).AsCurrency := Vlr / QtdDiasFaltaFinalizarMes;

  if FTblMetaVendedor.FieldByName(_VlrMetaDiariaReajustada).AsCurrency < 0 then
    FTblMetaVendedor.FieldByName(_VlrMetaDiariaReajustada).AsCurrency := 0;

  FTblMetaVendedor.Post;

end;

procedure TMetaVendedorModel.ObterMetaVendedorTeste(CodVendedor: String; DtBase: TDateTime);
Var
  Vlr: Currency;
  QtdDiasFaltaFinalizarMes, QtDiasUteisMes, QtdDiasUteisAteHoje: Integer;
begin
  QtDiasUteisMes := CalcularDiasUteis(Date());
  QtdDiasUteisAteHoje := CalcularDiasUteisAteHoje(Date);

  FTblMetaVendedor.Cancel;
  FTblMetaVendedor.EmptyDataSet;
  FTblMetaVendedor.Append;

  FTblMetaVendedor.FieldByName(_Id).AsString := TLib.ObterGuid;
  FTblMetaVendedor.FieldByName(_CodVendedor).AsString := '001';
  FTblMetaVendedor.FieldByName(_NomeVendedor).AsString := 'TONE CEZAR DA COSTA';
  FTblMetaVendedor.FieldByName(_VlrMetaMensal).AsCurrency := 10000;
  FTblMetaVendedor.FieldByName(_VlrVendaAteHoje).AsCurrency := 3200;
  FTblMetaVendedor.FieldByName(_VlrDevolucaoAteHoje).AsCurrency := 100;

  FTblMetaVendedor.FieldByName(_QtDiasUteisMes).AsInteger := QtDiasUteisMes;
  FTblMetaVendedor.FieldByName(_QtdDiasRestanteMes).AsInteger := QtdDiasUteisAteHoje;

  FTblMetaVendedor.FieldByName(_VlrVendaLiquidaAteHoje).AsCurrency := FTblMetaVendedor.FieldByName(_VlrVendaAteHoje).AsCurrency - FTblMetaVendedor.FieldByName(_VlrDevolucaoAteHoje).AsCurrency;

  FTblMetaVendedor.FieldByName(_VlrMetaDiaria).AsCurrency := FTblMetaVendedor.FieldByName(_VlrMetaMensal).AsCurrency / QtDiasUteisMes;

  FTblMetaVendedor.FieldByName(_VlrMetaAteHoje).AsCurrency := FTblMetaVendedor.FieldByName(_VlrMetaDiaria).AsCurrency * QtdDiasUteisAteHoje;

  // Ajustar a Meta Diaria
  Vlr := FTblMetaVendedor.FieldByName(_VlrMetaMensal).AsCurrency - FTblMetaVendedor.FieldByName(_VlrVendaLiquidaAteHoje).AsCurrency;
  QtdDiasFaltaFinalizarMes := QtDiasUteisMes - QtdDiasUteisAteHoje;

  FTblMetaVendedor.FieldByName(_VlrMetaDiariaReajustada).AsCurrency := Vlr / QtdDiasFaltaFinalizarMes;

  FTblMetaVendedor.Post;

end;

function TMetaVendedorModel.RegistrarDataSetDtSrc(DtSrc: TDataSource): IMetaVendedorModel;
begin
  result := self;
  DtSrc.DataSet := FTblMetaVendedor;
end;

function TMetaVendedorModel.RegistrarDbWareEdit(DbWare: TDBEdit; NomeCampo: String): IMetaVendedorModel;
begin
  result := self;
  TDBEdit(DbWare).DataField := NomeCampo;
end;

function TMetaVendedorModel.RegistrarDbWareLabel(DbWare: TDBText; NomeCampo: String): IMetaVendedorModel;
begin
  result := self;
  TDBText(DbWare).DataField := NomeCampo;
end;

end.
