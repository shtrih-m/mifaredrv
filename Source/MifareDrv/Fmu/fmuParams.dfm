object fmParams: TfmParams
  Left = 418
  Top = 234
  ActiveControl = btnOK
  AutoScroll = False
  BorderIcons = [biSystemMenu]
  Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1099
  ClientHeight = 344
  ClientWidth = 471
  Color = clBtnFace
  Constraints.MinHeight = 362
  Constraints.MinWidth = 463
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    471
    344)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TTntBevel
    Left = 8
    Top = 306
    Width = 458
    Height = 17
    Anchors = [akLeft, akRight, akBottom]
    Shape = bsTopLine
  end
  object btnOK: TTntButton
    Left = 310
    Top = 314
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    TabOrder = 2
    OnClick = btnOKClick
  end
  object btnCancel: TTntButton
    Left = 390
    Top = 314
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 3
  end
  object ListBox: TTntListBox
    Left = 8
    Top = 6
    Width = 121
    Height = 293
    Anchors = [akLeft, akTop, akBottom]
    ItemHeight = 13
    TabOrder = 0
    OnClick = ListBoxClick
  end
  object pnlData: TTntPanel
    Left = 134
    Top = 0
    Width = 339
    Height = 305
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    TabOrder = 1
  end
  object btnSetDefault: TTntButton
    Left = 8
    Top = 314
    Width = 97
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = #1055#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
    TabOrder = 4
    OnClick = btnSetDefaultClick
  end
end
