object fmFirmCode: TfmFirmCode
  Left = 284
  Top = 274
  Width = 375
  Height = 217
  Caption = 'Коды фирм'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btnAdd: TButton
    Left = 288
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Добавить...'
    TabOrder = 0
  end
  object btnDelete: TButton
    Left = 288
    Top = 40
    Width = 75
    Height = 25
    Caption = 'Удалить'
    TabOrder = 1
  end
  object ListView1: TListView
    Left = 8
    Top = 8
    Width = 273
    Height = 177
    Columns = <
      item
        Caption = 'Код'
      end
      item
        AutoSize = True
        Caption = 'Название'
      end>
    ColumnClick = False
    HideSelection = False
    ReadOnly = True
    RowSelect = True
    TabOrder = 2
    ViewStyle = vsReport
  end
  object btnClose: TButton
    Left = 288
    Top = 160
    Width = 75
    Height = 25
    Caption = 'Закрыть'
    TabOrder = 3
  end
  object btnEdit: TButton
    Left = 288
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Изменить...'
    TabOrder = 4
  end
end
