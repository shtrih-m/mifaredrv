object fmTest: TfmTest
  Left = 331
  Top = 153
  Width = 361
  Height = 313
  Caption = #1058#1077#1089#1090#1099
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    345
    275)
  PixelsPerInch = 96
  TextHeight = 13
  object Memo: TMemo
    Left = 8
    Top = 8
    Width = 217
    Height = 225
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 0
    WordWrap = False
  end
  object btnWriteData: TButton
    Left = 232
    Top = 8
    Width = 105
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #1047#1072#1087#1080#1089#1100' '#1076#1072#1085#1085#1099#1093
    TabOrder = 1
    OnClick = btnWriteDataClick
  end
  object btnWriteField: TButton
    Left = 232
    Top = 40
    Width = 105
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #1047#1072#1087#1080#1089#1100' '#1087#1086#1083#1077#1081
    TabOrder = 2
    OnClick = btnWriteFieldClick
  end
  object btnKeyA: TButton
    Left = 232
    Top = 72
    Width = 105
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #1050#1083#1102#1095' '#1040
    TabOrder = 3
    OnClick = btnKeyAClick
  end
  object btnKeyB: TButton
    Left = 232
    Top = 104
    Width = 105
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #1050#1083#1102#1095' B'
    TabOrder = 4
    OnClick = btnKeyBClick
  end
  object btnCatalog: TButton
    Left = 232
    Top = 136
    Width = 105
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #1050#1072#1090#1072#1083#1086#1075
    TabOrder = 5
    OnClick = btnCatalogClick
  end
  object btnAuth: TButton
    Left = 232
    Top = 168
    Width = 105
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #1040#1074#1090#1086#1088#1080#1079#1072#1094#1080#1103
    TabOrder = 6
    OnClick = btnAuthClick
  end
  object chbInitCard: TCheckBox
    Left = 8
    Top = 240
    Width = 185
    Height = 17
    Anchors = [akLeft, akBottom]
    Caption = #1048#1085#1080#1094#1080#1072#1083#1080#1079#1072#1094#1080#1103' '#1082#1072#1088#1090#1099
    Checked = True
    State = cbChecked
    TabOrder = 7
  end
end
