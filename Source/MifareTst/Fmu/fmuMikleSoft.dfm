object fmMikleSoft: TfmMikleSoft
  Left = 411
  Top = 258
  Width = 385
  Height = 324
  Caption = 'MikleSoft'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  ShowHint = True
  DesignSize = (
    369
    286)
  PixelsPerInch = 96
  TextHeight = 13
  object lblATQ: TLabel
    Left = 8
    Top = 36
    Width = 25
    Height = 13
    Caption = 'ATQ:'
  end
  object lblUID: TLabel
    Left = 8
    Top = 60
    Width = 71
    Height = 13
    Caption = #1053#1086#1084#1077#1088' '#1082#1072#1088#1090#1099':'
  end
  object lblCardATQ: TLabel
    Left = 8
    Top = 12
    Width = 81
    Height = 13
    Caption = #1058#1080#1087' '#1082#1072#1088#1090#1099', Hex:'
  end
  object Bevel1: TBevel
    Left = 8
    Top = 88
    Width = 353
    Height = 17
    Anchors = [akLeft, akTop, akRight]
    Shape = bsTopLine
  end
  object edtATQ: TEdit
    Left = 96
    Top = 32
    Width = 121
    Height = 21
    Hint = 'ATQ'
    Anchors = [akLeft, akTop, akRight]
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 1
  end
  object btnMksFindCard: TButton
    Left = 224
    Top = 8
    Width = 137
    Height = 25
    Hint = 'MksFindCard'
    Anchors = [akTop, akRight]
    Caption = 'MksFindCard'
    TabOrder = 3
    OnClick = btnMksFindCardClick
  end
  object edtUIDHex: TEdit
    Left = 96
    Top = 56
    Width = 121
    Height = 21
    Hint = 'UIDHex'
    Anchors = [akLeft, akTop, akRight]
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 2
  end
  object edtCardATQ: TEdit
    Left = 96
    Top = 8
    Width = 121
    Height = 21
    Hint = 'CardATQ'
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
    Text = '0'
  end
  object btnMksReopen: TButton
    Left = 224
    Top = 40
    Width = 137
    Height = 25
    Hint = 'MksReopen'
    Anchors = [akTop, akRight]
    Caption = 'MksReopen'
    TabOrder = 4
    OnClick = btnMksReopenClick
  end
  object btnMksWriteCatalog: TButton
    Left = 224
    Top = 128
    Width = 137
    Height = 25
    Hint = 'MksWriteCatalog'
    Anchors = [akTop, akRight]
    Caption = 'MksWriteCatalog'
    TabOrder = 7
    OnClick = btnMksWriteCatalogClick
  end
  object btnMksReadCatalog: TButton
    Left = 224
    Top = 96
    Width = 137
    Height = 25
    Hint = 'MksReadCatalog'
    Anchors = [akTop, akRight]
    Caption = 'MksReadCatalog'
    TabOrder = 6
    OnClick = btnMksReadCatalogClick
  end
  object Memo: TMemo
    Left = 8
    Top = 96
    Width = 209
    Height = 185
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 5
  end
end
