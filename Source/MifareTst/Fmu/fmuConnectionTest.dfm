object fmConnectionTest: TfmConnectionTest
  Left = 343
  Top = 193
  Width = 496
  Height = 401
  Caption = #1055#1088#1086#1074#1077#1088#1082#1072' '#1089#1074#1103#1079#1080
  Color = clBtnFace
  Constraints.MinHeight = 245
  Constraints.MinWidth = 327
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 401
    Height = 225
    Caption = #1055#1088#1086#1074#1077#1088#1082#1072' '#1089#1074#1103#1079#1080
    TabOrder = 0
    DesignSize = (
      401
      225)
    object lblRepCount2: TLabel
      Left = 16
      Top = 32
      Width = 112
      Height = 13
      Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1087#1086#1074#1090#1086#1088#1086#1074':'
    end
    object lblRepCount: TLabel
      Left = 144
      Top = 32
      Width = 6
      Height = 13
      Caption = '0'
    end
    object lblErrCount2: TLabel
      Left = 16
      Top = 56
      Width = 103
      Height = 13
      Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1086#1096#1080#1073#1086#1082':'
    end
    object lblErrCount: TLabel
      Left = 144
      Top = 56
      Width = 6
      Height = 13
      Caption = '0'
    end
    object lblSpeed: TLabel
      Left = 16
      Top = 80
      Width = 106
      Height = 13
      Caption = #1057#1082#1086#1088#1086#1089#1090#1100', '#1082#1086#1084#1072#1085#1076'/c:'
    end
    object lblTxSpeed: TLabel
      Left = 144
      Top = 80
      Width = 6
      Height = 13
      Caption = '0'
    end
    object lblExecTime2: TLabel
      Left = 16
      Top = 104
      Width = 108
      Height = 13
      Caption = #1042#1088#1077#1084#1103' '#1082#1086#1084#1072#1085#1076#1099', '#1084#1089'.:'
    end
    object lblExecTime: TLabel
      Left = 144
      Top = 104
      Width = 6
      Height = 13
      Caption = '0'
    end
    object lblErrRate2: TLabel
      Left = 16
      Top = 128
      Width = 87
      Height = 13
      Caption = #1055#1088#1086#1094#1077#1085#1090' '#1086#1096#1080#1073#1086#1082':'
    end
    object lblErrRate: TLabel
      Left = 144
      Top = 128
      Width = 6
      Height = 13
      Caption = '0'
    end
    object lblTimeLeft2: TLabel
      Left = 16
      Top = 152
      Width = 108
      Height = 13
      Caption = #1042#1088#1077#1084#1103' '#1090#1077#1089#1090#1072', '#1089#1077#1082#1091#1085#1076':'
    end
    object lblTimeLeft: TLabel
      Left = 144
      Top = 152
      Width = 6
      Height = 13
      Caption = '0'
    end
    object btnStart: TButton
      Left = 296
      Top = 24
      Width = 97
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1053#1072#1095#1072#1090#1100
      TabOrder = 0
      OnClick = btnStartClick
    end
    object btnStop: TButton
      Left = 296
      Top = 56
      Width = 97
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1054#1089#1090#1072#1085#1086#1074#1080#1090#1100
      TabOrder = 1
      OnClick = btnStopClick
    end
    object chbStopOnError: TCheckBox
      Left = 16
      Top = 192
      Width = 177
      Height = 17
      Caption = #1054#1089#1090#1072#1085#1086#1074#1082#1072' '#1087#1088#1080' '#1086#1096#1080#1073#1082#1077
      TabOrder = 2
    end
  end
end
