object fmConnection: TfmConnection
  Left = 447
  Top = 166
  BorderStyle = bsSingle
  Caption = #1057#1074#1103#1079#1100
  ClientHeight = 326
  ClientWidth = 379
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
  object gsConnection: TGroupBox
    Left = 8
    Top = 8
    Width = 337
    Height = 281
    Caption = #1055#1086#1076#1082#1083#1102#1095#1077#1085#1080#1077
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    object lblComPort: TLabel
      Left = 8
      Top = 44
      Width = 28
      Height = 13
      Caption = #1055#1086#1088#1090':'
    end
    object lblPcdConfig: TLabel
      Left = 8
      Top = 216
      Width = 249
      Height = 13
      Caption = #1047#1072#1087#1080#1089#1100' '#1074' '#1089#1095#1080#1090#1099#1074#1072#1090#1077#1083#1100' '#1085#1077#1086#1073#1093#1086#1076#1080#1084#1099#1093' '#1087#1072#1088#1072#1084#1077#1090#1088#1086#1074
    end
    object Bevel1: TBevel
      Left = 8
      Top = 184
      Width = 313
      Height = 25
      Shape = bsTopLine
    end
    object btnPcdConfig: TButton
      Left = 168
      Top = 240
      Width = 153
      Height = 25
      Hint = 'PcdConfig'
      Caption = #1050#1086#1085#1092#1080#1075#1091#1088#1072#1094#1080#1103
      TabOrder = 5
      OnClick = btnPcdConfigClick
    end
    object btnOpenPort: TButton
      Left = 168
      Top = 104
      Width = 153
      Height = 25
      Hint = 'OpenPort'
      Caption = #1054#1090#1082#1088#1099#1090#1100' '#1087#1086#1088#1090
      TabOrder = 3
      OnClick = btnOpenPortClick
    end
    object btnClosePort: TButton
      Left = 168
      Top = 136
      Width = 153
      Height = 25
      Hint = 'ClosePort'
      Caption = #1047#1072#1082#1088#1099#1090#1100' '#1087#1086#1088#1090
      TabOrder = 4
      OnClick = btnClosePortClick
    end
    object cbPortNumber: TComboBox
      Left = 48
      Top = 40
      Width = 113
      Height = 21
      Hint = 'PortNumber'
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
    end
    object btnConnect: TButton
      Left = 168
      Top = 40
      Width = 153
      Height = 25
      Hint = 'Connect'
      Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1089#1086#1077#1076#1080#1085#1077#1085#1080#1077
      TabOrder = 1
      OnClick = btnConnectClick
    end
    object btnDisconnect: TButton
      Left = 168
      Top = 72
      Width = 153
      Height = 25
      Hint = 'Disconnect'
      Caption = #1056#1072#1079#1086#1088#1074#1072#1090#1100' '#1089#1086#1077#1076#1080#1085#1077#1085#1080#1077
      TabOrder = 2
      OnClick = btnDisconnectClick
    end
  end
end
