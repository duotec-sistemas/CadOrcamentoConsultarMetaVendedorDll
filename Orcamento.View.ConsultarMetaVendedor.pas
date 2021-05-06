unit Orcamento.View.ConsultarMetaVendedor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Gif3,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, View.Pai, Vcl.Buttons, Vcl.StdCtrls,
  Vcl.ExtCtrls, Data.DB, Vcl.Mask, Vcl.DBCtrls, MetaVendedor.Controller,
  Constantes.ErpNfePlus, Lib.Utilitarios, JvExControls, JvAnimatedImage, JvGIFCtrl, ACBrGIF, JvGIF;

type
  TOrcamentoViewConsultaMetaVendedor = class(TViewPai)
    Panel1: TPanel;
    Label1: TLabel;
    Pnl_MesAno: TPanel;
    Panel3: TPanel;
    Lbl_NomeVendedor: TDBText;
    Panel6: TPanel;
    DBText1: TDBText;
    Lbl_DiasUteis: TLabel;
    Btn_Sair: TBitBtn;
    Pnl_Meta: TPanel;
    Pnl_MetaAteHoje: TPanel;
    Pnl_VendaAteHoje: TPanel;
    GridPanel1: TGridPanel;
    Panel4: TPanel;
    Label5: TLabel;
    Panel7: TPanel;
    Edt_VlrMetaAteHoje: TDBEdit;
    Panel5: TPanel;
    Label2: TLabel;
    Panel9: TPanel;
    Edt_VlrMetaMensal: TDBEdit;
    Panel10: TPanel;
    Label6: TLabel;
    Panel8: TPanel;
    Edt_VlrVendaLiquidaAteHoje: TDBEdit;
    Panel11: TPanel;
    Label3: TLabel;
    Panel12: TPanel;
    Label4: TLabel;
    Panel13: TPanel;
    Label7: TLabel;
    Panel14: TPanel;
    Edt_VlrMetaDiaria: TDBEdit;
    Panel15: TPanel;
    Edt_VlrMetaDiariaReajustada: TDBEdit;
    Panel16: TPanel;
    Edt_VlrDevolucaoAteHoje: TDBEdit;
    Panel2: TPanel;
    Pnl_MetaAtingida: TPanel;
    ACBrGIF1: TACBrGIF;
    Lbl_MensagemMetaAtingida: TLabel;
    DtSrc_Meta: TDataSource;
    Lbl_Versao: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Btn_SairClick(Sender: TObject);
  private
    { Private declarations }
    MetaVendedorController: IMetaVendedorController;
    FCodVendedor: String;
    procedure CarregarGif;
    procedure MostrarMensagemDiasUteis;
    procedure MostrarMesAno;
    procedure CalcularBarras;
    procedure AjustarTamanhoPanel(MetaAtingida: Boolean);
    procedure SetCodVendedor(const Value: String);
  public
    { Public declarations }

    property CodVendedor: String read FCodVendedor write SetCodVendedor;
  end;

var
  OrcamentoViewConsultaMetaVendedor: TOrcamentoViewConsultaMetaVendedor;

implementation

{$R *.dfm}


procedure TOrcamentoViewConsultaMetaVendedor.Btn_SairClick(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TOrcamentoViewConsultaMetaVendedor.CalcularBarras;
Var
  Per: Extended;
  larguraBarra: Integer;
  MetaAtingida: Boolean;
begin
  larguraBarra := Self.Width - 5;
  MetaAtingida := False;

  Pnl_Meta.Caption := FormatFloat('##0.00', 100) + '%';

  If Edt_VlrMetaMensal.Field.AsCurrency > Edt_VlrVendaLiquidaAteHoje.Field.AsCurrency then
  begin
    Pnl_Meta.Width := larguraBarra;
    Per := 0;

    if Edt_VlrMetaMensal.Field.Value > 0 then
      Per := Edt_VlrVendaLiquidaAteHoje.Field.AsCurrency / Edt_VlrMetaMensal.Field.AsCurrency * 100;

    Pnl_VendaAteHoje.Width := Trunc(Pnl_Meta.Width * Per / 100);
    Pnl_VendaAteHoje.Caption := FormatFloat('##0.00', Per) + '%';
  end
  Else
  Begin
    if Edt_VlrMetaMensal.Field.AsCurrency > 0  then
      Per := Edt_VlrVendaLiquidaAteHoje.Field.AsCurrency / Edt_VlrMetaMensal.Field.AsCurrency * 100;
    Pnl_VendaAteHoje.Caption := FormatFloat('##0.00', Per) + '%';

    Pnl_VendaAteHoje.Width := larguraBarra;
    Per := 0;

    IF Edt_VlrVendaLiquidaAteHoje.Field.AsCurrency > 0 then
      Per := Edt_VlrMetaMensal.Field.AsCurrency / Edt_VlrVendaLiquidaAteHoje.Field.AsCurrency * 100;

    Pnl_Meta.Width := Trunc(Pnl_VendaAteHoje.Width * Per / 100);
  End;

  // Calcular % da meta ate hoje em relacao ao valor da meta mensal
  Per := 0;

  if Edt_VlrMetaMensal.Field.Value > 0 then
    Per := Edt_VlrMetaAteHoje.Field.Value / Edt_VlrMetaMensal.Field.Value * 100;

  Pnl_MetaAteHoje.Width := Trunc(Pnl_Meta.Width * Per / 100);
  Pnl_MetaAteHoje.Caption := FormatFloat('##0.00', Per) + '%';

  MetaAtingida := (Pnl_VendaAteHoje.Width > Pnl_MetaAteHoje.Width) and
                   (Pnl_VendaAteHoje.Width > 0) and
                   (Pnl_MetaAteHoje.Width > 0);




  AjustarTamanhoPanel(MetaAtingida);

  Self.DoubleBuffered := true;
end;

procedure TOrcamentoViewConsultaMetaVendedor.CarregarGif;
var
  fs: TFileStream;
  rs: TResourceStream;
  s: string;
begin
  rs := nil;
  fs := nil;
  try
    rs := TResourceStream.Create(hInstance, 'Gif_MetaAtingida', RT_RCDATA);
    s := ExtractFilePath(Application.ExeName) + 'imagens';
    if Not DirectoryExists(s) then
      ForceDirectories(s);
    s := s + '\GifMetaAtingida.gif';

    fs := TFileStream.Create(s, fmCreate);
    rs.SaveToStream(fs);

  finally
    fs.Free;
    rs.Free;
  end;

  if FileExists(s) then
    ACBrGIF1.Filename := s
  Else
    ACBrGIF1.Visible := False;

end;

procedure TOrcamentoViewConsultaMetaVendedor.AjustarTamanhoPanel(MetaAtingida: Boolean);
begin
  Pnl_Meta.Left := 3;
  Pnl_MetaAteHoje.Left := Pnl_Meta.Left;
  Pnl_VendaAteHoje.Left := Pnl_Meta.Left;

  if MetaAtingida then
  begin
    Pnl_Meta.Top := 345;
    Pnl_MetaAtingida.Visible := true;
    ACBrGIF1.Start;
  end
  Else
  Begin
    Pnl_Meta.Top := 345 - Pnl_MetaAtingida.Height;
    Pnl_MetaAtingida.Visible := False;
  End;

  Pnl_MetaAteHoje.Top := Pnl_Meta.Top + 32;
  Pnl_VendaAteHoje.Top := Pnl_MetaAteHoje.Top + 32;
end;

procedure TOrcamentoViewConsultaMetaVendedor.FormCreate(Sender: TObject);

begin
  MetaVendedorController := TMetaVendedorController.New;

  MetaVendedorController
  .RegistrarDataSetDtSrc(DtSrc_Meta)
  .RegistrarDbWareEdit(Edt_VlrMetaMensal, _VlrMetaMensal)
  .RegistrarDbWareEdit(Edt_VlrMetaAteHoje, _VlrMetaAteHoje)
  .RegistrarDbWareEdit(Edt_VlrVendaLiquidaAteHoje, _VlrVendaLiquidaAteHoje)
  .RegistrarDbWareEdit(Edt_VlrDevolucaoAteHoje, _VlrDevolucaoAteHoje )
  .RegistrarDbWareEdit(Edt_VlrMetaDiaria, _VlrMetaDiaria)
  .RegistrarDbWareEdit(Edt_VlrMetaDiariaReajustada, _VlrMetaDiariaReajustada)
  .RegistrarDbWareLabel(Lbl_NomeVendedor, _NomeVendedor);

  Lbl_MensagemMetaAtingida.Caption := 'PARABÉNS !!!' + sLineBreak
    + 'Você  alcançou a meta. ' + sLineBreak
    + 'Continue assim !!!';

  Self.Caption := 'Consulta Meta Vendedor - Versao 1.08 ';
  Lbl_Versao.Caption := 'Versão 1.08';

  CarregarGif;

end;

procedure TOrcamentoViewConsultaMetaVendedor.FormShow(Sender: TObject);
begin
  If MetaVendedorController.ObterMetaVendedor(CodVendedor, date).isFound then
  begin
    MostrarMensagemDiasUteis;
    CalcularBarras;
  end;
  MostrarMesAno;
  TLib.Centralizar(TWinControl(Panel3), TWinControl(Lbl_NomeVendedor));

end;

procedure TOrcamentoViewConsultaMetaVendedor.MostrarMensagemDiasUteis;
Var
  d1, d2: Integer;
begin
  d1 :=  MetaVendedorController.
          Model.MetaVendedor
          .FieldByName(_QtDiasUteisMes).AsInteger;

  d2 := MetaVendedorController.
          Model.MetaVendedor
          .FieldByName(_QtdDiasRestanteMes).AsInteger;

  Lbl_DiasUteis.Caption := 'O mês de ' + TLib.ObterNomeMesAno(date) + ' tem ' + d1.ToString
    + ' dias úteis. Hoje falta ' + d2.ToString + ' dia(s) para encerrar o mes';
end;

procedure TOrcamentoViewConsultaMetaVendedor.MostrarMesAno;
begin
  Pnl_MesAno.Caption := TLib.ObterNomeMesAno(date);
end;

procedure TOrcamentoViewConsultaMetaVendedor.SetCodVendedor(const Value: String);
begin
  FCodVendedor := Value;
end;

initialization

ReportMemoryLeaksOnShutdown := DebugHook <> 0;
RegisterClass(TOrcamentoViewConsultaMetaVendedor);

finalization

UnRegisterClass(TOrcamentoViewConsultaMetaVendedor);

end.

  Os edits tem que ser no padrao EDT_[Nome do campo de acordo com as Constantes]
