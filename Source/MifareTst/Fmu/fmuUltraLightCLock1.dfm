object fmUltraLightCLock1: TfmUltraLightCLock1
  Left = 389
  Top = 157
  BorderStyle = bsDialog
  Caption = #1041#1080#1090#1099' '#1073#1083#1086#1082#1080#1088#1086#1074#1082#1080', '#1089#1090#1088#1072#1085#1080#1094#1072' 2'
  ClientHeight = 391
  ClientWidth = 472
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  DesignSize = (
    472
    391)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 352
    Width = 457
    Height = 17
    Anchors = [akLeft, akRight, akBottom]
    Shape = bsTopLine
  end
  object lblValue: TLabel
    Left = 248
    Top = 320
    Width = 76
    Height = 13
    Anchors = [akRight, akBottom]
    Caption = #1047#1085#1072#1095#1077#1085#1080#1077', Hex:'
  end
  object ListView: TListView
    Left = 8
    Top = 8
    Width = 457
    Height = 305
    Anchors = [akLeft, akTop, akRight, akBottom]
    Checkboxes = True
    Columns = <
      item
        Caption = #1041#1080#1090
      end
      item
        AutoSize = True
        Caption = #1053#1072#1079#1074#1072#1085#1080#1077
      end>
    ColumnClick = False
    HideSelection = False
    Items.Data = {
      860100001000000000000000FFFFFFFFFFFFFFFF0100000000000000013015C1
      EBEEEAE8F0EEE2EAE020F1F2F0E0EDE8F6FB203400000000FFFFFFFFFFFFFFFF
      0000000000000000013100000000FFFFFFFFFFFFFFFF00000000000000000132
      00000000FFFFFFFFFFFFFFFF0000000000000000013300000000FFFFFFFFFFFF
      FFFF0000000000000000013400000000FFFFFFFFFFFFFFFF0000000000000000
      013500000000FFFFFFFFFFFFFFFF0000000000000000013600000000FFFFFFFF
      FFFFFFFF0000000000000000013700000000FFFFFFFFFFFFFFFF000000000000
      0000013800000000FFFFFFFFFFFFFFFF0000000000000000013900000000FFFF
      FFFFFFFFFFFF000000000000000002313000000000FFFFFFFFFFFFFFFF000000
      000000000002313100000000FFFFFFFFFFFFFFFF000000000000000002313200
      000000FFFFFFFFFFFFFFFF000000000000000002313300000000FFFFFFFFFFFF
      FFFF000000000000000002313400000000FFFFFFFFFFFFFFFF00000000000000
      00023135FFFF}
    ReadOnly = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
    OnChange = ListViewChange
  end
  object btnOK: TButton
    Left = 232
    Top = 360
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 312
    Top = 360
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 2
  end
  object btnReset: TButton
    Left = 392
    Top = 360
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1057#1073#1088#1086#1089#1080#1090#1100
    TabOrder = 3
    OnClick = btnResetClick
  end
  object edtValue: TEdit
    Left = 344
    Top = 320
    Width = 121
    Height = 21
    Anchors = [akRight, akBottom]
    ReadOnly = True
    TabOrder = 4
  end
end
