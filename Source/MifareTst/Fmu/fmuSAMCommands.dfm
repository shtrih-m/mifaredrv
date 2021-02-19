object fmSAMCommands: TfmSAMCommands
  Left = 342
  Top = 193
  BorderStyle = bsSingle
  Caption = 'SAM '#1082#1086#1084#1072#1085#1076#1099
  ClientHeight = 271
  ClientWidth = 512
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  ShowHint = True
  PixelsPerInch = 96
  TextHeight = 13
  object lblKey: TLabel
    Left = 8
    Top = 112
    Width = 52
    Height = 13
    Caption = #1050#1083#1102#1095', hex:'
  end
  object lblKeyEntryNumber: TLabel
    Left = 8
    Top = 144
    Width = 116
    Height = 13
    Caption = #1053#1086#1084#1077#1088' '#1079#1072#1087#1080#1089#1080' '#1082#1083#1102#1095#1077#1081':'
  end
  object lblSerialNumber: TLabel
    Left = 240
    Top = 144
    Width = 112
    Height = 13
    Caption = #1057#1077#1088#1080#1081#1085#1099#1081' '#1085#1086#1084#1077#1088', hex:'
  end
  object btnSAM_WriteHostAuthKey: TButton
    Left = 80
    Top = 176
    Width = 209
    Height = 25
    Hint = 'SAM_WriteHostAuthKey'
    Caption = #1047#1072#1087#1080#1089#1072#1090#1100' '#1082#1083#1102#1095' '#1072#1091#1090#1077#1085#1090#1080#1092#1080#1082#1072#1094#1080#1080' '#1093#1086#1089#1090#1072
    TabOrder = 4
    OnClick = btnSAM_WriteHostAuthKeyClick
  end
  object edtKeyUncoded: TEdit
    Left = 72
    Top = 112
    Width = 433
    Height = 21
    Hint = 'KeyUncoded'
    TabOrder = 1
    Text = '01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16'
  end
  object btnSAM_GetKeyEntry: TButton
    Left = 80
    Top = 208
    Width = 209
    Height = 25
    Hint = 'SAM_GetKeyEntry'
    Caption = #1055#1086#1083#1091#1095#1080#1090#1100' '#1087#1072#1088#1072#1084#1077#1090#1088#1099' '#1082#1083#1102#1095#1072
    TabOrder = 5
    OnClick = btnSAM_GetKeyEntryClick
  end
  object Memo: TMemo
    Left = 8
    Top = 8
    Width = 497
    Height = 97
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 0
    WordWrap = False
  end
  object btnReadFullSerialNumber: TButton
    Left = 296
    Top = 240
    Width = 209
    Height = 25
    Hint = 'ReadFullSerialNumber'
    Caption = #1055#1088#1086#1095#1080#1090#1072#1090#1100' '#1087#1086#1083#1085#1099#1081' '#1089#1077#1088#1080#1081#1085#1099#1081' '#1085#1086#1084#1077#1088
    TabOrder = 8
    OnClick = btnReadFullSerialNumberClick
  end
  object btnSAM_SetProtection: TButton
    Left = 296
    Top = 208
    Width = 209
    Height = 25
    Hint = 'SAM_SetProtection'
    Caption = #1042#1082#1083#1102#1095#1080#1090#1100' '#1079#1072#1097#1080#1090#1091' SAM '#1084#1086#1076#1091#1083#1103
    TabOrder = 7
    OnClick = btnSAM_SetProtectionClick
  end
  object btnSAM_SetProtectionSN: TButton
    Left = 296
    Top = 176
    Width = 209
    Height = 25
    Hint = 'SAM_SetProtectionSN'
    Caption = #1042#1082#1083#1102#1095#1080#1090#1100' '#1079#1072#1097#1080#1090#1091' SAM '#1087#1086' '#1085#1086#1084#1077#1088#1091
    TabOrder = 6
    OnClick = btnSAM_SetProtectionSNClick
  end
  object edtSerialNumberHex: TEdit
    Left = 368
    Top = 144
    Width = 137
    Height = 21
    Hint = 'SerialNumberHex'
    TabOrder = 3
    Text = '1'
  end
  object seKeyEntryNumber: TSpinEdit
    Left = 136
    Top = 144
    Width = 89
    Height = 22
    Hint = 'KeyEntryNumber'
    MaxValue = 255
    MinValue = 0
    TabOrder = 2
    Value = 0
  end
  object btnSAMGetKeyEntries: TButton
    Left = 80
    Top = 240
    Width = 209
    Height = 25
    Hint = 'SAM_GetKeyEntry'
    Caption = #1055#1086#1083#1091#1095#1080#1090#1100' '#1087#1072#1088#1072#1084#1077#1090#1088#1099' '#1082#1083#1102#1095#1077#1081
    TabOrder = 9
    OnClick = btnSAMGetKeyEntriesClick
  end
end
