object fmActivate: TfmActivate
  Left = 850
  Top = 506
  BorderStyle = bsSingle
  Caption = #1040#1082#1090#1080#1074#1072#1094#1080#1103
  ClientHeight = 393
  ClientWidth = 425
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
  object gsPoll: TGroupBox
    Left = 8
    Top = 216
    Width = 409
    Height = 161
    Caption = #1054#1087#1088#1086#1089
    TabOrder = 1
    DesignSize = (
      409
      161)
    object lblPoll: TLabel
      Left = 16
      Top = 40
      Width = 277
      Height = 39
      Caption = 
        #1054#1087#1088#1086#1089' '#1089#1095#1080#1090#1099#1074#1072#1090#1077#1083#1103' '#1087#1088#1086#1080#1079#1074#1086#1076#1080#1090#1089#1103' '#1089' '#1087#1077#1088#1080#1086#1076#1086#1084' 200 '#1084#1089'.'#13#10#1045#1089#1083#1080' '#1082#1072#1088#1090#1072' '#1085#1072 +
        #1081#1076#1077#1085#1072' - '#1082#1088#1091#1075' '#1089#1090#1072#1085#1077#1090' '#1079#1077#1083#1077#1085#1099#1084'.'#13#10#1045#1089#1083#1080' '#1082#1072#1088#1090#1072' '#1085#1077' '#1085#1072#1081#1076#1077#1085#1072' - '#1082#1088#1091#1075' '#1073#1091#1076#1077#1090 +
        ' '#1082#1088#1072#1089#1085#1099#1084'.'
    end
    object Shape: TShape
      Left = 336
      Top = 32
      Width = 41
      Height = 41
      Anchors = [akTop, akRight]
      Brush.Color = clRed
      Shape = stEllipse
    end
    object Label1: TLabel
      Left = 16
      Top = 96
      Width = 225
      Height = 26
      Caption = #1058#1077#1089#1090' '#1084#1086#1078#1085#1086' '#1080#1089#1087#1086#1083#1100#1079#1086#1074#1072#1090#1100' '#1076#1083#1103' '#1086#1087#1088#1077#1076#1077#1083#1077#1085#1080#1103#13#10#1076#1072#1083#1100#1085#1086#1089#1090#1080' '#1095#1090#1077#1085#1080#1103' '#1082#1072#1088#1090#1099'.'
      WordWrap = True
    end
    object btnStart: TButton
      Left = 296
      Top = 80
      Width = 97
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1053#1072#1095#1072#1090#1100
      TabOrder = 0
      OnClick = btnStartClick
    end
    object btnStop: TButton
      Left = 296
      Top = 112
      Width = 97
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1054#1089#1090#1072#1085#1086#1074#1080#1090#1100
      Enabled = False
      TabOrder = 1
      OnClick = btnStopClick
    end
  end
  object gsActivate: TGroupBox
    Left = 8
    Top = 8
    Width = 409
    Height = 201
    Caption = #1040#1082#1090#1080#1074#1072#1094#1080#1103
    TabOrder = 0
    DesignSize = (
      409
      201)
    object lblBaudRate: TLabel
      Left = 8
      Top = 36
      Width = 51
      Height = 13
      Caption = #1057#1082#1086#1088#1086#1089#1090#1100':'
    end
    object lblSAK: TLabel
      Left = 8
      Top = 84
      Width = 24
      Height = 13
      Caption = 'SAK:'
    end
    object lblATQ: TLabel
      Left = 8
      Top = 60
      Width = 25
      Height = 13
      Caption = 'ATQ:'
    end
    object lblUID: TLabel
      Left = 8
      Top = 108
      Width = 71
      Height = 13
      Caption = #1053#1086#1084#1077#1088' '#1082#1072#1088#1090#1099':'
    end
    object lblInfo: TLabel
      Left = 8
      Top = 168
      Width = 373
      Height = 13
      Anchors = [akLeft, akTop, akRight]
      Caption = 
        #1040#1082#1090#1080#1074#1072#1094#1080#1103' '#1082#1072#1088#1090' IDLE - '#1072#1082#1090#1080#1074#1072#1094#1080#1103' '#1082#1072#1088#1090', '#1085#1072#1093#1086#1076#1103#1097#1080#1093#1089#1103' '#1074' '#1088#1077#1078#1080#1084#1077' '#1086#1078#1080#1076#1072 +
        #1085#1080#1103
      WordWrap = True
    end
    object lblCardType: TLabel
      Left = 8
      Top = 132
      Width = 56
      Height = 13
      Caption = #1058#1080#1087' '#1082#1072#1088#1090#1099':'
    end
    object btnPiccActivateIdle: TButton
      Left = 232
      Top = 64
      Width = 161
      Height = 25
      Hint = 'PiccActivateIdle'
      Anchors = [akTop, akRight]
      Caption = #1040#1082#1090#1080#1074#1072#1094#1080#1103' '#1082#1072#1088#1090' IDLE'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = btnPiccActivateIdleClick
    end
    object cbBaudRate: TComboBox
      Left = 88
      Top = 32
      Width = 129
      Height = 21
      Hint = 'BaudRate'
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
    end
    object edtSAK: TEdit
      Left = 88
      Top = 80
      Width = 129
      Height = 21
      Hint = 'SAK'
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 4
    end
    object edtATQ: TEdit
      Left = 88
      Top = 56
      Width = 129
      Height = 21
      Hint = 'ATQ'
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 3
    end
    object edtUIDHex: TEdit
      Left = 88
      Top = 104
      Width = 129
      Height = 21
      Hint = 'UIDHex'
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 5
    end
    object btnPiccActivateWakeup: TButton
      Left = 232
      Top = 32
      Width = 161
      Height = 25
      Hint = 'PiccActivateWakeUp'
      Anchors = [akTop, akRight]
      Caption = #1040#1082#1090#1080#1074#1072#1094#1080#1103' '#1074#1089#1077#1093' '#1082#1072#1088#1090
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btnPiccActivateWakeupClick
    end
    object edtCardDescription: TEdit
      Left = 88
      Top = 128
      Width = 129
      Height = 21
      Hint = 'CardDescription'
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 6
    end
  end
  object Timer: TTimer
    Enabled = False
    Interval = 200
    OnTimer = TimerTimer
    Left = 16
    Top = 344
  end
end
