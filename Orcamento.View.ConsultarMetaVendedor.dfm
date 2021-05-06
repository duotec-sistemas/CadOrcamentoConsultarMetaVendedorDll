object OrcamentoViewConsultaMetaVendedor: TOrcamentoViewConsultaMetaVendedor
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Meta de Vendedor - 1.01 - 10/02/2020'
  ClientHeight = 485
  ClientWidth = 1000
  Color = clBlack
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 17
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 5
    Top = 5
    Width = 990
    Height = 475
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    DesignSize = (
      990
      475)
    object Label1: TLabel
      Left = 64
      Top = -1
      Width = 120
      Height = 21
      Anchors = []
      Caption = 'Vlr Meta at'#233' Hoje'
      Color = 4818244
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      ExplicitLeft = 65
      ExplicitTop = 0
    end
    object Pnl_MesAno: TPanel
      Left = 0
      Top = 0
      Width = 990
      Height = 33
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Fevereiro 2020'
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 0
      DesignSize = (
        990
        33)
      object Lbl_Versao: TLabel
        Left = 931
        Top = 2
        Width = 59
        Height = 13
        Anchors = [akTop, akRight]
        Caption = 'Vers'#227'o 1.06'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
    end
    object Panel3: TPanel
      Left = 0
      Top = 65
      Width = 990
      Height = 41
      Align = alTop
      BevelOuter = bvNone
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 1
      object Lbl_NomeVendedor: TDBText
        Left = 64
        Top = -2
        Width = 167
        Height = 25
        AutoSize = True
        DataSource = DtSrc_Meta
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
    end
    object Panel6: TPanel
      Left = 0
      Top = 440
      Width = 990
      Height = 35
      Align = alBottom
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 2
      object DBText1: TDBText
        Left = 416
        Top = 32
        Width = 65
        Height = 17
      end
      object Lbl_DiasUteis: TLabel
        Left = 8
        Top = 6
        Width = 4
        Height = 21
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Btn_Sair: TBitBtn
        AlignWithMargins = True
        Left = 894
        Top = 4
        Width = 92
        Height = 27
        Align = alRight
        Caption = 'Sair'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = Btn_SairClick
      end
    end
    object Pnl_Meta: TPanel
      Left = 8
      Top = 345
      Width = 984
      Height = 32
      BevelOuter = bvNone
      Color = 4818244
      Ctl3D = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 3
    end
    object Pnl_MetaAteHoje: TPanel
      Left = 8
      Top = 377
      Width = 984
      Height = 32
      BevelOuter = bvNone
      Color = 6215328
      Ctl3D = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 4
    end
    object Pnl_VendaAteHoje: TPanel
      Left = 8
      Top = 407
      Width = 984
      Height = 32
      BevelOuter = bvNone
      Color = 7465200
      Ctl3D = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 5
    end
    object GridPanel1: TGridPanel
      Left = 0
      Top = 106
      Width = 990
      Height = 129
      Align = alTop
      BevelOuter = bvNone
      ColumnCollection = <
        item
          Value = 33.500825704388820000
        end
        item
          Value = 33.333064200310940000
        end
        item
          Value = 33.166110095300240000
        end>
      ControlCollection = <
        item
          Column = 1
          Control = Panel4
          Row = 0
        end
        item
          Column = 1
          Control = Panel7
          Row = 1
        end
        item
          Column = 0
          Control = Panel5
          Row = 0
        end
        item
          Column = 0
          Control = Panel9
          Row = 1
        end
        item
          Column = 2
          Control = Panel10
          Row = 0
        end
        item
          Column = 2
          Control = Panel8
          Row = 1
        end
        item
          Column = 0
          Control = Panel11
          Row = 2
        end
        item
          Column = 1
          Control = Panel12
          Row = 2
        end
        item
          Column = 2
          Control = Panel13
          Row = 2
        end
        item
          Column = 0
          Control = Panel14
          Row = 3
        end
        item
          Column = 1
          Control = Panel15
          Row = 3
        end
        item
          Column = 2
          Control = Panel16
          Row = 3
        end>
      RowCollection = <
        item
          Value = 24.999951154257260000
        end
        item
          Value = 24.999983505411330000
        end
        item
          Value = 25.000044385110360000
        end
        item
          Value = 25.000020955221050000
        end>
      TabOrder = 6
      object Panel4: TPanel
        Left = 331
        Top = 0
        Width = 329
        Height = 32
        Align = alClient
        BevelOuter = bvNone
        Color = 6215328
        ParentBackground = False
        TabOrder = 0
        object Label5: TLabel
          Left = 88
          Top = 5
          Width = 118
          Height = 21
          Caption = 'Vlr meta at'#233' hoje'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
      end
      object Panel7: TPanel
        Left = 331
        Top = 32
        Width = 329
        Height = 32
        Align = alClient
        BevelOuter = bvNone
        Color = 6215328
        ParentBackground = False
        TabOrder = 1
        DesignSize = (
          329
          32)
        object Edt_VlrMetaAteHoje: TDBEdit
          Left = 87
          Top = 2
          Width = 121
          Height = 23
          Anchors = []
          BorderStyle = bsNone
          Color = 6215328
          DataSource = DtSrc_Meta
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
        end
      end
      object Panel5: TPanel
        Left = 0
        Top = 0
        Width = 331
        Height = 32
        Align = alClient
        BevelOuter = bvNone
        Color = 4818244
        ParentBackground = False
        TabOrder = 2
        object Label2: TLabel
          Left = 88
          Top = 4
          Width = 113
          Height = 21
          Caption = 'Vlr Meta Mensal'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWhite
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
      end
      object Panel9: TPanel
        Left = 0
        Top = 32
        Width = 331
        Height = 32
        Align = alClient
        BevelOuter = bvNone
        Color = 4818244
        ParentBackground = False
        TabOrder = 3
        DesignSize = (
          331
          32)
        object Edt_VlrMetaMensal: TDBEdit
          Left = 87
          Top = 2
          Width = 113
          Height = 20
          Anchors = []
          BorderStyle = bsNone
          Color = 4818244
          DataSource = DtSrc_Meta
          Font.Charset = ANSI_CHARSET
          Font.Color = clWhite
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
        end
      end
      object Panel10: TPanel
        Left = 660
        Top = 0
        Width = 330
        Height = 32
        Align = alClient
        BevelOuter = bvNone
        Color = 7465200
        Ctl3D = False
        ParentBackground = False
        ParentCtl3D = False
        TabOrder = 4
        object Label6: TLabel
          Left = 88
          Top = 4
          Width = 128
          Height = 21
          Caption = 'Vlr. venda at'#233' hoje'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
      end
      object Panel8: TPanel
        Left = 660
        Top = 32
        Width = 330
        Height = 32
        Align = alClient
        BevelOuter = bvNone
        Color = 7465200
        Ctl3D = False
        ParentBackground = False
        ParentCtl3D = False
        TabOrder = 5
        DesignSize = (
          330
          32)
        object Edt_VlrVendaLiquidaAteHoje: TDBEdit
          Left = 87
          Top = 2
          Width = 129
          Height = 20
          Anchors = []
          BorderStyle = bsNone
          Color = 7465200
          DataSource = DtSrc_Meta
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
        end
      end
      object Panel11: TPanel
        Left = 0
        Top = 64
        Width = 331
        Height = 32
        Align = alClient
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 6
        object Label3: TLabel
          Left = 104
          Top = 6
          Width = 105
          Height = 21
          Caption = 'Vlr. meta di'#225'ria'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
      end
      object Panel12: TPanel
        Left = 331
        Top = 64
        Width = 329
        Height = 32
        Align = alClient
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 7
        object Label4: TLabel
          Left = 88
          Top = 6
          Width = 167
          Height = 21
          Caption = 'Vlr. meta diaria ajustada'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
      end
      object Panel13: TPanel
        Left = 660
        Top = 64
        Width = 330
        Height = 32
        Align = alClient
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 8
        object Label7: TLabel
          Left = 104
          Top = 6
          Width = 105
          Height = 21
          Caption = 'Vlr. devolu'#231#245'es'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
      end
      object Panel14: TPanel
        Left = 0
        Top = 96
        Width = 331
        Height = 33
        Align = alClient
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 9
        DesignSize = (
          331
          33)
        object Edt_VlrMetaDiaria: TDBEdit
          Left = 103
          Top = 2
          Width = 105
          Height = 20
          Anchors = []
          BorderStyle = bsNone
          Color = clWhite
          DataSource = DtSrc_Meta
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
        end
      end
      object Panel15: TPanel
        Left = 331
        Top = 96
        Width = 329
        Height = 33
        Align = alClient
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 10
        DesignSize = (
          329
          33)
        object Edt_VlrMetaDiariaReajustada: TDBEdit
          Left = 87
          Top = 2
          Width = 169
          Height = 20
          Anchors = []
          BorderStyle = bsNone
          Color = clWhite
          DataSource = DtSrc_Meta
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
        end
      end
      object Panel16: TPanel
        Left = 660
        Top = 96
        Width = 330
        Height = 33
        Align = alClient
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 11
        DesignSize = (
          330
          33)
        object Edt_VlrDevolucaoAteHoje: TDBEdit
          Left = 103
          Top = 2
          Width = 105
          Height = 20
          Anchors = []
          BorderStyle = bsNone
          Color = clWhite
          DataSource = DtSrc_Meta
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
        end
      end
    end
    object Panel2: TPanel
      Left = 0
      Top = 33
      Width = 990
      Height = 32
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Meta do vendedor '
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 7
    end
    object Pnl_MetaAtingida: TPanel
      Left = 0
      Top = 235
      Width = 990
      Height = 109
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 8
      Visible = False
      object ACBrGIF1: TACBrGIF
        AlignWithMargins = True
        Left = 250
        Top = 3
        Width = 108
        Height = 103
        Margins.Left = 250
        Align = alLeft
        ExplicitHeight = 100
      end
      object Lbl_MensagemMetaAtingida: TLabel
        AlignWithMargins = True
        Left = 381
        Top = 3
        Width = 359
        Height = 103
        Margins.Left = 20
        Align = alLeft
        AutoSize = False
        Caption = 'PARAB'#201'NS. Voc'#234' alcan'#231'ou a meta. Continue assim'
        Font.Charset = ANSI_CHARSET
        Font.Color = clOlive
        Font.Height = -24
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        WordWrap = True
        ExplicitLeft = 104
        ExplicitTop = 4
        ExplicitHeight = 109
      end
    end
  end
  object DtSrc_Meta: TDataSource
    Left = 80
    Top = 48
  end
end
