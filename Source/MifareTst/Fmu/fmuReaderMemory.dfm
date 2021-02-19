object fmReaderMemory: TfmReaderMemory
  Left = 388
  Top = 202
  BorderStyle = bsSingle
  Caption = #1057#1095#1080#1090#1099#1074#1072#1090#1077#1083#1100', EEPROM'
  ClientHeight = 152
  ClientWidth = 310
  Color = clBtnFace
  Constraints.MinHeight = 179
  Constraints.MinWidth = 318
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  ShowHint = True
  PixelsPerInch = 96
  TextHeight = 13
  object lblBlockNumber: TLabel
    Left = 8
    Top = 12
    Width = 70
    Height = 13
    Caption = #1053#1086#1084#1077#1088' '#1073#1083#1086#1082#1072':'
  end
  object lblBlockDataHex: TLabel
    Left = 8
    Top = 60
    Width = 77
    Height = 13
    Caption = #1044#1072#1085#1085#1099#1077' '#1073#1083#1086#1082#1072':'
  end
  object lblBlockLength: TLabel
    Left = 8
    Top = 36
    Width = 76
    Height = 13
    Caption = #1044#1083#1080#1085#1072' '#1076#1072#1085#1085#1099#1093':'
  end
  object btnPcdReadE2: TButton
    Left = 184
    Top = 88
    Width = 121
    Height = 25
    Hint = 'PcdReadE2'
    Caption = 'PcdReadE2'
    TabOrder = 3
    OnClick = btnPcdReadE2Click
  end
  object edtBlockDataHex: TEdit
    Left = 96
    Top = 56
    Width = 209
    Height = 21
    Hint = 'BlockDataHex'
    TabOrder = 2
  end
  object btnPcdWriteE2: TButton
    Left = 184
    Top = 120
    Width = 121
    Height = 25
    Hint = 'PcdWriteE2'
    Caption = 'PcdWriteE2'
    TabOrder = 4
    OnClick = btnPcdWriteE2Click
  end
  object seBlockNumber: TSpinEdit
    Left = 96
    Top = 8
    Width = 121
    Height = 22
    Hint = 'BlockNumber'
    MaxValue = 255
    MinValue = 0
    TabOrder = 0
    Value = 0
  end
  object seDataLength: TSpinEdit
    Left = 96
    Top = 32
    Width = 121
    Height = 22
    Hint = 'DataLength'
    MaxValue = 255
    MinValue = 0
    TabOrder = 1
    Value = 16
  end
end
