object fmUltraLightC: TfmUltraLightC
  Left = 379
  Top = 149
  BorderStyle = bsSingle
  Caption = 'Ultralight C'
  ClientHeight = 469
  ClientWidth = 448
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  ShowHint = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object gsAuth: TGroupBox
    Left = 8
    Top = 8
    Width = 433
    Height = 169
    Caption = #1040#1074#1090#1086#1088#1080#1079#1072#1094#1080#1103
    TabOrder = 0
    DesignSize = (
      433
      169)
    object lblKeyNumber: TLabel
      Left = 8
      Top = 52
      Width = 71
      Height = 13
      Caption = #1053#1086#1084#1077#1088' '#1082#1083#1102#1095#1072':'
    end
    object lblKeyA: TLabel
      Left = 8
      Top = 28
      Width = 95
      Height = 13
      Caption = #1050#1083#1102#1095', 16 '#1073#1072#1081#1090' Hex:'
    end
    object lblKeyPosition: TLabel
      Left = 8
      Top = 76
      Width = 81
      Height = 13
      Caption = #1055#1086#1079#1080#1094#1080#1103' '#1082#1083#1102#1095#1072':'
    end
    object lblKeyVersion: TLabel
      Left = 8
      Top = 100
      Width = 74
      Height = 13
      Caption = #1042#1077#1088#1089#1080#1103' '#1082#1083#1102#1095#1072':'
    end
    object lblUIDHex: TLabel
      Left = 8
      Top = 132
      Width = 96
      Height = 13
      Caption = #1053#1086#1084#1077#1088' '#1082#1072#1088#1090#1099', Hex:'
    end
    object btnUltralightWriteKey: TButton
      Left = 264
      Top = 56
      Width = 153
      Height = 25
      Hint = 'UltralightWriteKey'
      Anchors = [akTop, akRight]
      Caption = #1047#1072#1087#1080#1089#1072#1090#1100' '#1082#1083#1102#1095
      TabOrder = 4
      OnClick = btnUltralightWriteKeyClick
    end
    object edtBlockDataHex2: TEdit
      Left = 120
      Top = 24
      Width = 297
      Height = 21
      Hint = 'BlockDataHex'
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      Text = '49454D4B41455242214E4143554F5946'
    end
    object btnUltralightAuth: TButton
      Left = 264
      Top = 88
      Width = 153
      Height = 25
      Hint = 'UltralightAuth'
      Anchors = [akTop, akRight]
      Caption = #1040#1074#1090#1086#1088#1080#1079#1072#1094#1080#1103' '#1087#1086' '#1082#1083#1102#1095#1091
      TabOrder = 5
      OnClick = btnUltralightAuthClick
    end
    object edtUIDHex: TEdit
      Left = 120
      Top = 128
      Width = 137
      Height = 21
      Hint = 'UIDHex'
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 6
      Text = '2697F0B9'
    end
    object btnPiccActivateWakeUp: TButton
      Left = 264
      Top = 128
      Width = 153
      Height = 25
      Hint = 'PiccActivateWakeUp'
      Anchors = [akTop, akRight]
      Caption = #1040#1082#1090#1080#1074#1072#1094#1080#1103' '#1082#1072#1088#1090#1099
      TabOrder = 7
      OnClick = btnPiccActivateWakeUpClick
    end
    object seKeyNumber: TSpinEdit
      Left = 120
      Top = 48
      Width = 137
      Height = 22
      Hint = 'KeyNumber'
      Anchors = [akLeft, akTop, akRight]
      MaxValue = 255
      MinValue = 0
      TabOrder = 1
      Value = 0
    end
    object seKeyPosition: TSpinEdit
      Left = 120
      Top = 72
      Width = 137
      Height = 22
      Hint = 'KeyPosition'
      Anchors = [akLeft, akTop, akRight]
      MaxValue = 255
      MinValue = 0
      TabOrder = 2
      Value = 1
    end
    object seKeyVersion: TSpinEdit
      Left = 120
      Top = 96
      Width = 137
      Height = 22
      Hint = 'KeyVersion'
      Anchors = [akLeft, akTop, akRight]
      MaxValue = 255
      MinValue = 0
      TabOrder = 3
      Value = 1
    end
  end
  object gsData: TGroupBox
    Left = 8
    Top = 184
    Width = 433
    Height = 177
    Caption = #1044#1072#1085#1085#1099#1077
    TabOrder = 1
    DesignSize = (
      433
      177)
    object lblPageNumber: TLabel
      Left = 8
      Top = 56
      Width = 51
      Height = 13
      Caption = #1057#1090#1088#1072#1085#1080#1094#1072':'
    end
    object lblBlockDataHex: TLabel
      Left = 8
      Top = 28
      Width = 69
      Height = 13
      Caption = #1044#1072#1085#1085#1099#1077', Hex:'
    end
    object Label1: TLabel
      Left = 8
      Top = 120
      Width = 193
      Height = 49
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Caption = #1041#1072#1081#1090#1099' '#1073#1083#1086#1082#1080#1088#1086#1074#1082#1080' '#1085#1072#1089#1090#1088#1072#1080#1074#1072#1102#1090#1089#1103' '#1076#1083#1103' '#1089#1090#1088#1072#1085#1080#1094' 0x02 '#1080' 0x28'
      WordWrap = True
    end
    object edtBlockDataHex: TEdit
      Left = 88
      Top = 24
      Width = 329
      Height = 21
      Hint = 'BlockDataHex'
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
      Text = '00 00 00 00'
    end
    object btnUltralightRead: TButton
      Left = 208
      Top = 56
      Width = 97
      Height = 25
      Hint = 'UltralightRead'
      Anchors = [akTop, akRight]
      Caption = #1055#1088#1086#1095#1080#1090#1072#1090#1100
      TabOrder = 2
      OnClick = btnUltralightReadClick
    end
    object btnUltralightWrite: TButton
      Left = 312
      Top = 56
      Width = 105
      Height = 25
      Hint = 'UltralightWrite'
      Anchors = [akTop, akRight]
      Caption = #1047#1072#1087#1080#1089#1072#1090#1100
      TabOrder = 3
      OnClick = btnUltralightWriteClick
    end
    object btnUltralightCompatWrite: TButton
      Left = 208
      Top = 88
      Width = 209
      Height = 25
      Hint = 'UltralightCompatWrite'
      Anchors = [akTop, akRight]
      Caption = #1047#1072#1087#1080#1089#1072#1090#1100' '#1074' '#1088#1077#1078#1080#1084#1077' '#1089#1086#1074#1084#1077#1089#1090#1080#1084#1086#1089#1090#1080
      TabOrder = 4
      OnClick = btnUltralightCompatWriteClick
    end
    object btnLockBytes: TButton
      Left = 208
      Top = 120
      Width = 209
      Height = 25
      Hint = 'UltralightRead'
      Anchors = [akTop, akRight]
      Caption = #1041#1072#1081#1090#1099' '#1073#1083#1086#1082#1080#1088#1086#1074#1082#1080
      TabOrder = 5
      OnClick = btnLockBytesClick
    end
    object cbPageNumber: TComboBox
      Left = 88
      Top = 56
      Width = 105
      Height = 21
      Style = csDropDownList
      Anchors = [akLeft, akTop, akRight]
      ItemHeight = 13
      TabOrder = 0
      OnChange = cbPageNumberChange
    end
  end
end
