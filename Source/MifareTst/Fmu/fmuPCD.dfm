object fmPCD: TfmPCD
  Left = 385
  Top = 276
  BorderStyle = bsSingle
  Caption = 'PCD'
  ClientHeight = 293
  ClientWidth = 389
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    389
    293)
  PixelsPerInch = 96
  TextHeight = 13
  object lblRfResetTime: TLabel
    Left = 8
    Top = 108
    Width = 98
    Height = 13
    Caption = #1042#1088#1077#1084#1103' '#1089#1073#1088#1086#1089#1072', '#1084#1089'.:'
  end
  object lblBeepTone: TLabel
    Left = 8
    Top = 204
    Width = 63
    Height = 13
    Caption = #1053#1086#1084#1077#1088' '#1090#1086#1085#1072':'
  end
  object btnPcdGetSerialNumber: TButton
    Left = 264
    Top = 8
    Width = 121
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #1057#1077#1088#1080#1081#1085#1099#1081' '#1085#1086#1084#1077#1088
    TabOrder = 1
    OnClick = btnPcdGetSerialNumberClick
  end
  object btnPcdGetFwVersion: TButton
    Left = 264
    Top = 40
    Width = 121
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #1042#1077#1088#1089#1080#1103' '#1055#1054
    TabOrder = 2
    OnClick = btnPcdGetFwVersionClick
  end
  object Memo: TMemo
    Left = 8
    Top = 8
    Width = 249
    Height = 89
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
  end
  object btnPcdGetRicVersion: TButton
    Left = 264
    Top = 72
    Width = 121
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #1042#1077#1088#1089#1080#1103' RIC'
    TabOrder = 3
    OnClick = btnPcdGetRicVersionClick
  end
  object btnPcdRfReset: TButton
    Left = 264
    Top = 104
    Width = 121
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #1057#1073#1088#1086#1089' RF '#1087#1086#1083#1103
    TabOrder = 4
    OnClick = btnPcdRfResetClick
  end
  object btnGetOnlineStatus: TButton
    Left = 264
    Top = 136
    Width = 121
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #1057#1086#1089#1090#1086#1103#1085#1080#1077' '#1087#1086#1088#1090#1072
    TabOrder = 5
    OnClick = btnGetOnlineStatusClick
  end
  object btnPcdReset: TButton
    Left = 264
    Top = 168
    Width = 121
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #1057#1073#1088#1086#1089' '#1089#1095#1080#1090#1099#1074#1072#1090#1077#1083#1103
    TabOrder = 6
    OnClick = btnPcdResetClick
  end
  object btnPcdBeep: TButton
    Left = 264
    Top = 200
    Width = 121
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #1043#1091#1076#1086#1082
    TabOrder = 7
    OnClick = btnPcdBeepClick
  end
  object btnSleepMode: TButton
    Left = 264
    Top = 232
    Width = 121
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #1047#1072#1089#1085#1091#1090#1100
    TabOrder = 8
    OnClick = btnSleepModeClick
  end
  object seRfResetTime: TSpinEdit
    Left = 120
    Top = 104
    Width = 137
    Height = 22
    Anchors = [akLeft, akTop, akRight]
    MaxValue = 0
    MinValue = 0
    TabOrder = 9
    Value = 1000
  end
  object seBeepTone: TSpinEdit
    Left = 120
    Top = 200
    Width = 137
    Height = 22
    Anchors = [akLeft, akTop, akRight]
    MaxValue = 0
    MinValue = 0
    TabOrder = 10
    Value = 1
  end
end
