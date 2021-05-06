unit Controller.Pai;

interface

uses
  Data.DB, Vcl.Controls, Vcl.DBCtrls;

Type
  IControllerPai = interface
    ['{F689F1B7-76FE-4EA0-8B75-F21492BA00A8}']
    function  RegistrarDataSetDtSrc(DtSrc: TDataSource) : IControllerPai;
    function RegistrarDbWareEdit(DbWare: TDBEdit;  NomeCampo : String) : IControllerPai;
    function RegistrarDbWareLabel(DbWare: TDBText; NomeCampo : String) : IControllerPai;
    Function IsFound: Boolean;
  end;

implementation

end.
