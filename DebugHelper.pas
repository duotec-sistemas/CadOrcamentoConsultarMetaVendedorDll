{
TDebugHelper é uma ClassHelper para gerar informacoes  nos events do depurador do delphi.
Somente vai executar se estiver em modo de depuracao.
}

unit DebugHelper;

interface


uses Windows;

type
  TDebuggerHelper = class
  public
    { public declarations }
    class procedure LogDebug(s: String);
  end;

function IsDebuggerPresent: LongBool; external kernel32 name 'IsDebuggerPresent';




implementation


{ TDebuggerHelper }

class procedure TDebuggerHelper.LogDebug(s: String);
begin
  if IsDebuggerPresent then
    OutputDebugString(PWideChar(s));

end;

end.
