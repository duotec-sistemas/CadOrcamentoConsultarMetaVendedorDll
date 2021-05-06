unit Query.Interfaces;

interface

uses
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.VCLUI.Wait, FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteDef, FireDAC.Phys.FBDef, FireDAC.Phys.IBBase, FireDAC.Phys.FB, FireDAC.Phys.SQLite, FireDAC.Comp.UI, FireDAC.Comp.Client, FireDAC.Stan.StorageXML,
  FireDAC.Stan.StorageJSON, Data.DB, FireDAC.Comp.DataSet;

Type
  IQueryModel = Interface
  ['{C6EB1B10-7BD7-4183-8783-7E6897F54E45}']
    Function ObterResultSet(Const sql: String): TFDQuery;
    Function ObterDataSet(Var DataSet : TFDMemTable; const sql : String): iQueryModel;
    Function ResultQuery : TFDQuery;
    function Pesquisar(Const sql : String) : IQueryModel;
    function Atribuir (Destino : TField;  Const nomeCampo : String) : IQueryModel;
    function IsFound : Boolean;
  end;

implementation

end.
