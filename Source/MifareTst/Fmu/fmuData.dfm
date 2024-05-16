object fmData: TfmData
  Left = 618
  Top = 304
  BorderStyle = bsSingle
  Caption = #1044#1072#1085#1085#1099#1077
  ClientHeight = 292
  ClientWidth = 376
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  ShowHint = True
  DesignSize = (
    376
    292)
  PixelsPerInch = 96
  TextHeight = 13
  object lblBBlock: TLabel
    Left = 8
    Top = 12
    Width = 70
    Height = 13
    Caption = #1053#1086#1084#1077#1088' '#1073#1083#1086#1082#1072':'
  end
  object lblBlockDataHex: TLabel
    Left = 8
    Top = 52
    Width = 69
    Height = 13
    Caption = #1044#1072#1085#1085#1099#1077', Hex:'
  end
  object lblData: TLabel
    Left = 8
    Top = 108
    Width = 44
    Height = 13
    Caption = #1044#1072#1085#1085#1099#1077':'
  end
  object Bevel1: TBevel
    Left = 8
    Top = 40
    Width = 361
    Height = 41
    Anchors = [akLeft, akTop, akRight]
    Shape = bsTopLine
  end
  object Bevel2: TBevel
    Left = 7
    Top = 96
    Width = 361
    Height = 41
    Anchors = [akLeft, akTop, akRight]
    Shape = bsTopLine
  end
  object edtBlockDataHex: TEdit
    Left = 96
    Top = 48
    Width = 177
    Height = 21
    Hint = 'BlockDataHex'
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
  end
  object btnPiccRead: TButton
    Left = 280
    Top = 8
    Width = 89
    Height = 25
    Hint = 'PiccRead'
    Anchors = [akTop, akRight]
    Caption = #1055#1088#1086#1095#1080#1090#1072#1090#1100
    TabOrder = 0
    OnClick = btnPiccReadClick
  end
  object btnPiccWrite: TButton
    Left = 280
    Top = 48
    Width = 89
    Height = 25
    Hint = 'PiccWrite'
    Anchors = [akTop, akRight]
    Caption = #1047#1072#1087#1080#1089#1072#1090#1100' Hex'
    TabOrder = 2
    OnClick = btnPiccWriteClick
  end
  object edtBlockData: TEdit
    Left = 96
    Top = 104
    Width = 177
    Height = 21
    Hint = 'BlockData'
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 3
  end
  object btnWrite: TButton
    Left = 280
    Top = 104
    Width = 89
    Height = 25
    Hint = 'PiccWrite'
    Anchors = [akTop, akRight]
    Caption = #1047#1072#1087#1080#1089#1072#1090#1100
    TabOrder = 4
    OnClick = btnWriteClick
  end
  object seBlockNumber: TSpinEdit
    Left = 95
    Top = 8
    Width = 185
    Height = 22
    Hint = 'BlockNumber'
    Anchors = [akLeft, akTop, akRight]
    MaxValue = 255
    MinValue = 0
    TabOrder = 5
    Value = 0
  end
end
