unit Lib.CodigoErros;

interface

  Type TCodigoErros = Class
    Class Function _ERRO_0001 : String;
  End;


implementation


{ TCodigoErros }

class function TCodigoErros._ERRO_0001: String;
begin
  result := 'Nome interno do programa execut�vel n�o esta igual ao nome do execut�vel. Erro[0001]';
end;

end.
