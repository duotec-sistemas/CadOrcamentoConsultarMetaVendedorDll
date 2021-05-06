unit MetaVendedor.Controller;

interface

uses
  Data.DB, Vcl.Controls, Vcl.DBCtrls,  MetaVendedor.Model;

Type
  IMetaVendedorController = interface
    ['{770C27FB-CC2E-4574-8584-D879E686235A}']
    Function ObterMetaVendedor(CodVendedor: String; DtBase: TDateTime): IMetaVendedorController;
    Function  RegistrarDataSetDtSrc(DtSrc: TDataSource) : IMetaVendedorController;
    Function  RegistrarDbWareEdit(DbWare: TDBEdit; NomeCampo : String) : IMetaVendedorController;
    Function  RegistrarDbWareLabel(DbWare: TDBText; NomeCampo : String) : IMetaVendedorController;

    function Model : IMetaVendedorModel;
    Function IsFound: boolean;

  end;

  TMetaVendedorController = class(TInterfacedObject, IMetaVendedorController)
  private
    FMetaVendedorModel: IMetaVendedorModel;
    FIsFound: boolean;

  public
    constructor Create;
    destructor Destroy; override;
    class function New: IMetaVendedorController;

    Function  RegistrarDataSetDtSrc(DtSrc: TDataSource) : IMetaVendedorController;
    Function  RegistrarDbWareEdit(DbWare: TDBEdit; NomeCampo : String) : IMetaVendedorController;
    Function  RegistrarDbWareLabel(DbWare: TDBText; NomeCampo : String) : IMetaVendedorController;
    Function IsFound: boolean;
    function Model : IMetaVendedorModel;


    Function ObterMetaVendedor(CodVendedor: String; DtBase: TDateTime): IMetaVendedorController;

  end;

implementation

{ TMetaVendedorController }

constructor TMetaVendedorController.Create;
begin
  FMetaVendedorModel := TMetaVendedorModel.New;
end;

destructor TMetaVendedorController.Destroy;
begin
  inherited;
end;

function TMetaVendedorController.IsFound: boolean;
begin
  Result := FIsFound;
end;

function TMetaVendedorController.Model: IMetaVendedorModel;
begin
  result := FMetaVendedorModel;
end;

class function TMetaVendedorController.New: IMetaVendedorController;
begin
  Result := self.Create;
end;

function TMetaVendedorController.ObterMetaVendedor(CodVendedor: String;
  DtBase: TDateTime): IMetaVendedorController;
begin
  FIsFound := FMetaVendedorModel.ObterMetaVendedor(CodVendedor, DtBase).IsFound;
  Result := self;
end;

function TMetaVendedorController.RegistrarDataSetDtSrc(DtSrc: TDataSource) : IMetaVendedorController;
begin
  result := self;
  FMetaVendedorModel.RegistrarDataSetDtSrc(DtSrc);
end;

function TMetaVendedorController.RegistrarDbWareEdit(DbWare: TDBEdit; NomeCampo : String) : IMetaVendedorController;
begin
  result := self;
  FMetaVendedorModel.RegistrarDbWareEdit(DbWare, NomeCampo);
end;

Function TMetaVendedorController.RegistrarDbWareLabel(DbWare: TDBText; NomeCampo : String) : IMetaVendedorController;
begin
  result := self;
  FMetaVendedorModel.RegistrarDbWareLabel(DbWare, NomeCampo);
end;

end.
