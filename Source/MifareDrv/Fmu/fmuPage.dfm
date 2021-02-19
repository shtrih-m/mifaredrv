object fmPage: TfmPage
  Left = 409
  Top = 193
  Width = 406
  Height = 394
  Caption = #1044#1088#1072#1081#1074#1077#1088' MifareCard'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  OnShow = FormShow
  DesignSize = (
    390
    355)
  PixelsPerInch = 96
  TextHeight = 13
  object lblResult: TLabel
    Left = 8
    Top = 304
    Width = 55
    Height = 13
    Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090':'
  end
  object btnAbout: TButton
    Left = 240
    Top = 200
    Width = 153
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077'...'
    TabOrder = 8
    OnClick = btnAboutClick
  end
  object btnDefaults: TButton
    Left = 240
    Top = 168
    Width = 153
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #1055#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
    TabOrder = 7
    OnClick = btnDefaultsClick
  end
  object btnTrailer: TButton
    Left = 240
    Top = 136
    Width = 153
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #1058#1088#1077#1081#1083#1077#1088'...'
    TabOrder = 6
    OnClick = btnTrailerClick
  end
  object btnShowDirectoryDlg: TButton
    Left = 240
    Top = 104
    Width = 153
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1082#1072#1090#1072#1083#1086#1075'...'
    TabOrder = 5
    OnClick = btnShowDirectoryDlgClick
  end
  object btnSearch: TButton
    Left = 240
    Top = 72
    Width = 153
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #1055#1086#1080#1089#1082' '#1091#1089#1090#1088#1086#1081#1089#1090#1074#1072'...'
    TabOrder = 4
    OnClick = btnSearchClick
  end
  object btnWriteBaudRate: TButton
    Left = 240
    Top = 40
    Width = 153
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #1047#1072#1087#1080#1089#1072#1090#1100' '#1089#1082#1086#1088#1086#1089#1090#1100
    TabOrder = 3
    OnClick = btnWriteBaudRateClick
  end
  object btnConnect: TButton
    Left = 240
    Top = 8
    Width = 153
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #1055#1088#1086#1074#1077#1088#1082#1072' '#1089#1074#1103#1079#1080
    TabOrder = 2
    OnClick = btnConnectClick
  end
  object gbDriver: TGroupBox
    Left = 8
    Top = 216
    Width = 225
    Height = 81
    Anchors = [akLeft, akTop, akRight]
    Caption = #1044#1088#1072#1081#1074#1077#1088
    TabOrder = 1
    object lblInfo: TLabel
      Left = 8
      Top = 28
      Width = 151
      Height = 13
      Caption = #1044#1088#1072#1081#1074#1077#1088' '#1089#1095#1080#1090#1099#1074#1072#1090#1077#1083#1077#1081' Mifare'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblVersion_: TLabel
      Left = 8
      Top = 48
      Width = 91
      Height = 13
      Caption = #1042#1077#1088#1089#1080#1103' '#1076#1088#1072#1081#1074#1077#1088#1072':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object edtVersion: TEdit
      Left = 112
      Top = 48
      Width = 81
      Height = 21
      TabStop = False
      BorderStyle = bsNone
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 0
    end
  end
  object gbParams: TGroupBox
    Left = 8
    Top = 8
    Width = 225
    Height = 201
    Anchors = [akLeft, akTop, akRight]
    Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1089#1074#1103#1079#1080
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      225
      201)
    object lblDevice: TLabel
      Left = 8
      Top = 28
      Width = 90
      Height = 13
      Caption = #1058#1080#1087' '#1089#1095#1080#1090#1099#1074#1072#1090#1077#1083#1103':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object pnlCardmanReader: TPanel
      Left = 8
      Top = 72
      Width = 212
      Height = 120
      BevelOuter = bvNone
      TabOrder = 2
      Visible = False
      object Label1: TLabel
        Left = 0
        Top = 16
        Width = 65
        Height = 13
        AutoSize = False
        Caption = #1059#1089#1090#1088#1086#1081#1089#1090#1074#1086':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object btnUpdateDevices: TButton
        Left = 136
        Top = 64
        Width = 75
        Height = 25
        Caption = #1054#1073#1085#1086#1074#1080#1090#1100
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = btnUpdateDevicesClick
      end
      object cbReaderName: TComboBox
        Left = 0
        Top = 32
        Width = 209
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 13
        ParentFont = False
        TabOrder = 0
        Text = 'cbReaderName'
      end
    end
    object pnlMksReader: TPanel
      Left = 2
      Top = 72
      Width = 221
      Height = 121
      Anchors = [akLeft, akTop, akRight]
      BevelOuter = bvNone
      TabOrder = 1
      object lblTimeout: TLabel
        Left = 8
        Top = 16
        Width = 73
        Height = 13
        AutoSize = False
        Caption = #1058#1072#1081#1084#1072#1091#1090', '#1084#1089':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblPortNumber: TLabel
        Left = 8
        Top = 40
        Width = 53
        Height = 13
        Caption = 'COM '#1087#1086#1088#1090':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblBaudRate: TLabel
        Left = 8
        Top = 64
        Width = 51
        Height = 13
        Caption = #1057#1082#1086#1088#1086#1089#1090#1100':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblParity: TLabel
        Left = 8
        Top = 88
        Width = 51
        Height = 13
        Caption = #1063#1077#1090#1085#1086#1089#1090#1100':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object cbParity: TComboBox
        Left = 88
        Top = 88
        Width = 129
        Height = 21
        HelpContext = 120
        Style = csDropDownList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 13
        ParentFont = False
        TabOrder = 3
      end
      object cbBaudRate: TComboBox
        Left = 88
        Top = 64
        Width = 129
        Height = 21
        HelpContext = 120
        Style = csDropDownList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 13
        ParentFont = False
        TabOrder = 2
      end
      object cbPortNumber: TComboBox
        Left = 88
        Top = 40
        Width = 129
        Height = 21
        HelpContext = 120
        Style = csDropDownList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 13
        ParentFont = False
        TabOrder = 1
      end
      object seTimeout: TSpinEdit
        Left = 88
        Top = 14
        Width = 129
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 0
        Value = 0
      end
    end
    object cbDeviceType: TComboBox
      Left = 8
      Top = 48
      Width = 209
      Height = 21
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 0
      OnChange = cbDeviceTypeChange
    end
  end
  object edtResult: TMemo
    Left = 72
    Top = 304
    Width = 321
    Height = 49
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssVertical
    TabOrder = 9
  end
  object btnParams: TButton
    Left = 240
    Top = 232
    Width = 153
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099'..'
    TabOrder = 10
    OnClick = btnParamsClick
  end
end
