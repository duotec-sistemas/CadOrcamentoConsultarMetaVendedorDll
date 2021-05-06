unit Lib.CodigoErros;

interface

  Type TCodigoErros = Class
    Class Function _ERRO_0001 : String;
  End;


implementation


{ TCodigoErros }

class function TCodigoErros._ERRO_0001: String;
begin
  result := 'Nome interno do programa executável não esta igual ao nome do executável. Erro[0001]';
end;

end.
