program CadOrcamentoConsultarMetaVendedor;

{$R *.dres}

uses
  Vcl.Forms,
  Orcamento.View.ConsultarMetaVendedor in '..\View\Orcamento.View.ConsultarMetaVendedor.pas' {OrcamentoViewConsultaMetaVendedor},
  View.Pai in '..\Heranca\View.Pai.pas' {ViewPai},
  View.Formulario in '..\Heranca\View.Formulario.pas' {ViewFormulario},
  Conexao.Interfaces in '..\..\..\FrameWorkDuoSig\Conexao\Conexao.Interfaces.pas',
  Conexao.Model in '..\..\..\FrameWorkDuoSig\Conexao\Conexao.Model.pas',
  DadosConexao.Interfaces in '..\..\..\FrameWorkDuoSig\Conexao\DadosConexao.Interfaces.pas',
  DadosConexao.Model in '..\..\..\FrameWorkDuoSig\Conexao\DadosConexao.Model.pas',
  Query.Interfaces in '..\..\..\FrameWorkDuoSig\Conexao\Query.Interfaces.pas',
  Query.Model in '..\..\..\FrameWorkDuoSig\Conexao\Query.Model.pas',
  DebugHelper in '..\..\..\FrameWorkDuoSig\utilitarios\DebugHelper.pas',
  Hashes in '..\..\..\FrameWorkDuoSig\utilitarios\Hashes.pas',
  Lib.CodigoErros in '..\..\..\FrameWorkDuoSig\utilitarios\Lib.CodigoErros.pas',
  Lib.TratamentoException in '..\..\..\FrameWorkDuoSig\utilitarios\Lib.TratamentoException.pas',
  Lib.Utilitarios in '..\..\..\FrameWorkDuoSig\utilitarios\Lib.Utilitarios.pas',
  uConstantesStatusCode in '..\..\..\FrameWorkDuoSig\utilitarios\uConstantesStatusCode.pas',
  uReturn_Tobject_Str in '..\..\..\FrameWorkDuoSig\utilitarios\uReturn_Tobject_Str.pas',
  MetaVendedor.Model in '..\Model\MetaVendedor.Model.pas',
  MetaVendedor.Controller in '..\Controller\MetaVendedor.Controller.pas',
  Constantes.ErpNfePlus in '..\Utilitario\Constantes.ErpNfePlus.pas',
  MetaVendedor.Dao in '..\Dao\MetaVendedor.Dao.pas' {$R *.res};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TOrcamentoViewConsultaMetaVendedor, OrcamentoViewConsultaMetaVendedor);
  Application.Run;
end.
