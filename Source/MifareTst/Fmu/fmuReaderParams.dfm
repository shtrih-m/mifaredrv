object fmReaderParams: TfmReaderParams
  Left = 385
  Top = 276
  BorderStyle = bsSingle
  Caption = #1057#1095#1080#1090#1099#1074#1072#1090#1077#1083#1100
  ClientHeight = 355
  ClientWidth = 424
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  ShowHint = True
  DesignSize = (
    424
    355)
  PixelsPerInch = 96
  TextHeight = 13
  object gsParams: TGroupBox
    Left = 8
    Top = 8
    Width = 409
    Height = 297
    Anchors = [akLeft, akTop, akRight]
    Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099
    TabOrder = 0
    DesignSize = (
      409
      297)
    object lblRfResetTime: TLabel
      Left = 8
      Top = 132
      Width = 98
      Height = 13
      Caption = #1042#1088#1077#1084#1103' '#1089#1073#1088#1086#1089#1072', '#1084#1089'.:'
    end
    object lblBeepTone: TLabel
      Left = 8
      Top = 228
      Width = 63
      Height = 13
      Caption = #1053#1086#1084#1077#1088' '#1090#1086#1085#1072':'
    end
    object lblPortStatus: TLabel
      Left = 8
      Top = 156
      Width = 89
      Height = 13
      Caption = #1057#1086#1089#1090#1086#1103#1085#1080#1077' '#1087#1086#1088#1090#1072':'
    end
    object btnPcdGetSerialNumber: TButton
      Left = 274
      Top = 32
      Width = 121
      Height = 25
      Hint = 'PcdGetSerialNumber'
      Anchors = [akTop, akRight]
      Caption = #1057#1077#1088#1080#1081#1085#1099#1081' '#1085#1086#1084#1077#1088
      TabOrder = 0
      OnClick = btnPcdGetSerialNumberClick
    end
    object btnPcdGetFwVersion: TButton
      Left = 274
      Top = 64
      Width = 121
      Height = 25
      Hint = 'PcdGetFwVersion'
      Anchors = [akTop, akRight]
      Caption = #1042#1077#1088#1089#1080#1103' '#1055#1054
      TabOrder = 1
      OnClick = btnPcdGetFwVersionClick
    end
    object Memo: TMemo
      Left = 8
      Top = 32
      Width = 259
      Height = 89
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 2
    end
    object btnPcdGetRicVersion: TButton
      Left = 274
      Top = 96
      Width = 121
      Height = 25
      Hint = 'PcdGetRicVersion'
      Anchors = [akTop, akRight]
      Caption = #1042#1077#1088#1089#1080#1103' RIC'
      TabOrder = 3
      OnClick = btnPcdGetRicVersionClick
    end
    object btnPcdRfReset: TButton
      Left = 274
      Top = 128
      Width = 121
      Height = 25
      Hint = 'PcdRfReset'
      Anchors = [akTop, akRight]
      Caption = #1057#1073#1088#1086#1089' RF '#1087#1086#1083#1103
      TabOrder = 4
      OnClick = btnPcdRfResetClick
    end
    object btnPortOpened: TButton
      Left = 274
      Top = 160
      Width = 121
      Height = 25
      Hint = 'PortOpened'
      Anchors = [akTop, akRight]
      Caption = #1057#1086#1089#1090#1086#1103#1085#1080#1077' '#1087#1086#1088#1090#1072
      TabOrder = 5
      OnClick = btnPortOpenedClick
    end
    object btnPcdReset: TButton
      Left = 274
      Top = 192
      Width = 121
      Height = 25
      Hint = 'PcdReset'
      Anchors = [akTop, akRight]
      Caption = #1057#1073#1088#1086#1089' '#1089#1095#1080#1090#1099#1074#1072#1090#1077#1083#1103
      TabOrder = 6
      OnClick = btnPcdResetClick
    end
    object btnPcdBeep: TButton
      Left = 274
      Top = 224
      Width = 121
      Height = 25
      Hint = 'PcdBeep'
      Anchors = [akTop, akRight]
      Caption = #1043#1091#1076#1086#1082
      TabOrder = 7
      OnClick = btnPcdBeepClick
    end
    object btnSleepMode: TButton
      Left = 274
      Top = 256
      Width = 121
      Height = 25
      Hint = 'SleepMode'
      Anchors = [akTop, akRight]
      Caption = #1047#1072#1089#1085#1091#1090#1100
      TabOrder = 8
      OnClick = btnSleepModeClick
    end
    object seRfResetTime: TSpinEdit
      Left = 120
      Top = 128
      Width = 147
      Height = 22
      Hint = 'RfResetTime'
      Anchors = [akLeft, akTop, akRight]
      MaxValue = 65535
      MinValue = 0
      TabOrder = 9
      Value = 1000
    end
    object seBeepTone: TSpinEdit
      Left = 120
      Top = 224
      Width = 147
      Height = 22
      Hint = 'BeepTone'
      Anchors = [akLeft, akTop, akRight]
      MaxValue = 0
      MinValue = 0
      TabOrder = 10
      Value = 1
    end
    object edtPortStatus: TEdit
      Left = 120
      Top = 160
      Width = 145
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 11
    end
  end
end
