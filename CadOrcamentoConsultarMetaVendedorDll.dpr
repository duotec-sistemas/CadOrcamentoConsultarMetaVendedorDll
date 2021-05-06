library CadOrcamentoConsultarMetaVendedorDll;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

{$R *.dres}

uses
  System.SysUtils,
  System.Classes,

  MetaVendedor.Dao in '..\Dao\MetaVendedor.Dao.pas',
  View.Pai in '..\Heranca\View.Pai.pas' {ViewPai},
  Constantes.ErpNfePlus in '..\Utilitario\Constantes.ErpNfePlus.pas',
  Orcamento.View.ConsultarMetaVendedor in '..\View\Orcamento.View.ConsultarMetaVendedor.pas' {OrcamentoViewConsultaMetaVendedor},
  DebugHelper in '..\..\..\FrameWorkDuoSig\utilitarios\DebugHelper.pas',
  Hashes in '..\..\..\FrameWorkDuoSig\utilitarios\Hashes.pas',
  Lib.CodigoErros in '..\..\..\FrameWorkDuoSig\utilitarios\Lib.CodigoErros.pas',
  Lib.TratamentoException in '..\..\..\FrameWorkDuoSig\utilitarios\Lib.TratamentoException.pas',
  Lib.Utilitarios in '..\..\..\FrameWorkDuoSig\utilitarios\Lib.Utilitarios.pas',
  uConstantesStatusCode in '..\..\..\FrameWorkDuoSig\utilitarios\uConstantesStatusCode.pas',
  uReturn_Tobject_Str in '..\..\..\FrameWorkDuoSig\utilitarios\uReturn_Tobject_Str.pas',
  Conexao.Interfaces in '..\..\..\FrameWorkDuoSig\Conexao\Conexao.Interfaces.pas',
  Conexao.Model in '..\..\..\FrameWorkDuoSig\Conexao\Conexao.Model.pas',
  DadosConexao.Interfaces in '..\..\..\FrameWorkDuoSig\Conexao\DadosConexao.Interfaces.pas',
  DadosConexao.Model in '..\..\..\FrameWorkDuoSig\Conexao\DadosConexao.Model.pas',
  Query.Interfaces in '..\..\..\FrameWorkDuoSig\Conexao\Query.Interfaces.pas',
  Query.Model in '..\..\..\FrameWorkDuoSig\Conexao\Query.Model.pas',
  MetaVendedor.Controller in '..\Controller\MetaVendedor.Controller.pas',
  MetaVendedor.Model in '..\Model\MetaVendedor.Model.pas',
  Controller.Pai in '..\Heranca\Controller.Pai.pas';

{$R *.res}

Function ConsultarMetaVendedor(CodVendedor : WideString) : WideString;
Var
  ViewMeta : TOrcamentoViewConsultaMetaVendedor;
begin
  ViewMeta :=  TOrcamentoViewConsultaMetaVendedor.Create(nil);
  ViewMeta.CodVendedor := CodVendedor;
  ViewMeta.ShowModal;
  FreeAndNil(ViewMeta);
end;

exports
   ConsultarMetaVendedor;
end.
