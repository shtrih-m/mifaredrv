object fmFirm: TfmFirm
  Left = 380
  Top = 232
  BorderStyle = bsDialog
  Caption = #1060#1080#1088#1084#1072
  ClientHeight = 192
  ClientWidth = 296
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lblCode: TLabel
    Left = 16
    Top = 20
    Width = 47
    Height = 13
    Caption = #1050#1086#1076', Hex:'
  end
  object lblText: TLabel
    Left = 16
    Top = 60
    Width = 53
    Height = 13
    Caption = #1053#1072#1079#1074#1072#1085#1080#1077':'
  end
  object Bevel1: TBevel
    Left = 8
    Top = 152
    Width = 281
    Height = 17
    Shape = bsTopLine
  end
  object edtCode: TEdit
    Left = 88
    Top = 16
    Width = 201
    Height = 21
    TabOrder = 0
    Text = '10'
  end
  object edtName: TEdit
    Left = 88
    Top = 56
    Width = 201
    Height = 21
    TabOrder = 1
    Text = '10'
  end
  object btnOK: TButton
    Left = 136
    Top = 160
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 2
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 216
    Top = 160
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 3
  end
end
