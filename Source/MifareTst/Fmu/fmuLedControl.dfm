object fmLedControl: TfmLedControl
  Left = 383
  Top = 205
  BorderStyle = bsSingle
  Caption = #1057#1074#1077#1090#1086#1076#1080#1086#1076#1099
  ClientHeight = 272
  ClientWidth = 495
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
  object gsLeds: TGroupBox
    Left = 8
    Top = 8
    Width = 425
    Height = 193
    Caption = #1057#1074#1077#1090#1086#1076#1080#1086#1076#1099
    TabOrder = 0
    object lblBS: TLabel
      Left = 16
      Top = 144
      Width = 96
      Height = 13
      Caption = #1057#1086#1089#1090#1086#1103#1085#1080#1077' '#1082#1085#1086#1087#1082#1080':'
    end
    object chkRedLED: TCheckBox
      Left = 16
      Top = 64
      Width = 97
      Height = 17
      Hint = 'RedLED'
      Caption = #1050#1088#1072#1089#1085#1099#1081
      TabOrder = 0
    end
    object chkGreenLED: TCheckBox
      Left = 16
      Top = 40
      Width = 97
      Height = 17
      Hint = 'GreenLED'
      Caption = #1047#1077#1083#1077#1085#1099#1081
      TabOrder = 1
    end
    object chkBlueLED: TCheckBox
      Left = 16
      Top = 88
      Width = 89
      Height = 17
      Hint = 'BlueLED'
      Caption = #1057#1080#1085#1080#1081
      TabOrder = 2
    end
    object btnPcdControlLEDAndPoll: TButton
      Left = 136
      Top = 40
      Width = 225
      Height = 25
      Hint = 'PcdControlLEDAndPoll'
      Caption = #1047#1072#1078#1077#1095#1100' '#1089#1074#1077#1090#1086#1076#1080#1086#1076#1099' / '#1057#1086#1089#1090#1086#1103#1085#1080#1077' '#1082#1085#1086#1087#1082#1080
      TabOrder = 3
      OnClick = btnPcdControlLEDAndPollClick
    end
    object edtButtonState: TEdit
      Left = 136
      Top = 140
      Width = 225
      Height = 21
      Hint = 'ButtonState'
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 4
    end
    object btnPcdControlLED: TButton
      Left = 136
      Top = 72
      Width = 225
      Height = 25
      Hint = 'PcdControlLED'
      Caption = #1047#1072#1078#1077#1095#1100' '#1089#1074#1077#1090#1086#1076#1080#1086#1076#1099
      TabOrder = 5
      OnClick = btnPcdControlLEDClick
    end
    object btnPcdPollButton: TButton
      Left = 136
      Top = 104
      Width = 225
      Height = 25
      Hint = 'PcdPollButton'
      Caption = #1047#1072#1087#1088#1086#1089#1080#1090#1100' '#1089#1086#1089#1090#1086#1103#1085#1080#1077' '#1082#1085#1086#1087#1082#1080
      TabOrder = 6
      OnClick = btnPcdPollButtonClick
    end
    object chkYellowLED: TCheckBox
      Left = 16
      Top = 112
      Width = 89
      Height = 17
      Hint = 'YellowLED'
      Caption = #1046#1077#1083#1090#1099#1081
      TabOrder = 7
    end
  end
end
