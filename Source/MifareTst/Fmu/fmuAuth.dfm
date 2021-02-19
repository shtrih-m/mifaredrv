object fmAuth: TfmAuth
  Left = 396
  Top = 246
  BorderStyle = bsSingle
  Caption = #1040#1074#1090#1086#1088#1080#1079#1072#1094#1080#1103
  ClientHeight = 291
  ClientWidth = 391
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lblKeyNumber: TLabel
    Left = 8
    Top = 36
    Width = 71
    Height = 13
    Caption = #1053#1086#1084#1077#1088' '#1082#1083#1102#1095#1072':'
  end
  object lblBlockNumber: TLabel
    Left = 8
    Top = 60
    Width = 70
    Height = 13
    Caption = #1053#1086#1084#1077#1088' '#1073#1083#1086#1082#1072':'
  end
  object lblAuthKey: TLabel
    Left = 8
    Top = 10
    Width = 97
    Height = 13
    Caption = #1050#1083#1102#1095' '#1072#1074#1090#1086#1088#1080#1079#1072#1094#1080#1080':'
  end
  object lblSerialNumber: TLabel
    Left = 8
    Top = 84
    Width = 96
    Height = 13
    Caption = #1053#1086#1084#1077#1088' '#1082#1072#1088#1090#1099', Hex:'
  end
  object lblKeyUncoded: TLabel
    Left = 8
    Top = 108
    Width = 179
    Height = 13
    Caption = #1053#1077#1082#1086#1076#1080#1088#1086#1074#1072#1085#1085#1099#1081' '#1082#1083#1102#1095', 6 '#1073#1072#1081#1090' Hex:'
  end
  object lblKeyEncoded: TLabel
    Left = 8
    Top = 132
    Width = 172
    Height = 13
    Caption = #1050#1086#1076#1080#1088#1086#1074#1072#1085#1085#1099#1081' '#1082#1083#1102#1095', 12 '#1073#1072#1081#1090' Hex:'
  end
  object btnPiccAuth: TButton
    Left = 56
    Top = 216
    Width = 193
    Height = 25
    Hint = 'PiccAuth'
    Caption = #1040#1074#1090#1086#1088#1080#1079#1072#1094#1080#1103' '#1079#1072#1087#1080#1089#1072#1085#1085#1099#1084' '#1082#1083#1102#1095#1086#1084
    ParentShowHint = False
    ShowHint = True
    TabOrder = 8
    OnClick = btnPiccAuthClick
  end
  object rbKeyB: TRadioButton
    Left = 264
    Top = 8
    Width = 33
    Height = 17
    Hint = 'KeyType=ktKeyB'
    Caption = #1042
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
  end
  object rbKeyA: TRadioButton
    Left = 200
    Top = 8
    Width = 41
    Height = 17
    Hint = 'KeyType=ktKeyA'
    Caption = #1040
    Checked = True
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    TabStop = True
  end
  object edtUIDHex: TEdit
    Left = 200
    Top = 80
    Width = 185
    Height = 21
    Hint = 'UIDHex'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    Text = '2697F0B9'
  end
  object btnHostCodeKey: TButton
    Left = 256
    Top = 184
    Width = 129
    Height = 25
    Hint = 'EncodeKey'
    Caption = #1050#1086#1076#1080#1088#1086#1074#1072#1090#1100' '#1082#1083#1102#1095
    ParentShowHint = False
    ShowHint = True
    TabOrder = 10
    OnClick = btnHostCodeKeyClick
  end
  object btnPcdLoadKeyE2: TButton
    Left = 256
    Top = 216
    Width = 129
    Height = 25
    Hint = 'PcdLoadKeyE2'
    Caption = #1047#1072#1087#1080#1089#1072#1090#1100' '#1082#1083#1102#1095
    ParentShowHint = False
    ShowHint = True
    TabOrder = 11
    OnClick = btnPcdLoadKeyE2Click
  end
  object edtKeyUncoded: TEdit
    Left = 200
    Top = 104
    Width = 185
    Height = 21
    Hint = 'KeyUncoded'
    MaxLength = 12
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    Text = '0'
  end
  object btnPiccAuthKey: TButton
    Left = 56
    Top = 184
    Width = 193
    Height = 25
    Hint = 'PiccAuthKey'
    Caption = #1040#1074#1090#1086#1088#1080#1079#1072#1094#1080#1103' '#1087#1086' '#1082#1083#1102#1095#1091
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
    OnClick = btnPiccAuthKeyClick
  end
  object edtKeyEncoded: TEdit
    Left = 200
    Top = 128
    Width = 185
    Height = 21
    Hint = 'KeyEncoded'
    MaxLength = 24
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    Text = '0F0F0F0F0F0F0F0F0F0F0F0F'
  end
  object btnActivate: TButton
    Left = 56
    Top = 248
    Width = 193
    Height = 25
    Hint = 'PiccActivateWakeUp'
    Caption = #1040#1082#1090#1080#1074#1072#1094#1080#1103' '#1082#1072#1088#1090#1099
    ParentShowHint = False
    ShowHint = True
    TabOrder = 9
    OnClick = btnActivateClick
  end
  object seKeyNumber: TSpinEdit
    Left = 200
    Top = 32
    Width = 185
    Height = 22
    Hint = 'KeyNumber'
    MaxValue = 255
    MinValue = 0
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    Value = 0
  end
  object seBlockNumber: TSpinEdit
    Left = 200
    Top = 56
    Width = 185
    Height = 22
    Hint = 'BlockNumber'
    MaxValue = 255
    MinValue = 0
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    Value = 0
  end
end
