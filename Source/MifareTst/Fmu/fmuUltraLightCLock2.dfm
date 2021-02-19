object fmUltraLightCLock2: TfmUltraLightCLock2
  Left = 553
  Top = 120
  BorderStyle = bsDialog
  Caption = #1041#1080#1090#1099' '#1073#1083#1086#1082#1080#1088#1086#1074#1082#1080', '#1089#1090#1088#1072#1085#1080#1094#1072' 40'
  ClientHeight = 335
  ClientWidth = 520
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
  object Bevel1: TBevel
    Left = 8
    Top = 296
    Width = 505
    Height = 17
    Shape = bsTopLine
  end
  object lblValue: TLabel
    Left = 248
    Top = 152
    Width = 76
    Height = 13
    Caption = #1047#1085#1072#1095#1077#1085#1080#1077', Hex:'
  end
  object lblInfo: TLabel
    Left = 248
    Top = 192
    Width = 257
    Height = 39
    Caption = 
      #1053#1086#1074#1086#1077' '#1079#1085#1072#1095#1077#1085#1080#1077' '#1092#1083#1072#1075#1086#1074' '#1074#1099#1095#1080#1089#1083#1103#1077#1090#1089#1103' '#1082#1072#1082' '#13#10#1083#1086#1075#1080#1095#1077#1089#1082#1072#1103' '#1086#1087#1077#1088#1072#1094#1080#1103' '#1048#1051#1048' ' +
      #1089#1086' '#1089#1090#1072#1088#1099#1084' '#1079#1085#1072#1095#1077#1085#1080#1077#1084'. '#13#10#1058#1086' '#1077#1089#1090#1100' '#1091#1089#1090#1072#1085#1086#1074#1083#1077#1085#1085#1099#1077' '#1073#1080#1090#1099' '#1089#1090#1077#1088#1077#1090#1100' '#1085#1077#1083#1100#1079#1103 +
      '.'
    WordWrap = True
  end
  object gbLockPage: TGroupBox
    Left = 8
    Top = 8
    Width = 505
    Height = 121
    Caption = #1041#1083#1086#1082#1080#1088#1086#1074#1082#1072' '#1089#1090#1088#1072#1085#1080#1094
    TabOrder = 0
    object chbLockPage16_19: TCheckBox
      Left = 16
      Top = 32
      Width = 57
      Height = 17
      Caption = '(16-19)'
      TabOrder = 0
      OnClick = chbLockPage16_19Click
    end
    object chbLockPage42: TCheckBox
      Left = 112
      Top = 72
      Width = 81
      Height = 17
      Caption = '42 (AUTH0)'
      TabOrder = 7
      OnClick = chbLockPage16_19Click
    end
    object chbLockPage41: TCheckBox
      Left = 16
      Top = 72
      Width = 81
      Height = 17
      Caption = '41 (COUNT)'
      TabOrder = 6
      OnClick = chbLockPage16_19Click
    end
    object chbLockPage20_23: TCheckBox
      Left = 112
      Top = 32
      Width = 57
      Height = 17
      Caption = '(20-23)'
      TabOrder = 1
      OnClick = chbLockPage16_19Click
    end
    object chbLockPage24_27: TCheckBox
      Left = 200
      Top = 32
      Width = 57
      Height = 17
      Caption = '(24-27)'
      TabOrder = 2
      OnClick = chbLockPage16_19Click
    end
    object chbLockPage28_31: TCheckBox
      Left = 288
      Top = 32
      Width = 57
      Height = 17
      Caption = '(28-31)'
      TabOrder = 3
      OnClick = chbLockPage16_19Click
    end
    object chbLockPage32_35: TCheckBox
      Left = 368
      Top = 32
      Width = 57
      Height = 17
      Caption = '(32-35)'
      TabOrder = 4
      OnClick = chbLockPage16_19Click
    end
    object chbLockPage36_39: TCheckBox
      Left = 440
      Top = 32
      Width = 57
      Height = 17
      Caption = '(36-39)'
      TabOrder = 5
      OnClick = chbLockPage16_19Click
    end
    object chbLockPage43: TCheckBox
      Left = 200
      Top = 72
      Width = 81
      Height = 17
      Caption = '43 (AUTH1)'
      TabOrder = 8
      OnClick = chbLockPage16_19Click
    end
    object chbLockPage44_47: TCheckBox
      Left = 288
      Top = 72
      Width = 89
      Height = 17
      Caption = '(44-47) ('#1050#1083#1102#1095')'
      TabOrder = 9
      OnClick = chbLockPage16_19Click
    end
  end
  object btnOK: TButton
    Left = 280
    Top = 304
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 8
  end
  object btnCancel: TButton
    Left = 360
    Top = 304
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 9
  end
  object edtValue: TEdit
    Left = 336
    Top = 152
    Width = 121
    Height = 21
    ReadOnly = True
    TabOrder = 7
  end
  object btnReset: TButton
    Left = 440
    Top = 304
    Width = 75
    Height = 25
    Caption = #1057#1073#1088#1086#1089#1080#1090#1100
    TabOrder = 10
    OnClick = btnResetClick
  end
  object chbLockBitKey: TCheckBox
    Left = 8
    Top = 152
    Width = 225
    Height = 17
    Caption = #1041#1083#1086#1082#1080#1088#1086#1074#1072#1090#1100' '#1083#1086#1082#1073#1080#1090' ('#1050#1083#1102#1095')'
    TabOrder = 1
    OnClick = chbLockPage16_19Click
  end
  object chbLockBitAuth1: TCheckBox
    Left = 8
    Top = 176
    Width = 225
    Height = 17
    Caption = #1041#1083#1086#1082#1080#1088#1086#1074#1072#1090#1100' '#1083#1086#1082#1073#1080#1090' (AUTH1)'
    TabOrder = 2
    OnClick = chbLockPage16_19Click
  end
  object chbLockBitAuth0: TCheckBox
    Left = 8
    Top = 200
    Width = 225
    Height = 17
    Caption = #1041#1083#1086#1082#1080#1088#1086#1074#1072#1090#1100' '#1083#1086#1082#1073#1080#1090' (AUTH0)'
    TabOrder = 3
    OnClick = chbLockPage16_19Click
  end
  object chbLockBitCount: TCheckBox
    Left = 8
    Top = 224
    Width = 225
    Height = 17
    Caption = #1041#1083#1086#1082#1080#1088#1086#1074#1072#1090#1100' '#1083#1086#1082#1073#1080#1090' (COUNT)'
    TabOrder = 4
    OnClick = chbLockPage16_19Click
  end
  object chbLOckBits5_7: TCheckBox
    Left = 8
    Top = 248
    Width = 225
    Height = 17
    Caption = #1041#1083#1086#1082#1080#1088#1086#1074#1072#1090#1100' '#1083#1086#1082#1073#1080#1090' (5-7)'
    TabOrder = 5
    OnClick = chbLockPage16_19Click
  end
  object chbLockBits1_3: TCheckBox
    Left = 8
    Top = 272
    Width = 225
    Height = 17
    Caption = #1041#1083#1086#1082#1080#1088#1086#1074#1072#1090#1100' '#1083#1086#1082#1073#1080#1090' (1-3)'
    TabOrder = 6
    OnClick = chbLockPage16_19Click
  end
end
