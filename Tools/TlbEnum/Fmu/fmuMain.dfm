object fmMain: TfmMain
  Left = 287
  Top = 189
  Width = 487
  Height = 273
  Anchors = [akLeft]
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Редактирование TLB'
  Color = clBtnFace
  Constraints.MinHeight = 273
  Constraints.MinWidth = 487
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lblStartID: TLabel
    Left = 8
    Top = 12
    Width = 102
    Height = 13
    Caption = 'Начальный ID, HEX:'
  end
  object Memo: TMemo
    Left = 8
    Top = 40
    Width = 385
    Height = 201
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssBoth
    TabOrder = 0
    WordWrap = False
  end
  object btnConvert: TButton
    Left = 400
    Top = 40
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Convert'
    TabOrder = 1
    OnClick = btnConvertClick
  end
  object btnClose: TButton
    Left = 400
    Top = 72
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Закрыть'
    TabOrder = 2
    OnClick = btnCloseClick
  end
  object edtStartID: TEdit
    Left = 120
    Top = 8
    Width = 121
    Height = 21
    TabOrder = 3
    Text = '0'
  end
end
