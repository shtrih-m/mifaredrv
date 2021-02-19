object fmSelect: TfmSelect
  Left = 309
  Top = 238
  Width = 422
  Height = 390
  Caption = 'Выбор'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblSerialNumber: TLabel
    Left = 8
    Top = 44
    Width = 71
    Height = 13
    Caption = 'Номер карты:'
  end
  object lblSAK: TLabel
    Left = 8
    Top = 76
    Width = 24
    Height = 13
    Caption = 'SAK:'
  end
  object lblSelCode: TLabel
    Left = 8
    Top = 12
    Width = 47
    Height = 13
    Caption = 'Уровень:'
  end
  object Mf500PiccCascSelect: TButton
    Left = 248
    Top = 8
    Width = 161
    Height = 25
    Caption = 'Mf500PiccCascSelect'
    TabOrder = 3
    OnClick = Mf500PiccCascSelectClick
  end
  object edtSerialNumber: TEdit
    Left = 96
    Top = 40
    Width = 145
    Height = 21
    TabOrder = 1
  end
  object edtSAK: TEdit
    Left = 96
    Top = 72
    Width = 145
    Height = 21
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 2
  end
  object cbSelCode: TComboBox
    Left = 64
    Top = 8
    Width = 177
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
  end
  object Mf500PiccSelect: TButton
    Left = 248
    Top = 40
    Width = 161
    Height = 25
    Caption = 'Mf500PiccSelect'
    TabOrder = 4
    OnClick = Mf500PiccSelectClick
  end
end
