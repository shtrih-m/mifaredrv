object fmAccessData: TfmAccessData
  Left = 430
  Top = 455
  BorderStyle = bsDialog
  Caption = 'Блок данных 0'
  ClientHeight = 270
  ClientWidth = 536
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
  object Bevel1: TBevel
    Left = 8
    Top = 232
    Width = 521
    Height = 17
    Shape = bsTopLine
  end
  object Grid: TStringGrid
    Left = 8
    Top = 8
    Width = 523
    Height = 193
    ColCount = 1
    DefaultRowHeight = 20
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
    TabOrder = 0
    OnDrawCell = GridDrawCell
  end
  object btnCancel: TButton
    Left = 456
    Top = 240
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Отмена'
    ModalResult = 2
    TabOrder = 1
  end
  object btnOK: TButton
    Left = 376
    Top = 240
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
end
