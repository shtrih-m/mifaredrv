object fmTrailer: TfmTrailer
  Left = 554
  Top = 325
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1056#1077#1076#1072#1082#1090#1086#1088' '#1090#1088#1077#1081#1083#1077#1088#1072
  ClientHeight = 440
  ClientWidth = 384
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lblKeyA: TLabel
    Left = 8
    Top = 32
    Width = 64
    Height = 13
    Caption = #1050#1083#1102#1095' '#1040', Hex:'
  end
  object lblKeyB: TLabel
    Left = 8
    Top = 56
    Width = 64
    Height = 13
    Caption = #1050#1083#1102#1095' '#1041', Hex:'
  end
  object lblTrailer: TLabel
    Left = 8
    Top = 340
    Width = 76
    Height = 13
    Caption = #1047#1085#1072#1095#1077#1085#1080#1077', Hex:'
  end
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 81
    Height = 13
    Caption = #1053#1086#1084#1077#1088' '#1089#1077#1082#1090#1086#1088#1072':'
  end
  object lblWarning: TLabel
    Left = 120
    Top = 360
    Width = 102
    Height = 13
    Caption = #1054#1096#1080#1073#1082#1072' '#1074' '#1090#1088#1077#1081#1083#1077#1088#1077'!'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Visible = False
  end
  object Bevel1: TBevel
    Left = 8
    Top = 392
    Width = 369
    Height = 9
    Shape = bsBottomLine
  end
  object Bevel2: TBevel
    Left = 8
    Top = 312
    Width = 369
    Height = 9
    Shape = bsBottomLine
  end
  object Bevel3: TBevel
    Left = 7
    Top = 80
    Width = 370
    Height = 9
    Shape = bsBottomLine
  end
  object Label5: TLabel
    Left = 8
    Top = 96
    Width = 100
    Height = 13
    Caption = #1053#1086#1074#1099#1081' '#1082#1083#1102#1095' '#1040', Hex:'
  end
  object Label6: TLabel
    Left = 8
    Top = 120
    Width = 100
    Height = 13
    Caption = #1053#1086#1074#1099#1081' '#1082#1083#1102#1095' '#1041', Hex:'
  end
  object lblWarning2: TLabel
    Left = 120
    Top = 144
    Width = 183
    Height = 13
    Caption = #1050#1083#1102#1095#1080' '#1076#1086#1083#1078#1085#1099' '#1089#1086#1089#1090#1086#1103#1090#1100' '#1080#1079' 12 '#1073#1072#1081#1090'!'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Visible = False
  end
  object edtKeyA: TEdit
    Left = 120
    Top = 32
    Width = 153
    Height = 21
    MaxLength = 12
    TabOrder = 1
    Text = 'FFFFFFFFFFFF'
  end
  object edtKeyB: TEdit
    Left = 120
    Top = 56
    Width = 153
    Height = 21
    MaxLength = 12
    TabOrder = 2
    Text = '000000000000'
  end
  object edtTrailer: TEdit
    Left = 120
    Top = 336
    Width = 257
    Height = 21
    TabOrder = 6
  end
  object btnRead: TButton
    Left = 8
    Top = 408
    Width = 75
    Height = 25
    Caption = #1055#1088#1086#1095#1080#1090#1072#1090#1100
    Default = True
    TabOrder = 7
    OnClick = btnReadClick
  end
  object btnClose: TButton
    Left = 304
    Top = 408
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 9
    OnClick = btnCloseClick
  end
  object btnWrite: TButton
    Left = 88
    Top = 408
    Width = 75
    Height = 25
    Caption = #1047#1072#1087#1080#1089#1072#1090#1100
    TabOrder = 8
    OnClick = btnWriteClick
  end
  object edtNewKeyA: TEdit
    Left = 120
    Top = 96
    Width = 153
    Height = 21
    MaxLength = 12
    TabOrder = 3
    Text = 'FFFFFFFFFFFF'
    OnChange = edtNewKeyAChange
  end
  object edtNewKeyB: TEdit
    Left = 120
    Top = 120
    Width = 153
    Height = 21
    MaxLength = 12
    TabOrder = 4
    Text = '000000000000'
    OnChange = edtNewKeyBChange
  end
  object gbAccessBits: TGroupBox
    Left = 8
    Top = 160
    Width = 369
    Height = 121
    Caption = #1041#1080#1090#1099' '#1076#1086#1089#1090#1091#1087#1072
    TabOrder = 5
    object lblBlock0: TLabel
      Left = 8
      Top = 20
      Width = 34
      Height = 13
      Caption = #1041#1083#1086#1082'0:'
    end
    object lblBlock1: TLabel
      Left = 8
      Top = 44
      Width = 34
      Height = 13
      Caption = #1041#1083#1086#1082'1:'
    end
    object lblBlock2: TLabel
      Left = 8
      Top = 68
      Width = 34
      Height = 13
      Caption = #1041#1083#1086#1082'2:'
    end
    object lblBlock3: TLabel
      Left = 8
      Top = 92
      Width = 71
      Height = 13
      Caption = #1041#1083#1086#1082' '#1076#1086#1089#1090#1091#1087#1072':'
    end
    object btnBlock0: TButton
      Left = 340
      Top = 16
      Width = 21
      Height = 21
      Caption = '...'
      TabOrder = 1
      OnClick = btnBlock0Click
    end
    object btnBlock1: TButton
      Left = 340
      Top = 40
      Width = 21
      Height = 21
      Caption = '...'
      TabOrder = 3
      OnClick = btnBlock1Click
    end
    object btnBlock2: TButton
      Left = 340
      Top = 64
      Width = 21
      Height = 21
      Caption = '...'
      TabOrder = 5
      OnClick = btnBlock2Click
    end
    object btnBlock3: TButton
      Left = 340
      Top = 88
      Width = 21
      Height = 21
      Caption = '...'
      TabOrder = 7
      OnClick = btnBlock3Click
    end
    object cbBlock0: TComboBox
      Left = 112
      Top = 16
      Width = 225
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
      Items.Strings = (
        '0 0 0 -  '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
        '0 1 0 - '#1095#1090#1077#1085#1080#1077'/'#1079#1072#1087#1080#1089#1100
        '1 0 0 - '#1095#1090#1077#1085#1080#1077'/'#1079#1072#1087#1080#1089#1100
        '1 1 0 - '#1086#1087#1077#1088#1072#1094#1080#1080' '#1089#1086' '#1079#1085#1072#1095#1077#1085#1080#1077#1084
        '0 0 1 - '#1086#1087#1077#1088#1072#1094#1080#1080' '#1089#1086' '#1079#1085#1072#1095#1077#1085#1080#1077#1084
        '0 1 1 - '#1095#1090#1077#1085#1080#1077'/'#1079#1072#1087#1080#1089#1100
        '1 0 1 - '#1095#1090#1077#1085#1080#1077'/'#1079#1072#1087#1080#1089#1100
        '1 1 1 - '#1095#1090#1077#1085#1080#1077'/'#1079#1072#1087#1080#1089#1100)
    end
    object cbBlock1: TComboBox
      Left = 112
      Top = 40
      Width = 225
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 2
      Items.Strings = (
        '0 0 0 -  '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
        '0 1 0 - '#1095#1090#1077#1085#1080#1077'/'#1079#1072#1087#1080#1089#1100
        '1 0 0 - '#1095#1090#1077#1085#1080#1077'/'#1079#1072#1087#1080#1089#1100
        '1 1 0 - '#1086#1087#1077#1088#1072#1094#1080#1080' '#1089#1086' '#1079#1085#1072#1095#1077#1085#1080#1077#1084
        '0 0 1 - '#1086#1087#1077#1088#1072#1094#1080#1080' '#1089#1086' '#1079#1085#1072#1095#1077#1085#1080#1077#1084
        '0 1 1 - '#1095#1090#1077#1085#1080#1077'/'#1079#1072#1087#1080#1089#1100
        '1 0 1 - '#1095#1090#1077#1085#1080#1077'/'#1079#1072#1087#1080#1089#1100
        '1 1 1 - '#1095#1090#1077#1085#1080#1077'/'#1079#1072#1087#1080#1089#1100)
    end
    object cbBlock2: TComboBox
      Left = 112
      Top = 64
      Width = 225
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 4
      Items.Strings = (
        '0 0 0 -  '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
        '0 1 0 - '#1095#1090#1077#1085#1080#1077'/'#1079#1072#1087#1080#1089#1100
        '1 0 0 - '#1095#1090#1077#1085#1080#1077'/'#1079#1072#1087#1080#1089#1100
        '1 1 0 - '#1086#1087#1077#1088#1072#1094#1080#1080' '#1089#1086' '#1079#1085#1072#1095#1077#1085#1080#1077#1084
        '0 0 1 - '#1086#1087#1077#1088#1072#1094#1080#1080' '#1089#1086' '#1079#1085#1072#1095#1077#1085#1080#1077#1084
        '0 1 1 - '#1095#1090#1077#1085#1080#1077'/'#1079#1072#1087#1080#1089#1100
        '1 0 1 - '#1095#1090#1077#1085#1080#1077'/'#1079#1072#1087#1080#1089#1100
        '1 1 1 - '#1095#1090#1077#1085#1080#1077'/'#1079#1072#1087#1080#1089#1100)
    end
    object cbBlock3: TComboBox
      Left = 112
      Top = 88
      Width = 225
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 6
      Items.Strings = (
        '0 0 0 - '#1082#1083#1102#1095' '#1041' '#1095#1080#1090#1072#1077#1090#1089#1103
        '0 1 0 - '#1082#1083#1102#1095' '#1041' '#1095#1080#1090#1072#1077#1090#1089#1103
        '1 0 0'
        '1 1 0'
        '0 0 1 - '#1082#1083#1102#1095' '#1041' '#1095#1080#1090#1072#1077#1090#1089#1103'  ('#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102')'
        '0 1 1'
        '1 0 1'
        '1 1 1')
    end
  end
  object btnDecode: TButton
    Left = 288
    Top = 368
    Width = 91
    Height = 25
    Caption = #1044#1077#1082#1086#1076#1080#1088#1086#1074#1072#1090#1100
    TabOrder = 10
    OnClick = btnDecodeClick
  end
  object btnEncode: TButton
    Left = 288
    Top = 288
    Width = 91
    Height = 25
    Caption = #1050#1086#1076#1080#1088#1086#1074#1072#1090#1100
    TabOrder = 11
    OnClick = btnEncodeClick
  end
  object seSectorNumber: TSpinEdit
    Left = 120
    Top = 8
    Width = 153
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 0
    Value = 0
  end
end
