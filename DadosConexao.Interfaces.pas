unit DadosConexao.Interfaces;

interface

Type
  iDadosConexao = interface
    ['{B981D30C-F8B9-4011-8F07-87F8D0F78699}']
    function getBancoDados : String;
    function getServidor : String;
    function getUsuario : String;
    function getSenha : String;

    function setBancoDados(value : String) : iDadosConexao;
    function setServidor(value : String) : iDadosConexao;
    function setUsuario(value : String) : iDadosConexao;
    function setSenha(value : String) : iDadosConexao;

    function obterDadosConexao(pastaConfiguracao, NomeArquivoConfiguracao : String) : iDadosConexao;

  end;

implementation

end.
