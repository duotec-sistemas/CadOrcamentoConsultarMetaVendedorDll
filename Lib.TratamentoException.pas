unit Lib.TratamentoException;

interface

uses
  System.Classes, System.SysUtils, VCL.Dialogs, Vcl.Forms;

Type
  ITratamentoException = interface
    ['{0334A062-C35C-46D4-9DFB-ADE2C3A3F89E}']
    procedure ProcedimentoException(Sender: TObject; e: Exception);
    Function NomeMetodo(Value: String): ITratamentoException;
    Function AdicionarRastreio(Value: String): ITratamentoException;
    Function RemoverRastreio(Value: String): ITratamentoException;
  end;

  TTratamentoException = Class(TInterfacedObject, ITratamentoException)
  private
    fLogFile: TStringList;
    fNomeMetodo: String;
    FRastreio: TStringList;
  public
    Constructor Create;
    Destructor Destroy; override;
    Class Function New: ITratamentoException;

    procedure ProcedimentoException(Sender: TObject; e: Exception);
    Function NomeMetodo(Value: String): ITratamentoException;
    Function AdicionarRastreio(Value: String): ITratamentoException;
    Function RemoverRastreio(Value: String): ITratamentoException;

  End;

Var
  TratamentoException: ITratamentoException;

implementation

uses
 Lib.Utilitarios;

{ TTratamentoException }
function TTratamentoException.AdicionarRastreio(Value: String): ITratamentoException;
begin
  FRastreio.Add(Value);
end;

constructor TTratamentoException.Create;
begin
  fLogFile := TStringList.Create;
  FRastreio := TStringList.Create;
  Application.OnException := Self.procedimentoException;
end;

destructor TTratamentoException.Destroy;
begin
  if assigned(fLogFile) then
  begin
    fLogFile.DisposeOf;
    fLogFile := nil;
  end;

  if assigned(FRastreio) then
  begin
    FRastreio.DisposeOf;
    FRastreio := nil;
  end;

  inherited;
end;

class function TTratamentoException.New: ITratamentoException;
begin
  result := Self.Create;
end;

function TTratamentoException.NomeMetodo(Value: String): ITratamentoException;
begin
  fNomeMetodo := Value;
  result := Self;
end;

procedure TTratamentoException.procedimentoException(Sender: TObject; e: Exception);
Var
  s: String;
  i: Integer;
begin
{ TODO : Verificar como gravar o log de erro e enviar para remoto }
  s := '';
  for i := 0 to FRastreio.Count - 1 do
  begin
    s := s + FRastreio.Strings[i] + sLineBreak;
  end;
  fRastreio.Clear;

  fLogFile.Add(
    'Sender.Name -> ' + TComponent(Sender).Name + sLineBreak +
    'ClassName -> ' + e.ClassName + sLineBreak +
    'Message-> ' + e.Message + sLineBreak +
    'UnitName-> ' + e.UnitName + sLineBreak +
    'StackTrace -> ' + s + sLineBreak +
    e.StackTrace + sLineBreak + '------------------------');
  fLogFile.SaveToFile('c:\temp\log.txt');
//  ShowMessage('Mensagem: '+e.Message);
//  TLib.GravarImagemFormulario(TForm(Sender).Name, TForm(Sender));

end;

function TTratamentoException.RemoverRastreio(Value: String): ITratamentoException;
Var
  i: Integer;
begin
  IF FRastreio.Find(Value, i) then
  begin
    FRastreio.Delete(i);
  end;
end;

end.
