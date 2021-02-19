object fmAnticoll: TfmAnticoll
  Left = 109
  Top = 190
  Width = 422
  Height = 390
  Caption = 'Антиколлизия'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblBitCount: TLabel
    Left = 8
    Top = 44
    Width = 82
    Height = 13
    Caption = 'Количество бит:'
  end
  object lblSerialFragment: TLabel
    Left = 8
    Top = 76
    Width = 84
    Height = 13
    Caption = 'Фрагмент, HEX:'
  end
  object lblSerialNumber: TLabel
    Left = 8
    Top = 108
    Width = 78
    Height = 13
    Caption = 'Полный номер:'
  end
  object lblSerialNumberHex: TLabel
    Left = 8
    Top = 140
    Width = 106
    Height = 13
    Caption = 'Полный номер, HEX:'
  end
  object lblSelCode: TLabel
    Left = 8
    Top = 12
    Width = 47
    Height = 13
    Caption = 'Уровень:'
  end
  object btnMf500PiccCascAnticoll: TButton
    Left = 248
    Top = 8
    Width = 161
    Height = 25
    Caption = 'Mf500PiccCascAnticoll'
    TabOrder = 5
    OnClick = btnMf500PiccCascAnticollClick
  end
  object edtBitCount: TEdit
    Left = 120
    Top = 40
    Width = 121
    Height = 21
    TabOrder = 1
    Text = '0'
  end
  object edtSerialFragment: TEdit
    Left = 120
    Top = 72
    Width = 121
    Height = 21
    TabOrder = 2
  end
  object edtSerialNumber: TEdit
    Left = 120
    Top = 104
    Width = 121
    Height = 21
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 3
  end
  object edtSerialNumberHex: TEdit
    Left = 120
    Top = 136
    Width = 121
    Height = 21
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 4
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
  object btnMf500PiccAnticoll: TButton
    Left = 248
    Top = 40
    Width = 161
    Height = 25
    Caption = 'Mf500PiccAnticoll'
    TabOrder = 6
    OnClick = btnMf500PiccAnticollClick
  end
end
