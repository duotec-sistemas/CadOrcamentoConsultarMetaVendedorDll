unit Lib.Utilitarios;

interface

uses Winapi.Windows, Winapi.Messages, vcl.Dialogs, System.Classes, ACbrUtil,
  System.SysUtils, ComObj, Activex, Generics.Collections, Variants, TypInfo,
  vcl.Imaging.pngimage, vcl.ExtCtrls, vcl.Imaging.jpeg, IdCoderMIME, System.NetEncoding,
  vcl.ComCtrls, FireDAC.Comp.Client, vcl.Controls, vcl.Forms, vcl.Graphics,
  Hashes, System.Generics.Collections, System.Contnrs,
  Soap.EncdDecd, Tlhelp32, WinSock;

Type

  TGenerico = 0 .. 255;
  //
  // Como usar a TConvert
  // Type TAcao= (ftFirist, ftNext, ftPrior, FtLast, ftIgnore ) ;
  // Type Type TRemuneracao = (ftHorario, ftDiario, FtSemanal , ftquinzenal , Ftmensal);
  // Type Type TVencimentos = (ftMedia30, FtMedia45 , ftMedia60);
  // Type Type TDinheiro = (ftReal , ftDollar , FtEuros, ftLibra , ftYen , ftPeso );
  // Type Type TSorte = (ftPar , FtImpar);
  // Type type TPort = (COM1, COM2, COM3, COM4, COM5, COM6, COM7, COM8, COM9);
  //
  // procedure TForm1.btnPopularClick(Sender: TObject);
  // begin
  // TConvert<TAcao>.PopulateListEnum(CbAcao.Items);
  // TConvert<TRemuneracao>.PopulateListEnum(cbRemuneracao.Items);
  // TConvert<TVencimentos>.PopulateListEnum(cbVencimentos.Items);
  // TConvert<TDinheiro>.PopulateListEnum(cbDinheiro.Items);
  // TConvert<TSorte>.PopulateListEnum(cbSorte.Items);
  // TConvert<TPort>.PopulateListEnum(cbPort.Items);
  // end;

  TConvert<T: record > = class
  private
  public
    class procedure PopulateListEnum(AList: TStrings);
    class function StrConvertEnum(const AStr: string): T;
    class function EnumConvertStr(const eEnum: T): string;
  end;

  TLib = Class
    class function obterNomeMesAno(Dt: TDateTime): String;
    class function obterNomeMes(Mes: Integer): String;
    class function GetIP: string;
    class function ObterSerialVolume(FDrive : String): String;

    Class procedure Centralizar(Var Parent, Child: TWinControl);
    Class Function Arredondar(Value: Extended; QtdCasasDecimais: Integer): Extended;
    Class Function Base64FromBitmap(Bitmap: TBitmap): string;
    Class Function BitmapFromBase64(const base64: string): TBitmap;
    Class Function KillTask(ExeFileName: string): Integer;
    Class procedure MostrarMensagem(Mensagem: String);
    Class Function String2Hex(const Buffer: AnsiString): string;
    Class Function ExisteTask(ExeFileName: string): Boolean;
    // Extrair um valor de uma variavel
    // Index : Posicao(1,2,3,etc),
    // Delimitador: Caracter que separa as strings. Ex: ;,|,!
    // Str : String a ser extraido as informacoes
    Class Function Extract(Index: Integer; Delimitador: Char; str: String): String;

    Class Procedure ConstruirTreeView(Var TreeView: TTreeView; ListaOpcoes: TStringList);
    Class function ObterCodigoPrograma(Index: Integer; ListaOpcoes: TStringList): String;
    Class Function ObterRecnum(Conexao: TFDCustomConnection): Integer;
    Class Function ObterPK(Conexao: TFDCustomConnection): Currency;
    Class Function ObterGuid: String;
    Class Function StrZero(xValue: Extended; xWidth: Integer; xDecimals: Integer): string;
    Class function Replicate(pString: string; xWidth: Integer): string;
    Class function Right(pString: string; xWidth: Integer): string;
    Class Function ObterPastaExecutavel(nomeExecutavel: String): String;
    Class procedure MovimentaObject(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer; Formulario: TForm);
    Class function Max(X, Y: Integer): Integer;
    Class function Min(X, Y: Integer): Integer;
    Class function EscureceCor(BaseColor: TColor; Adjust: Integer): TColor;
    Class function ClareiaCor(BaseColor: TColor; Adjust: Integer): TColor;
    class procedure GetBuildInfo(nomeExecutavel: String; var V1, V2, V3, V4: Word);
    class function ObterVersao(nomeExecutavel: String): String;
    Class Function FormatarCNPJCPF(Value: String): String;
    class Function UltimoCaracter(Value: String): String;
    class function ObterNomeUsuarioWindows: String;
    Class Function ObterVersaoWindows: string;
    class Procedure GravarImagemFormulario(const NomeArquivo: string; Formulario: TForm);
    class Function RetirarCaracteresEspecias(Value: String): String;
    class function StringToHex(S: String): string;
    class function HexToString(H: String): String;
    class procedure MakeRounded(Control: TWinControl);
    class Function ObterCorBackGround: TColor;
    Class Function ObterCorFont: TColor;
    Class Function ObterCorMenu: TColor;
    Class Function ObterCorSubMenu: TColor;
    Class Function ObterCorFundoSubMenu: TColor;
    Class Function ObterCorPnlParent: TColor;
    Class function encodeImagemPng(Imagem: TImage): String;
    Class procedure decodeImagemPng(Value: String; Var Imagem: TImage);
    class function CountChar(Origem, Caracter: String): Integer;
    class function GravarLogTexto(NomePasta, NomeArquivo, Texto: String): Boolean;
  End;

Const
  _PosicaoAbsoluteIndex = 1;
  _PosicaoCodigoPrograma = 5;

implementation

{ TLib }

class function TLib.Arredondar(Value: Extended; QtdCasasDecimais: Integer): Extended;
begin
  result := Value;
end;

class function TLib.Base64FromBitmap(Bitmap: TBitmap): string;
var
  Input: TBytesStream;
  Output: TStringStream;
begin
  Input := TBytesStream.Create;
  try
    Bitmap.SaveToStream(Input);
    Input.Position := 0;
    Output := TStringStream.Create('', TEncoding.ASCII);
    try
      Soap.EncdDecd.EncodeStream(Input, Output);
      result := Output.DataString;
    finally
      Output.Free;
    end;
  finally
    Input.Free;
  end;

end;

class function TLib.BitmapFromBase64(const base64: string): TBitmap;
var
  Input: TStringStream;
  Output: TBytesStream;
begin
  Input := TStringStream.Create(base64, TEncoding.ASCII);
  try
    Output := TBytesStream.Create;
    try
      Soap.EncdDecd.DecodeStream(Input, Output);
      Output.Position := 0;
      result := TBitmap.Create;
      try
        result.LoadFromStream(Output);
      except
        result.Free;
        raise;
      end;
    finally
      Output.Free;
    end;
  finally
    Input.Free;
  end;

end;

class procedure TLib.Centralizar(var Parent, Child: TWinControl);
begin
  Child.Left := Trunc((Parent.Width / 2) - (Child.Width / 2));
end;

class function TLib.ClareiaCor(BaseColor: TColor; Adjust: Integer): TColor;
begin
  result := RGB(Min(GetRValue(ColorToRGB(BaseColor)) + Adjust, 255), Min(GetGValue(ColorToRGB(BaseColor)) + Adjust, 255), Min(GetBValue(ColorToRGB(BaseColor)) + Adjust, 255));
end;

class procedure TLib.ConstruirTreeView(var TreeView: TTreeView; ListaOpcoes: TStringList);
Var
  NodePai, NodeFilho, NodeOpcao: TTreeNode;
  i, j: Integer;
  Pai, Filho, Titulo, Programa, Linha: String;
begin
  Try
    // |Pai|Filho|Titulo|Tag
    //
    for i := 0 to ListaOpcoes.Count - 1 do
    begin
      Linha := ListaOpcoes.Strings[i];
      Titulo := Extract(1, '|', Linha);
      if Pai <> Titulo then
        NodePai := TreeView.Items.AddChild(nil, Titulo);
      Pai := Titulo;

      Titulo := Extract(2, '|', Linha);
      if Filho <> Titulo then
        NodeFilho := TreeView.Items.AddChild(NodePai, Titulo);
      Filho := Titulo;

      Titulo := Extract(3, '|', Linha);
      NodeOpcao := TreeView.Items.AddChild(NodeFilho, Titulo);

      Linha := '|' + IntToStr(NodeOpcao.AbsoluteIndex) + Linha;
      ListaOpcoes.Strings[i] := Linha;
    end;
  Finally

  End;

  TreeView.AutoExpand := true;
  TreeView.FullExpand;

end;

class function TLib.CountChar(Origem, Caracter: String): Integer;
var
  X, j, i: Integer;
begin
  result := 0;
  j := Caracter.Length;
  X := Origem.Length;
  for i := 1 to X do
  begin
    if Copy(Origem, i, j) = Caracter then
      inc(result);
  end;

end;

class procedure TLib.decodeImagemPng(Value: String; var Imagem: TImage);
var
  stream: TMemoryStream;
  bb: TArray<Byte>;
  arq: TStringList;
  png: TPngImage;
begin
  stream := TMemoryStream.Create;
  bb := decodebase64(Value);
  if Length(bb) > 0 then
  begin
    stream.WriteData(bb, Length(bb));
    stream.Position := 0;
    png := TPngImage.Create;
    png.LoadFromStream(stream);
    Imagem.Picture.Assign(png);
  end;
  stream.Free;
  png.Free;
end;

class function TLib.encodeImagemPng(Imagem: TImage): String;
var
  LInput: TMemoryStream;
  LOutput: TStringStream;
begin
  Try
    LInput := TMemoryStream.Create;
    LOutput := TStringStream.Create;
    Imagem.Picture.SaveToStream(LInput);
    LInput.Position := 0;
    TNetEncoding.base64.Encode(LInput, LOutput);
    result := LOutput.DataString;
  finally
    LInput.Free;
    LOutput.Free;
  end;
end;

class function TLib.EscureceCor(BaseColor: TColor; Adjust: Integer): TColor;
begin
  result := RGB(Max(GetRValue(ColorToRGB(BaseColor)) - Adjust, 0), Max(GetGValue(ColorToRGB(BaseColor)) - Adjust, 0), Max(GetBValue(ColorToRGB(BaseColor)) - Adjust, 0));
end;

class function TLib.ExisteTask(ExeFileName: string): Boolean;
const
  PROCESS_TERMINATE = $0001;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  result := false;
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := Sizeof(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
  while Integer(ContinueLoop) <> 0 do
  begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =
      UpperCase(ExeFileName))
      or (UpperCase(FProcessEntry32.szExeFile) = UpperCase
      (ExeFileName))) then
      result := true;
    ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);;
end;

class function TLib.Extract(Index: Integer; Delimitador: Char; str: String): String;
Var
  st: TStringList;
begin
  result := '';
  index := index - 1;
  st := TStringList.Create;
  Try

    st.delimiter := Delimitador;
    st.QuoteChar := ' ';
    st.StrictDelimiter := true;
    st.DelimitedText := str;
    if index < st.Count then
      result := st.Strings[index];
  Finally
    st.Free;
  End;

end;

class function TLib.FormatarCNPJCPF(Value: String): String;
begin
  result := ACbrUtil.OnlyNumber(Value);
  if Length(result) = 11 then
    result := Copy(result, 1, 3) + '.' + Copy(result, 4, 3) + '.' + Copy(result, 7, 3) + '-' + Copy(result, 10, 2)
  else if Length(result) >= 14 then
    result := Copy(result, 1, 2) + '.' + Copy(result, 3, 3) + '.' + Copy(result, 6, 3) + '/' + Copy(result, 9, 4) + '-' + Copy(result, 13, 2);
end;

class procedure TLib.GetBuildInfo(nomeExecutavel: String; var V1, V2, V3, V4: Word);
var
  VerInfoSize, VerValueSize, Dummy: DWORD;
  VerInfo: Pointer;
  VerValue: PVSFixedFileInfo;
begin
  VerInfoSize := GetFileVersionInfoSize(PChar(nomeExecutavel), Dummy);
  GetMem(VerInfo, VerInfoSize);
  GetFileVersionInfo(PChar(nomeExecutavel), 0, VerInfoSize, VerInfo);
  VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);
  With VerValue^ do
  begin
    V1 := dwFileVersionMS shr 16;
    V2 := dwFileVersionMS and $FFFF;
    V3 := dwFileVersionLS shr 16;
    V4 := dwFileVersionLS and $FFFF;
  end;
  FreeMem(VerInfo, VerInfoSize);
end;

class function TLib.GetIP: string;
var
  wsaData: TWSAData;
begin
  WSAStartup(257, wsaData);
  result := Trim(iNet_ntoa(PInAddr(GetHostByName(nil)^.h_addr_list^)^));
end;

class procedure TLib.GravarImagemFormulario(const NomeArquivo: string; Formulario: TForm);
var
  Bitmap: TBitmap;
  jpeg: TJpegImage;
begin
  jpeg := TJpegImage.Create;
  try
    Bitmap := Formulario.GetFormImage;
    jpeg.Assign(Bitmap);
    jpeg.SaveToFile(Format('%s\%s.jpg', [GetCurrentDir, NomeArquivo]));
  finally
    jpeg.Free;
    Bitmap.Free;
  end;
end;

class function TLib.GravarLogTexto(NomePasta, NomeArquivo, Texto: String): Boolean;
Var
  st: TStringList;
begin
  result := true;

  if NomePasta[Length(NomePasta)] = '\' then
    NomePasta := Copy(NomePasta, 1, Length(NomePasta) - 1);

  st := TStringList.Create;
  Try

    if Not DirectoryExists(NomePasta) then
      ForceDirectories(NomePasta);

    st.Text := Texto;

    st.SaveToFile(NomePasta + '\' + NomeArquivo);
  Finally
    st.Free;

  End;
end;

class function TLib.HexToString(H: String): String;
var
  i: Integer;
begin
  result := '';
  for i := 1 to Length(H) div 2 do
    result := result + Char(StrToInt('$' + Copy(H, (i - 1) * 2 + 1, 2)));
end;

class function TLib.KillTask(ExeFileName: string): Integer;
const
  PROCESS_TERMINATE = $0001;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  result := 0;
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := Sizeof(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
  while Integer(ContinueLoop) <> 0 do
  begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =
      UpperCase(ExeFileName))
      or (UpperCase(FProcessEntry32.szExeFile) = UpperCase
      (ExeFileName))) then
      result := Integer(TerminateProcess(OpenProcess
        (PROCESS_TERMINATE, BOOL(0), FProcessEntry32.th32ProcessID), 0));
    ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);;
end;

class function TLib.Max(X, Y: Integer): Integer;
begin
  if X > Y then
    result := X
  else
    result := Y;
end;

class function TLib.Min(X, Y: Integer): Integer;
begin
  if X < Y then
    result := X
  else
    result := Y;
end;

class procedure TLib.MostrarMensagem(Mensagem: String);
begin
  showMessage(Mensagem);
end;

class procedure TLib.MovimentaObject(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer; Formulario: TForm);
var
  ObjectPos, MousePosMov: TPoint;
  Pt: TPoint;
  fHandle: HWND;
begin
  GetCursorPos(Pt);
  ObjectPos.X := Formulario.Left;
  ObjectPos.Y := Formulario.Top;
  if (Sender is TForm) then
    fHandle := TWinControl(Sender).Handle
  else
    fHandle := TWinControl(Sender).Parent.Handle;
  while DragDetect(fHandle, ObjectPos) do
  begin
    GetCursorPos(MousePosMov);
    Formulario.Left := MousePosMov.X - X - 3;
    Formulario.Top := MousePosMov.Y - Y - 3;
    Application.ProcessMessages;
  end;
end;

class function TLib.ObterCodigoPrograma(Index: Integer; ListaOpcoes: TStringList): String;
Var
  i: Integer;
begin
  //
  for i := 0 to ListaOpcoes.Count - 1 do
  begin
    if TLib.Extract(_PosicaoAbsoluteIndex, '|', ListaOpcoes.Strings[i]) = IntToStr(Index) then
      result := TLib.Extract(_PosicaoCodigoPrograma, '|', ListaOpcoes.Strings[i]);
  end;
end;

class function TLib.ObterCorBackGround: TColor;
begin
  result := $00F5F2F0;
end;

class function TLib.ObterCorFont: TColor;
begin
  result := $00F5F2F0;
end;

class function TLib.ObterCorFundoSubMenu: TColor;
begin
  result := $00E5F2E4;
end;

class function TLib.ObterCorMenu: TColor;
begin
  result := $00465745;
end;

class function TLib.ObterCorPnlParent: TColor;
begin
  result := $00E5F2E4;

end;

class function TLib.ObterCorSubMenu: TColor;
begin
  result := $0054A352
end;

class function TLib.ObterGuid: String;
var
  G: TGuid;
begin
  CoCreateGuid(G);
  result := IntToHex(G.D1, 1) + '' + IntToHex(G.D2, 1) + '' + IntToHex(G.D3, 1) + '';
  result := result + IntToHex(G.D4[0], 1) + IntToHex(G.D4[1], 1) + IntToHex(G.D4[3], 1) + IntToHex(G.D4[4], 1) + IntToHex(G.D4[5], 1) + IntToHex(G.D4[6], 1) + IntToHex(G.D4[7], 1);
end;

class function TLib.obterNomeMes(Mes: Integer): String;
begin
  case Mes of
    1:
      result := 'Janeiro';
    2:
      result := 'Fevereiro';
    3:
      result := 'Março';
    4:
      result := 'Abril';
    5:
      result := 'Maio';
    6:
      result := 'Junho';
    7:
      result := 'Julho';
    8:
      result := 'Agosto';
    9:
      result := 'Setembro';
    10:
      result := 'Outubro';
    11:
      result := 'Novembro';
    12:
      result := 'Dezembro';
  end;
end;

class function TLib.obterNomeMesAno(Dt: TDateTime): String;
Var
  d, m, a, hh, mm, ss, ms: Word;
begin
  DecodeDate(Dt, a, m, d);
  result := obterNomeMes(m) + '/' + a.ToString;
end;

class function TLib.ObterNomeUsuarioWindows: String;
var
  Size: DWORD;
begin
  // retorna o login do usuário do sistema operacional
  Size := 1024;
  SetLength(result, Size);
  GetUserName(PChar(result), Size);
  SetLength(result, Size - 1);
end;

class function TLib.ObterPastaExecutavel(nomeExecutavel: String): String;
begin
  result := ExtractFilePath(nomeExecutavel);
end;

class function TLib.ObterPK(Conexao: TFDCustomConnection): Currency;

Var
  Qry: TFDQuery;
  S: String;
begin
  result := 0;
  Qry := TFDQuery.Create(Nil);
  Try
    Qry.Connection := TFDConnection(Conexao);
    S := ' SELECT * FROM SP_PRIMARYKEY';
    Qry.Open(S);
    result := Qry.FieldByName('PRIKEY').AsCurrency;
  Finally
    Qry.Free;
  End;
end;

class function TLib.ObterRecnum(Conexao: TFDCustomConnection): Integer;
Var
  Qry: TFDQuery;
  S: String;
begin
  result := 0;
  Qry := TFDQuery.Create(Nil);
  Try
    Qry.Connection := TFDConnection(Conexao);
    S := ' SELECT GEN_ID(GEN_GERAL,1) AS RECNUM FROM RDB$DATABASE';
    Qry.Open(S);
    result := Qry.FieldByName('RECNUM').AsInteger;
  Finally
    Qry.Free;
  End;

end;

class function TLib.ObterSerialVolume(FDrive: String): String;
var
  Serial: DWORD;
  DirLen, Flags: DWORD;
  DLabel: Array [0 .. 11] of Char;
begin
  Try
    GetVolumeInformation(PChar(FDrive + ':'), DLabel, 12, @Serial, DirLen, Flags, nil, 0);
    result := IntToHex(Serial, 8);
  Except
    result := '';
  end;
end;

class function TLib.ObterVersao(nomeExecutavel: String): String;
var
  V1, // Major Version
  V2, // Minor Version
  V3, // Release
  V4: Word; // Build Number
begin
  GetBuildInfo(nomeExecutavel, V1, V2, V3, V4);
  result := IntToStr(V1) + '.' + IntToStr(V2) + '.' + IntToStr(V3) + '.' + IntToStr(V4);
end;

class function TLib.ObterVersaoWindows: string;
begin
  case System.SysUtils.Win32MajorVersion of
    5:
      case System.SysUtils.Win32MinorVersion of
        1:
          result := 'Windows XP';
      end;
    6:
      case System.SysUtils.Win32MinorVersion of
        0:
          result := 'Windows Vista';
        1:
          result := 'Windows 7';
        2:
          result := 'Windows 8';
        3:
          result := 'Windows 8.1';
      end;
    10:
      case System.SysUtils.Win32MinorVersion of
        0:
          result := 'Windows 10';
      end;
  end;
end;

class function TLib.RetirarCaracteresEspecias(Value: String): String;
begin
  result := Value;
  result := StringReplace(result, '/', '', [rfReplaceAll]);
  result := StringReplace(result, '.', '', [rfReplaceAll]);
  result := StringReplace(result, '-', '', [rfReplaceAll]);
  result := StringReplace(result, '+', '', [rfReplaceAll]);
  result := StringReplace(result, '\', '', [rfReplaceAll]);
end;

class function TLib.Replicate(pString: string; xWidth: Integer): string;
var
  nCount: Integer;
  pStr: string;
begin
  pStr := '';
  for nCount := 1 to xWidth do
    pStr := pStr + pString;
  result := pStr;
end;

class function TLib.Right(pString: string; xWidth: Integer): string;
begin
  result := Copy(pString, Length(pString) - xWidth + 1, xWidth);
end;

class function TLib.String2Hex(const Buffer: AnsiString): string;
begin
  SetLength(result, Length(Buffer) * 2);
  BinToHex(@Buffer[1], PWideChar(@result[1]), Length(Buffer));
end;

class function TLib.StringToHex(S: String): string;
var
  i: Integer;
begin
  result := '';
  for i := 1 to Length(S) do
    result := result + IntToHex(ord(S[i]), 2);
end;

class function TLib.StrZero(xValue: Extended; xWidth, xDecimals: Integer): string;
var
  sValue: string;
begin
  str(xValue: xWidth: xDecimals, sValue);
  result := Right(Replicate('0', xWidth) + Trim(sValue), xWidth);
end;

class function TLib.UltimoCaracter(Value: String): String;
begin
  result := Value[Length(Value) - 1];
end;

{ TConvert<T> }
class function TConvert<T>.EnumConvertStr(const eEnum: T): string;
var
  P: PInteger;
  Num: Integer;
begin
  try
    P := @eEnum;
    Num := Integer(TGenerico((P^)));
    result := GetEnumName(TypeInfo(T), Num);
  except
    raise EConvertError.Create('O Parâmetro passado não corresponde a ' + sLineBreak + 'um inteiro Ou a um Tipo Enumerado');
  end;
end;

class procedure TConvert<T>.PopulateListEnum(AList: TStrings);
var
  i: Integer;
  StrTexto: String;
  Enum: Integer;
begin
  i := 0;
  try
    repeat
      StrTexto := Trim(GetEnumName(TypeInfo(T), i));
      Enum := GetEnumValue(TypeInfo(T), StrTexto);
      AList.Add(StrTexto);
      inc(i);
    until Enum < 0;
    AList.Delete(pred(AList.Count));
  except
    ;
    raise EConvertError.Create('O Parâmetro passado não corresponde a um Tipo ENUM');
  end;
end;

class function TConvert<T>.StrConvertEnum(const AStr: string): T;
var
  P: ^T;
  Num: Integer;
begin
  try
    Num := GetEnumValue(TypeInfo(T), AStr);
    if Num = -1 then
      abort;
    P := @Num;
    result := P^;
  except
    raise EConvertError.Create('O Parâmetro " ' + AStr + ' " passado não ' + sLineBreak + ' corresponde a um Tipo Enumerado');
  end;
end;

class procedure TLib.MakeRounded(Control: TWinControl);
var
  R: TRect;
  Rgn: HRGN;
begin
  with Control do
  begin
    R := ClientRect;
    Rgn := CreateRoundRectRgn(R.Left, R.Top, R.Right, R.Bottom, 20, 20);
    Perform(EM_GETRECT, 0, lParam(@R));
    InflateRect(R, -5, -5);
    Perform(EM_SETRECTNP, 0, lParam(@R));
    SetWindowRgn(Handle, Rgn, true);
    Invalidate;
  end;
end;

end.
