object fmCard: TfmCard
  Left = 403
  Top = 143
  Width = 463
  Height = 272
  BorderIcons = [biSystemMenu]
  Caption = 'Чтение карты'
  Color = clBtnFace
  Constraints.MinHeight = 235
  Constraints.MinWidth = 463
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object lblCardInfo: TLabel
    Left = 8
    Top = 8
    Width = 65
    Height = 13
    Caption = 'Тип карты: 1'
  end
  object Grid: TStringGrid
    Left = 8
    Top = 32
    Width = 361
    Height = 206
    Anchors = [akLeft, akTop, akRight, akBottom]
    ColCount = 2
    DefaultRowHeight = 20
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing, goAlwaysShowEditor]
    TabOrder = 0
  end
  object btnRead: TBitBtn
    Left = 376
    Top = 32
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Прочитать'
    TabOrder = 1
    OnClick = btnReadClick
  end
  object btnSave: TBitBtn
    Left = 376
    Top = 144
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Сохранить...'
    TabOrder = 4
    OnClick = btnSaveClick
  end
  object btnLoad: TBitBtn
    Left = 376
    Top = 176
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Загрузить...'
    TabOrder = 5
    OnClick = btnLoadClick
  end
  object btnWrite: TBitBtn
    Left = 376
    Top = 64
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Записать'
    TabOrder = 2
    OnClick = btnWriteClick
  end
  object btnClose: TBitBtn
    Left = 376
    Top = 213
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Закрыть'
    TabOrder = 6
    OnClick = btnCloseClick
  end
  object btnClear: TButton
    Left = 376
    Top = 96
    Width = 75
    Height = 25
    Caption = 'Очистить'
    TabOrder = 3
    OnClick = btnClearClick
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'txt'
    FileName = 'Карта'
    Filter = 'Файла карт (*.txt)|*.txt|Все файлы (*.*)|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 200
    Top = 136
  end
  object OpenDialog: TOpenDialog
    DefaultExt = 'txt'
    FileName = 'Карта'
    Filter = 'Файла карт (*.txt)|*.txt|Все файлы (*.*)|*.*'
    Left = 232
    Top = 136
  end
end
