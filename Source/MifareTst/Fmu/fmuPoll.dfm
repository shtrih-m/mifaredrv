object fmPoll: TfmPoll
  Left = 521
  Top = 337
  Width = 428
  Height = 271
  Caption = #1054#1087#1088#1086#1089' '#1082#1072#1088#1090
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  ShowHint = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblPortNumber: TLabel
    Left = 8
    Top = 152
    Width = 69
    Height = 13
    Caption = #1053#1086#1084#1077#1088' '#1087#1086#1088#1090#1072':'
  end
  object Memo: TMemo
    Left = 8
    Top = 8
    Width = 393
    Height = 137
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object btnPollStart: TButton
    Left = 200
    Top = 152
    Width = 97
    Height = 25
    Hint = 'PollStart'
    Caption = #1053#1072#1095#1072#1090#1100' '#1086#1087#1088#1086#1089
    TabOrder = 3
    OnClick = btnPollStartClick
  end
  object btnPollStop: TButton
    Left = 304
    Top = 152
    Width = 97
    Height = 25
    Hint = 'PollStop'
    Caption = #1055#1088#1077#1088#1074#1072#1090#1100' '#1086#1087#1088#1086#1089
    TabOrder = 4
    OnClick = btnPollStopClick
  end
  object btnClear: TButton
    Left = 304
    Top = 184
    Width = 97
    Height = 25
    Caption = #1054#1095#1080#1089#1090#1080#1090#1100
    TabOrder = 5
    OnClick = btnClearClick
  end
  object cbPortNumber: TComboBox
    Left = 88
    Top = 152
    Width = 105
    Height = 21
    Hint = 'PortNumber'
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 1
  end
  object chbPollAutoDisable: TCheckBox
    Left = 8
    Top = 184
    Width = 185
    Height = 17
    Caption = #1040#1074#1090#1086#1086#1090#1082#1083#1102#1095#1077#1085#1080#1077' '#1086#1087#1088#1086#1089#1072
    TabOrder = 2
  end
end
