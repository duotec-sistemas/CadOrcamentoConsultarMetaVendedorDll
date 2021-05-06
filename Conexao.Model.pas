unit Conexao.Model;

interface
  uses Conexao.Interfaces, DadosConexao.interfaces,
  // Firedac
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.ConsoleUI.Wait, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteDef, FireDAC.Phys.MySQLDef, FireDAC.Phys.FBDef, FireDAC.Phys.MongoDBDef, FireDAC.Phys.MongoDB, FireDAC.Phys.IBBase, FireDAC.Phys.FB, FireDAC.Phys.MySQL, FireDAC.Phys.SQLite, FireDAC.Comp.UI, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
  System.SysUtils;
  //

Type
  TConexaoBancoModel = Class(TInterfacedObject, iConexaoBancoModel)
  private
    FConexao : TFDConnection;
    FDadosConexao : IDadosConexao;
  public
    Constructor Create(dadosConexao:IDadosConexao);
    Destructor Destroy; override;
    Class Function New(dadosConexao:IDadosConexao): iConexaoBancoModel;

    function obterConexao: TFDConnection;

  End;

implementation

{ TConexaoBancoModel }
constructor TConexaoBancoModel.Create(dadosConexao:IDadosConexao);
var
  s : String;
begin
  FDadosConexao := DadosConexao;
  if Not Assigned(dadosConexao) then
    raise Exception.Create('Não foi informado as informações para realizar a conexão com o banco de dados');


  FConexao := TFDConnection.Create(nil);

  s := Format('Database=%S' +sLineBreak
    + 'User_Name=%S' +sLineBreak
    + 'Password=%S' +sLineBreak
    + 'Protocol=TCPIP' +sLineBreak
    + 'Server=%S' +sLineBreak
    + 'Port=3050'  +sLineBreak
    + 'CharacterSet=WIN1252' +sLineBreak
    + 'DriverID=FB'  +sLineBreak
    + 'PageSize=16384',
    [
    FDadosConexao.getBancoDados,
    FDadosConexao.getUsuario,
    FDadosConexao.getSenha,
    FDadosConexao.getServidor]);

  FConexao.Params.Text := s;
  FConexao.DriverName := 'FB';


  FConexao.Connected := true;
end;

destructor TConexaoBancoModel.Destroy;
begin
   FConexao.Free;
  inherited;
end;

class function TConexaoBancoModel.New(dadosConexao:IDadosConexao): iConexaoBancoModel;
begin
  result := Self.Create(dadosConexao);
end;

function TConexaoBancoModel.obterConexao: TFDConnection;
begin
  result := FConexao;
end;

end.
