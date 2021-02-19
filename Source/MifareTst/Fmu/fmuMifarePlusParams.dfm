object fmMifarePlusParams: TfmMifarePlusParams
  Left = 476
  Top = 438
  BorderStyle = bsSingle
  Caption = 'Mifare Plus RATS+PPS'
  ClientHeight = 174
  ClientWidth = 424
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
  object gsParameters: TGroupBox
    Left = 8
    Top = 8
    Width = 409
    Height = 113
    Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099
    TabOrder = 0
    DesignSize = (
      409
      113)
    object lblReceiveDivisor: TLabel
      Left = 16
      Top = 28
      Width = 92
      Height = 13
      Caption = #1057#1082#1086#1088#1086#1089#1090#1100' '#1087#1088#1080#1077#1084#1072':'
    end
    object lblSendDivisor: TLabel
      Left = 16
      Top = 60
      Width = 101
      Height = 13
      Caption = #1057#1082#1086#1088#1086#1089#1090#1100' '#1087#1077#1088#1077#1076#1072#1095#1080':'
    end
    object cbReceiveDivisor: TComboBox
      Left = 136
      Top = 24
      Width = 129
      Height = 21
      Hint = 'ReceiveDivisor'
      Style = csDropDownList
      Anchors = [akLeft, akTop, akRight]
      ItemHeight = 13
      TabOrder = 0
      Items.Strings = (
        '106 kBaud'
        '212 kBaud'
        '424 kBaud'
        '848 kBaud')
    end
    object btnMifarePlusWriteParameters: TButton
      Left = 272
      Top = 24
      Width = 129
      Height = 25
      Hint = 'MifarePlusWriteParameters'
      Anchors = [akTop, akRight]
      Caption = #1047#1072#1087#1080#1089#1072#1090#1100' '#1089#1082#1086#1088#1086#1089#1090#1100
      TabOrder = 2
      OnClick = btnMifarePlusWriteParametersClick
    end
    object cbSendDivisor: TComboBox
      Left = 136
      Top = 56
      Width = 129
      Height = 21
      Hint = 'SendDivisor'
      Style = csDropDownList
      Anchors = [akLeft, akTop, akRight]
      ItemHeight = 13
      TabOrder = 1
      Items.Strings = (
        '106 kBaud'
        '212 kBaud'
        '424 kBaud'
        '848 kBaud')
    end
  end
end
