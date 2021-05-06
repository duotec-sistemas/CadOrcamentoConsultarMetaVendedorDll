unit Rtty.Utilitario.Duotec;

interface

uses
  System.RTTI, System.SysUtils, DebugHelper, AtributosCustomizados.Utilitario.Duotec;

Type
  TLibRtty = class
    class function GerarSelect(pObjeto: TObject): String;
    class function GerarDelete(pObjeto: TObject): String;
    class function GerarInsert(pObjeto: TObject): String;
    class function GerarUpdate(pObjeto: TObject): String;
  end;

implementation

{ TLibRtty }

class function TLibRtty.GerarDelete(pObjeto: TObject): String;
Var
  ContextoRtti: TRttiContext; // Contexto
  TipoObjetoRtti: TRttiType; // Tipo do Objeto
  propriedadesCustomizadasRtti: TCustomAttribute; // Atributos customizados
begin
  result := 'DELETE FROM ';
  ContextoRtti := TRttiContext.Create; // Obtendo o contexto
  Try
    TipoObjetoRtti := ContextoRtti.GetType(pObjeto.ClassType); // Obtendo o tipo do objeto

    for propriedadesCustomizadasRtti in TipoObjetoRtti.GetAttributes do // Percorrendo os atributos da classe
    begin
      result := result + Tabela(propriedadesCustomizadasRtti).Name + ' WHERE ID = :ID';
    end;
  Finally
    ContextoRtti.Free;
  End;
end;

class function TLibRtty.GerarInsert(pObjeto: TObject): String;
Var
  ContextoRtti: TRttiContext; // Contexto
  TipoObjetoRtti: TRttiType; // Tipo do Objeto
  propriedadesRtti: TRttiProperty; // Propriedades do Objeto
  propriedadesCustomizadasRtti: TCustomAttribute; // Atributos customizados
  sValues: String;
begin
  result := 'INSERT INTO ';
  ContextoRtti := TRttiContext.Create; // Obtendo o contexto
  Try
    TipoObjetoRtti := ContextoRtti.GetType(pObjeto.ClassType); // Obtendo o tipo do objeto

    for propriedadesCustomizadasRtti in TipoObjetoRtti.GetAttributes do // Pegar o nome da tabela
    begin
      result := result + Tabela(propriedadesCustomizadasRtti).Name;
    end;

    result := result + ' (';
    for propriedadesRtti in TipoObjetoRtti.GetProperties do // Percorrendo as propriedades
    begin
      for propriedadesCustomizadasRtti in propriedadesRtti.GetAttributes do // Percorrendo os atributos customizados
      begin
        if Campo(propriedadesCustomizadasRtti).Name <> '' then
        begin
          result := result + Campo(propriedadesCustomizadasRtti).Name + ', ';
          sValues := ':' + Campo(propriedadesCustomizadasRtti).Name + ', ';
        end;
      end;
    end;

    sValues := Copy(sValues, 1, length(sValues) - 2);

    result := Copy(result, 1, length(result) - 2) + ') VALUES (' + sValues + ')';

  Finally
    ContextoRtti.Free;
  End;

end;

class function TLibRtty.GerarSelect(pObjeto: TObject): String;
Var
  ContextoRtti: TRttiContext; // Contexto
  TipoObjetoRtti: TRttiType; // Tipo do Objeto
  propriedadesRtti: TRttiProperty; // Propriedades do Objeto
  propriedadesCustomizadasRtti: TCustomAttribute; // Atributos customizados
begin
  result := 'SELECT ';
  ContextoRtti := TRttiContext.Create; // Obtendo o contexto
  Try
    TipoObjetoRtti := ContextoRtti.GetType(pObjeto.ClassType); // Obtendo o tipo do objeto
    for propriedadesRtti in TipoObjetoRtti.GetProperties do // Percorrendo as propriedades
    begin
      for propriedadesCustomizadasRtti in propriedadesRtti.GetAttributes do // Percorrendo os atributos customizados
      begin
        If Campo(propriedadesCustomizadasRtti).Name <> '' then
          result := result + Campo(propriedadesCustomizadasRtti).Name + ', ';
      end;
    end;
    result := Copy(result, 1, length(result) - 2) + ' FROM ';

    for propriedadesCustomizadasRtti in TipoObjetoRtti.GetAttributes do
    begin
      result := result + Tabela(propriedadesCustomizadasRtti).Name;
    end;

  Finally
    ContextoRtti.Free;
  End;
end;

class function TLibRtty.GerarUpdate(pObjeto: TObject): String;
begin

end;

end.
