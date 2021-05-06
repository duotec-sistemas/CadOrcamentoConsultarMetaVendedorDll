unit DadosConexao.Model;

interface

uses DadosConexao.interfaces, iniFiles, System.SysUtils, Lib.Utilitarios;

Type
  TDadosConexao = Class(TInterfacedObject, iDadosConexao)
  private
    fBancoDados, fServidor, fUsuario, fSenha: String;
  public
    Constructor Create;
    Destructor Destroy; override;
    Class Function New: iDadosConexao;

    function getBancoDados: String;
    function getServidor: String;
    function getUsuario: String;
    function getSenha: String;

    function setBancoDados(value: String): iDadosConexao;
    function setServidor(value: String): iDadosConexao;
    function setUsuario(value: String): iDadosConexao;
    function setSenha(value: String): iDadosConexao;

    function obterDadosConexao(pastaConfiguracao, NomeArquivoConfiguracao: String): iDadosConexao;

  End;

implementation

{ TDadosConexao }

constructor TDadosConexao.Create;
begin

end;

destructor TDadosConexao.Destroy;
begin

  inherited;
end;

function TDadosConexao.getBancoDados: String;
begin
  result := fBancoDados;
end;

function TDadosConexao.getSenha: String;
begin
  result := fSenha;
end;

function TDadosConexao.getServidor: String;
begin
  result := fServidor;
end;

function TDadosConexao.getUsuario: String;
begin
  result := fUsuario;
end;

class function TDadosConexao.New: iDadosConexao;
begin
  result := self.Create;
end;

function TDadosConexao.obterDadosConexao(pastaConfiguracao, NomeArquivoConfiguracao: String): iDadosConexao;
Var
  ArqConfiguracao: TInifile;
begin
  result := self;
  if pastaConfiguracao = '' then
    pastaConfiguracao := ExtractFilePath(ParamStr(0));

  if NomeArquivoConfiguracao = '' then
    NomeArquivoConfiguracao := 'DUOSIG.INI';

  ArqConfiguracao := TInifile.Create(pastaConfiguracao + NomeArquivoConfiguracao);
  Try
    fUsuario := ArqConfiguracao.ReadString('DATABASE', 'Usuario_Banco', 'SYSDBA');
    fSenha := ArqConfiguracao.ReadString('DATABASE', 'Senha', 'masterkey');
    fServidor := TLib.Extract(1, ':', ArqConfiguracao.ReadString('DATABASE', 'Banco_Dados', ''));
    fBancoDados := ArqConfiguracao.ReadString('DATABASE', 'Banco_Dados', '');
    fBancoDados := Copy(fBancoDados, Length(fServidor) + 2, 999);

    if fBancoDados = '' then
      fBancoDados := ArqConfiguracao.ReadString('DATABASE', 'Banco_Dados', '');

    if fBancoDados = '' then
      raise Exception.Create('Não foi possível encontrar o nome do banco de dados no arquivo de configuração');

    if fServidor = '' then
      raise Exception.Create('Não foi possível encontrar o endereço do banco de dados no arquivo de configuração');
  Finally
    ArqConfiguracao.Free;
  End;
end;

function TDadosConexao.setBancoDados(value: String): iDadosConexao;
begin
  fBancoDados := value;
  result := self;
end;

function TDadosConexao.setSenha(value: String): iDadosConexao;
begin
  fSenha := value;
  result := self;
end;

function TDadosConexao.setServidor(value: String): iDadosConexao;
begin
  fServidor := value;
  result := self;
end;

function TDadosConexao.setUsuario(value: String): iDadosConexao;
begin
  fUsuario := value;
  result := self;
end;

end.
