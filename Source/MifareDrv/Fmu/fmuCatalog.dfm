object fmCatalog: TfmCatalog
  Left = 655
  Top = 485
  BorderStyle = bsDialog
  Caption = #1050#1072#1090#1072#1083#1086#1075
  ClientHeight = 334
  ClientWidth = 375
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Grid: TStringGrid
    Left = 8
    Top = 8
    Width = 281
    Height = 288
    ColCount = 3
    DefaultRowHeight = 18
    RowCount = 15
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goAlwaysShowEditor]
    TabOrder = 0
  end
  object btnClose: TButton
    Left = 296
    Top = 304
    Width = 75
    Height = 25
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 3
    OnClick = btnCloseClick
  end
  object btnRead: TButton
    Left = 296
    Top = 8
    Width = 75
    Height = 25
    Caption = #1055#1088#1086#1095#1080#1090#1072#1090#1100
    TabOrder = 1
    OnClick = btnReadClick
  end
  object btnSave: TButton
    Left = 296
    Top = 40
    Width = 75
    Height = 25
    Caption = #1047#1072#1087#1080#1089#1072#1090#1100
    TabOrder = 2
    OnClick = btnSaveClick
  end
  object edtStatus: TEdit
    Left = 8
    Top = 304
    Width = 281
    Height = 21
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 4
  end
  object btnDelete: TButton
    Left = 296
    Top = 112
    Width = 75
    Height = 25
    Caption = #1059#1076#1072#1083#1080#1090#1100
    TabOrder = 5
    OnClick = btnDeleteClick
  end
  object btnClear: TButton
    Left = 296
    Top = 80
    Width = 75
    Height = 25
    Caption = #1054#1095#1080#1089#1090#1080#1090#1100
    TabOrder = 6
    OnClick = btnClearClick
  end
  object btnFirms: TButton
    Left = 296
    Top = 144
    Width = 75
    Height = 25
    Caption = #1060#1080#1088#1084#1099'...'
    TabOrder = 7
    OnClick = btnFirmsClick
  end
end
