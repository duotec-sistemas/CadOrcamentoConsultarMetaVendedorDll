unit MetaVendedor.Dao;

interface

uses DadosConexao.Interfaces, Conexao.Interfaces, Query.Interfaces,
  FireDAC.Comp.Client, Conexao.Model, Query.Model, Constantes.ErpNfePlus,
  System.DateUtils, System.SysUtils, Lib.Utilitarios, DebugHelper,
  System.Classes;

Type
  IMetaVendedorDao = interface
    ['{78DF7B46-E063-439A-8AAB-E9DF60F05F45}']
    function ObterMetaVendedor(CodVendedor: String; Hoje: TDateTime; TblMetaVendedor: TFDMemTable): IMetaVendedorDao;
    function isFound: Boolean;
  end;

  TMetaVendedorDao = class(TInterfacedObject, IMetaVendedorDao)
  private
    fDadosConexao: iDadosConexao;
    FIsFound: Boolean;
    stLog: TStringList;
    function isDiagnosis: Boolean;
    procedure GravarLog(s: String);
  public
    constructor Create(DadosConexao: iDadosConexao);
    destructor Destroy; override;
    class function New(DadosConexao: iDadosConexao): IMetaVendedorDao;

    function ObterMetaVendedor(CodVendedor: String; Hoje: TDateTime; TblMetaVendedor: TFDMemTable): IMetaVendedorDao;
    function isFound: Boolean;
  end;

implementation

{ TMetaVendedorDao }

constructor TMetaVendedorDao.Create(DadosConexao: iDadosConexao);
begin
  fDadosConexao := DadosConexao;
end;

destructor TMetaVendedorDao.Destroy;
begin
  if Assigned(stLog) then
    stLog.Free;
  inherited;
end;

procedure TMetaVendedorDao.GravarLog(s: String);
begin
  if Not Assigned(stLog) then
    stLog := TStringList.Create;

  if Not DirectoryExists(ExtractFilePath(ParamStr(0)) + 'log') then
    ForceDirectories(ExtractFilePath(ParamStr(0)) + 'log');

  stLog.Add(s);
  stLog.SAveToFile(ExtractFilePath(ParamStr(0)) + 'log\logDll.txt');
end;


function TMetaVendedorDao.isDiagnosis: Boolean;
var
  s: String;
begin
  result := false;
  if Pos('DIAGNOSIS', UpperCase(fDadosConexao.getBancoDados)) > 0 then
    result := true;

end;

function TMetaVendedorDao.isFound: Boolean;
begin
  result := FIsFound;
end;

class
  function TMetaVendedorDao.New(DadosConexao: iDadosConexao): IMetaVendedorDao;
begin
  result := Self.Create(DadosConexao);
end;

function TMetaVendedorDao.ObterMetaVendedor(CodVendedor: String; Hoje: TDateTime; TblMetaVendedor: TFDMemTable): IMetaVendedorDao;
Var
  s, dtInicial, dtFinal: String;
  Conexao: iConexaoBancoModel;
  Qry: IQueryModel;
  d, m, a: word;

begin
  result := Self;
  DecodeDate(Hoje, a, m, d);
  dtInicial := FormatDateTime('dd.mm.yyyy', EncodeDate(a, m, 1));
  dtFinal := FormatDateTime('dd.mm.yyyy', Hoje);

  Conexao := TConexaoBancoModel.New(fDadosConexao);
  Qry := TQueryModel.New(Conexao);

  TblMetaVendedor.Cancel;
  TblMetaVendedor.EmptyDataSet;
  TblMetaVendedor.Append;

  s := ' SELECT '
    + ' S106.CODVND, S106.NOMVND, S106.ID_SINAF106, '
    + ' COALESCE((SELECT S154.VLRMET FROM SINAF154 S154 WHERE S154.EMPGRP = S106.EMPGRP AND S154.CODVND = S106.CODVND AND'
    + '  S154.MESMOV = '+IntToStr(m)+' AND S154.ANOMOV = '+IntToStr(a)+'),0) AS VLRMETMES, '
    + ' COALESCE((SELECT SUM(S080.VLRTOTNFS) FROM SINAF080 S080 '
    + ' WHERE S080.EMPGRP = S106.EMPGRP AND S080.CODVND = S106.CODVND '
    + ' AND S080.STACFO = ' + QuotedStr('V')
    + ' AND S080.DTAEMS >= ' + QuotedStr(dtInicial)
    + 'AND S080.DTAEMS <= ' + QuotedStr(dtFinal);
  if isDiagnosis then
    s := s + ' AND (S080.CODSRENFS = ' + QuotedStr('PD') + ' OR S080.CODSRENFS = ' + QuotedStr('01') + ')';

  s := s + '),0) AS VLRVDA, '
    + ' COALESCE((SELECT SUM(S078.VLRNFE) FROM SINAF078 S078 WHERE S078.EMPGRP = S106.EMPGRP AND S078.CODVND = S106.CODVND AND S078.STACFO = ' + QuotedStr('D') + ' AND S078.DTAREC >= ' + QuotedStr(dtInicial) + ' AND S078.DTAREC <= ' +
    QuotedStr(dtFinal) +
    '),0) AS VLRDEV '
    + ' FROM SINAF106 S106 '
    + ' WHERE S106.CODVND = ' + QuotedStr(CodVendedor);

  GravarLog(s);
  If Qry.Pesquisar(s).isFound then
    Qry.Atribuir(TblMetaVendedor.FieldByName(_Id), 'ID_SINAF106')
      .Atribuir(TblMetaVendedor.FieldByName(_CodVendedor), 'CODVND')
      .Atribuir(TblMetaVendedor.FieldByName(_NomeVendedor), 'NOMVND')
      .Atribuir(TblMetaVendedor.FieldByName(_VlrMetaMensal), 'VLRMETMES')
      .Atribuir(TblMetaVendedor.FieldByName(_VlrVendaAteHoje), 'VLRVDA')
      .Atribuir(TblMetaVendedor.FieldByName(_VlrDevolucaoAteHoje), 'VLRDEV');

  FIsFound := Qry.Pesquisar(s).isFound;

  TDebuggerHelper.LogDebug(s);

  If TblMetaVendedor.FieldByName(_Id).AsString = '' then
    TblMetaVendedor.FieldByName(_Id).AsString := TLib.ObterGuid;

  TblMetaVendedor.Post;
end;

end.
