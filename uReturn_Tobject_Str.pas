unit uReturn_Tobject_Str;

interface

uses
  SysUtils, Rtti;

Type
  EInstancia_Not_Null = class(Exception);

Type
  TReturn_TObject = class
    class function Instanciar(const Str_Class: TValue): TObject;
  end;

implementation

uses
  typInfo;

{ TReturn_TObject }

class function TReturn_TObject.Instanciar(const Str_Class: TValue): TObject;
var
  C: TRttiContext;
  instancia: TRttiInstanceType;
  p: TRttiType;
  Erro: String;
begin
  try
    case Str_Class.Kind of
      tkString, tkLString, tkWString, tkUString:
        begin
          Erro := Str_Class.AsString + 'Classe Não encontrada' + sLineBreak +
            '<Lembrete : verifique ortografia&nbsp; / Case Sensitive>' + sLineBreak;
          instancia := (C.FindType(Str_Class.AsString) as TRttiInstanceType);
          result := (instancia.MetaclassType.Create);
        end;
      tkClassRef:
        begin
          Erro := 'O parâmetro passado deve ser do tipo Tclass' + sLineBreak;
          p := C.GetType(Str_Class.AsClass);
          instancia := (C.FindType(p.QualifiedName) as TRttiInstanceType);
          result := instancia.MetaclassType.Create;

        end;
    else
      begin
        Erro := 'O parâmetro passado não é válidado para a função' + sLineBreak;
        abort;
      end;
    end;
  except
    on e: Exception do
    begin
      raise EInstancia_Not_Null.Create(Erro +
        'Mensagem Original' + sLineBreak + e.Message);
    end;
  end;
end;

end.
