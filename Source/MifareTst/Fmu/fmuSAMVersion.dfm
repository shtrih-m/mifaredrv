object fmSAMVersion: TfmSAMVersion
  Left = 408
  Top = 397
  BorderStyle = bsSingle
  Caption = 'SAM '#1074#1077#1088#1089#1080#1103
  ClientHeight = 166
  ClientWidth = 376
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  ShowHint = True
  DesignSize = (
    376
    166)
  PixelsPerInch = 96
  TextHeight = 13
  object btnSAM_GetVersion: TButton
    Left = 232
    Top = 136
    Width = 137
    Height = 25
    Hint = 'SAM_GetVersion'
    Anchors = [akRight, akBottom]
    Caption = #1055#1086#1083#1091#1095#1080#1090#1100' '#1074#1077#1088#1089#1080#1102' SAM'
    TabOrder = 1
    OnClick = btnSAM_GetVersionClick
  end
  object Memo: TMemo
    Left = 8
    Top = 8
    Width = 361
    Height = 121
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 0
    WordWrap = False
  end
end
