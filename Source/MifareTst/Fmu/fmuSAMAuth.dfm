object fmSAMAuth: TfmSAMAuth
  Left = 383
  Top = 223
  BorderStyle = bsSingle
  Caption = 'Mifare Plus SL1'
  ClientHeight = 340
  ClientWidth = 392
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
  object lblUIDHex: TLabel
    Left = 8
    Top = 292
    Width = 96
    Height = 13
    Caption = #1053#1086#1084#1077#1088' '#1082#1072#1088#1090#1099', Hex:'
  end
  object gsWriteKey: TGroupBox
    Left = 8
    Top = 8
    Width = 377
    Height = 145
    TabOrder = 0
    DesignSize = (
      377
      145)
    object lblKeyNumber: TLabel
      Left = 8
      Top = 20
      Width = 71
      Height = 13
      Caption = #1053#1086#1084#1077#1088' '#1082#1083#1102#1095#1072':'
    end
    object lblKeyA: TLabel
      Left = 8
      Top = 92
      Width = 99
      Height = 13
      Caption = #1050#1083#1102#1095' A, 6 '#1073#1072#1081#1090' Hex:'
    end
    object lblKeyPosition: TLabel
      Left = 8
      Top = 44
      Width = 81
      Height = 13
      Caption = #1055#1086#1079#1080#1094#1080#1103' '#1082#1083#1102#1095#1072':'
    end
    object lblKeyVersion: TLabel
      Left = 8
      Top = 68
      Width = 74
      Height = 13
      Caption = #1042#1077#1088#1089#1080#1103' '#1082#1083#1102#1095#1072':'
    end
    object lblKeyB: TLabel
      Left = 8
      Top = 116
      Width = 99
      Height = 13
      Caption = #1050#1083#1102#1095' B, 6 '#1073#1072#1081#1090' Hex:'
    end
    object btnWriteKey: TButton
      Left = 232
      Top = 16
      Width = 129
      Height = 25
      Hint = 'SAM_WriteKey'
      Anchors = [akTop, akRight]
      Caption = #1047#1072#1087#1080#1089#1072#1090#1100' '#1082#1083#1102#1095
      TabOrder = 2
      OnClick = btnWriteKeyClick
    end
    object edtKeyA: TEdit
      Left = 120
      Top = 88
      Width = 97
      Height = 21
      Hint = 'KeyA'
      Anchors = [akLeft, akTop, akRight]
      MaxLength = 12
      TabOrder = 0
      Text = 'FFFFFFFFFFFF'
    end
    object edtKeyB: TEdit
      Left = 120
      Top = 112
      Width = 97
      Height = 21
      Hint = 'KeyB'
      Anchors = [akLeft, akTop, akRight]
      MaxLength = 12
      TabOrder = 1
      Text = 'FFFFFFFFFFFF'
    end
    object seKeyNumber: TSpinEdit
      Left = 120
      Top = 16
      Width = 97
      Height = 22
      Hint = 'KeyNumber'
      Anchors = [akLeft, akTop, akRight]
      MaxValue = 255
      MinValue = 0
      TabOrder = 3
      Value = 0
    end
    object seKeyPosition: TSpinEdit
      Left = 120
      Top = 40
      Width = 97
      Height = 22
      Hint = 'KeyPosition'
      Anchors = [akLeft, akTop, akRight]
      MaxValue = 255
      MinValue = 0
      TabOrder = 4
      Value = 2
    end
    object seKeyVersion: TSpinEdit
      Left = 120
      Top = 64
      Width = 97
      Height = 22
      Hint = 'KeyVersion'
      Anchors = [akLeft, akTop, akRight]
      MaxValue = 255
      MinValue = 0
      TabOrder = 5
      Value = 3
    end
  end
  object gsKeyAuth: TGroupBox
    Left = 8
    Top = 160
    Width = 377
    Height = 121
    TabOrder = 1
    DesignSize = (
      377
      121)
    object Label1: TLabel
      Left = 8
      Top = 40
      Width = 71
      Height = 13
      Caption = #1053#1086#1084#1077#1088' '#1082#1083#1102#1095#1072':'
    end
    object Label3: TLabel
      Left = 8
      Top = 64
      Width = 74
      Height = 13
      Caption = #1042#1077#1088#1089#1080#1103' '#1082#1083#1102#1095#1072':'
    end
    object lblAuthKey: TLabel
      Left = 8
      Top = 18
      Width = 56
      Height = 13
      Caption = #1058#1080#1087' '#1082#1083#1102#1095#1072':'
    end
    object lblBlockNumber: TLabel
      Left = 8
      Top = 88
      Width = 70
      Height = 13
      Caption = #1053#1086#1084#1077#1088' '#1073#1083#1086#1082#1072':'
    end
    object btnSAM_AuthKey: TButton
      Left = 232
      Top = 16
      Width = 137
      Height = 25
      Hint = 'SAM_AuthKey'
      Anchors = [akTop, akRight]
      Caption = #1040#1074#1090#1086#1088#1080#1079#1072#1094#1080#1103' '#1087#1086' '#1082#1083#1102#1095#1091
      TabOrder = 5
      OnClick = btnSAM_AuthKeyClick
    end
    object rbKeyB: TRadioButton
      Left = 184
      Top = 16
      Width = 33
      Height = 17
      Hint = 'KeyType=ktKeyB'
      Caption = #1042
      TabOrder = 1
    end
    object rbKeyA: TRadioButton
      Left = 120
      Top = 16
      Width = 41
      Height = 17
      Hint = 'KeyType=ktKeyA'
      Caption = #1040
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object seKeyNumber2: TSpinEdit
      Left = 120
      Top = 40
      Width = 97
      Height = 22
      Hint = 'KeyNumber'
      Anchors = [akLeft, akTop, akRight]
      MaxValue = 255
      MinValue = 0
      TabOrder = 2
      Value = 0
    end
    object seKeyVersion2: TSpinEdit
      Left = 120
      Top = 64
      Width = 97
      Height = 22
      Hint = 'KeyVersion'
      Anchors = [akLeft, akTop, akRight]
      MaxValue = 255
      MinValue = 0
      TabOrder = 3
      Value = 3
    end
    object seBlockNumber: TSpinEdit
      Left = 120
      Top = 88
      Width = 97
      Height = 22
      Hint = 'BlockNumber'
      Anchors = [akLeft, akTop, akRight]
      MaxValue = 255
      MinValue = 0
      TabOrder = 4
      Value = 3
    end
  end
  object edtUIDHex: TEdit
    Left = 112
    Top = 288
    Width = 129
    Height = 21
    Hint = 'UIDHex'
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 2
    Text = '2697F0B9'
  end
  object btnPiccActivateWakeUp: TButton
    Left = 256
    Top = 288
    Width = 129
    Height = 25
    Hint = 'PiccActivateWakeUp'
    Caption = #1040#1082#1090#1080#1074#1072#1094#1080#1103' '#1082#1072#1088#1090#1099
    TabOrder = 3
    OnClick = btnPiccActivateWakeUpClick
  end
end
