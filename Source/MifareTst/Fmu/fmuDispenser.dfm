object fmDispenser: TfmDispenser
  Left = 581
  Top = 197
  BorderStyle = bsSingle
  Caption = #1044#1080#1089#1087#1077#1085#1089#1077#1088
  ClientHeight = 287
  ClientWidth = 390
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  ShowHint = True
  PixelsPerInch = 96
  TextHeight = 13
  object btnEnableCardAccept: TButton
    Left = 72
    Top = 192
    Width = 155
    Height = 25
    Hint = 'EnableCardAccept'
    Caption = #1056#1072#1079#1088#1077#1096#1080#1090#1100' '#1087#1088#1080#1077#1084' '#1082#1072#1088#1090
    TabOrder = 1
    OnClick = btnEnableCardAcceptClick
  end
  object btnDisableCardAccept: TButton
    Left = 72
    Top = 224
    Width = 155
    Height = 25
    Hint = 'DisableCardAccept'
    Caption = #1047#1072#1087#1088#1077#1090#1080#1090#1100' '#1087#1088#1080#1077#1084' '#1082#1072#1088#1090
    TabOrder = 2
    OnClick = btnDisableCardAcceptClick
  end
  object btnReadStatus: TButton
    Left = 72
    Top = 256
    Width = 155
    Height = 25
    Hint = 'ReadStatus'
    Caption = #1047#1072#1087#1088#1086#1089#1080#1090#1100' '#1089#1090#1072#1090#1091#1089
    TabOrder = 3
    OnClick = btnReadStatusClick
  end
  object btnHoldCard: TButton
    Left = 232
    Top = 224
    Width = 155
    Height = 25
    Hint = 'HoldCard'
    Caption = #1047#1072#1093#1074#1072#1090#1080#1090#1100' '#1082#1072#1088#1090#1091
    TabOrder = 5
    OnClick = btnHoldCardClick
  end
  object btnReadLastAnswer: TButton
    Left = 232
    Top = 256
    Width = 155
    Height = 25
    Hint = 'ReadLastAnswer'
    Caption = #1055#1086#1083#1091#1095#1080#1090#1100' '#1086#1090#1074#1077#1090
    TabOrder = 6
    OnClick = btnReadLastAnswerClick
  end
  object btnIssueCard: TButton
    Left = 232
    Top = 192
    Width = 155
    Height = 25
    Hint = 'IssueCard'
    Caption = #1042#1099#1076#1072#1090#1100' '#1082#1072#1088#1090#1091
    TabOrder = 4
    OnClick = btnIssueCardClick
  end
  object memData: TMemo
    Left = 8
    Top = 8
    Width = 377
    Height = 177
    ScrollBars = ssVertical
    TabOrder = 0
  end
end
