unit Conexao.Interfaces;

interface

uses
  dadosConexao.Interfaces,
  // Firedac
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.ConsoleUI.Wait, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteDef, FireDAC.Phys.MySQLDef, FireDAC.Phys.FBDef, FireDAC.Phys.MongoDBDef, FireDAC.Phys.MongoDB, FireDAC.Phys.IBBase, FireDAC.Phys.FB, FireDAC.Phys.MySQL, FireDAC.Phys.SQLite, FireDAC.Comp.UI, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet;
  //

Type
  iConexaoBancoModel = interface
    ['{EBD48F9A-A874-4E93-B585-53B85AB1BD4E}']
    function obterConexao: TFDConnection;
  end;

implementation

end.
