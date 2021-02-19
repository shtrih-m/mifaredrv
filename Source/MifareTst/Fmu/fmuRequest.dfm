object fmRequest: TfmRequest
  Left = 352
  Top = 256
  BorderStyle = bsSingle
  Caption = #1047#1072#1087#1088#1086#1089
  ClientHeight = 374
  ClientWidth = 414
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
  object lblATQ: TLabel
    Left = 8
    Top = 12
    Width = 25
    Height = 13
    Caption = 'ATQ:'
  end
  object lblBitCount: TLabel
    Left = 8
    Top = 132
    Width = 82
    Height = 13
    Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1073#1080#1090':'
  end
  object lblUIDHex2: TLabel
    Left = 8
    Top = 164
    Width = 84
    Height = 13
    Caption = #1060#1088#1072#1075#1084#1077#1085#1090', HEX:'
  end
  object lblUIDHex: TLabel
    Left = 8
    Top = 212
    Width = 99
    Height = 13
    Caption = #1053#1086#1084#1077#1088' '#1082#1072#1088#1090#1099', HEX:'
  end
  object Bevel1: TBevel
    Left = 8
    Top = 112
    Width = 402
    Height = 9
    Shape = bsTopLine
  end
  object lblSAK: TLabel
    Left = 8
    Top = 244
    Width = 24
    Height = 13
    Caption = 'SAK:'
  end
  object Bevel2: TBevel
    Left = 8
    Top = 192
    Width = 402
    Height = 9
    Shape = bsTopLine
  end
  object lblCardType: TLabel
    Left = 8
    Top = 44
    Width = 56
    Height = 13
    Caption = #1058#1080#1087' '#1082#1072#1088#1090#1099':'
  end
  object btnRequestAll: TButton
    Left = 192
    Top = 8
    Width = 217
    Height = 25
    Hint = 'RequestAll'
    Caption = #1047#1072#1087#1088#1086#1089#1080#1090#1100' '#1074#1089#1077' '#1082#1072#1088#1090#1099
    TabOrder = 0
    OnClick = btnRequestAllClick
  end
  object edtATQ: TEdit
    Left = 72
    Top = 8
    Width = 113
    Height = 21
    Hint = 'ATQ'
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 3
  end
  object btnRequestIdle: TButton
    Left = 192
    Top = 40
    Width = 217
    Height = 25
    Hint = 'RequestIdle'
    Caption = #1047#1072#1087#1088#1086#1089#1080#1090#1100' '#1082#1072#1088#1090#1099' '#1074' '#1088#1077#1078#1080#1084#1077' '#1086#1078#1080#1076#1072#1085#1080#1103
    TabOrder = 1
    OnClick = btnRequestIdleClick
  end
  object btnPiccHalt: TButton
    Left = 192
    Top = 72
    Width = 217
    Height = 25
    Hint = 'PiccHalt'
    Caption = #1054#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1082#1072#1088#1090#1091
    TabOrder = 2
    OnClick = btnPiccHaltClick
  end
  object edtUIDHex2: TEdit
    Left = 120
    Top = 160
    Width = 121
    Height = 21
    Hint = 'UIDHex'
    TabOrder = 6
  end
  object edtUIDHex: TEdit
    Left = 120
    Top = 208
    Width = 121
    Height = 21
    Hint = 'UIDHex'
    TabOrder = 8
  end
  object btnPiccAnticoll: TButton
    Left = 248
    Top = 128
    Width = 161
    Height = 25
    Hint = 'PiccAnticoll'
    Caption = #1040#1085#1090#1080#1082#1086#1083#1083#1080#1079#1080#1103
    TabOrder = 7
    OnClick = btnPiccAnticollClick
  end
  object btnPiccSelect: TButton
    Left = 248
    Top = 208
    Width = 161
    Height = 25
    Hint = 'PiccSelect'
    Caption = #1042#1099#1073#1086#1088' '#1082#1072#1088#1090#1099
    TabOrder = 10
    OnClick = btnPiccSelectClick
  end
  object edtSAK: TEdit
    Left = 120
    Top = 240
    Width = 121
    Height = 21
    Hint = 'SAK'
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 9
  end
  object edtCardType: TEdit
    Left = 72
    Top = 40
    Width = 113
    Height = 21
    Hint = 'CardType'
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 4
  end
  object seBitCount: TSpinEdit
    Left = 120
    Top = 128
    Width = 121
    Height = 22
    Hint = 'BitCount'
    MaxValue = 255
    MinValue = 0
    TabOrder = 5
    Value = 0
  end
end
