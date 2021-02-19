object fmDataRW: TfmDataRW
  Left = 512
  Top = 189
  BorderStyle = bsSingle
  Caption = #1054#1087#1077#1088#1072#1094#1080#1080' '#1089' '#1073#1083#1086#1082#1086#1084
  ClientHeight = 336
  ClientWidth = 342
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    342
    336)
  PixelsPerInch = 96
  TextHeight = 13
  object btnRead: TButton
    Left = 224
    Top = 16
    Width = 113
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #1055#1088#1086#1095#1080#1090#1072#1090#1100
    TabOrder = 0
    OnClick = btnReadClick
  end
  object btnWrite: TButton
    Left = 224
    Top = 48
    Width = 113
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #1047#1072#1087#1080#1089#1072#1090#1100
    TabOrder = 1
    OnClick = btnWriteHexClick
  end
end
