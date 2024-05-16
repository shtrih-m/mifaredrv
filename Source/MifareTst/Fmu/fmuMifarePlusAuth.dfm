object fmMifarePlusAuth: TfmMifarePlusAuth
  Left = 563
  Top = 196
  BorderStyle = bsSingle
  Caption = 'MIFARE Plus '#1072#1074#1090#1086#1088#1080#1079#1072#1094#1080#1103
  ClientHeight = 444
  ClientWidth = 424
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  ShowHint = True
  OnCreate = FormCreate
  DesignSize = (
    424
    444)
  PixelsPerInch = 96
  TextHeight = 13
  object gbAuth: TGroupBox
    Left = 8
    Top = 8
    Width = 409
    Height = 177
    Anchors = [akLeft, akTop, akRight]
    Caption = #1040#1074#1090#1086#1088#1080#1079#1072#1094#1080#1103' AES'
    TabOrder = 0
    DesignSize = (
      409
      177)
    object lblKeyNumber: TLabel
      Left = 8
      Top = 104
      Width = 71
      Height = 13
      Caption = #1053#1086#1084#1077#1088' '#1082#1083#1102#1095#1072':'
    end
    object Label1: TLabel
      Left = 8
      Top = 80
      Width = 70
      Height = 13
      Caption = #1053#1086#1084#1077#1088' '#1073#1083#1086#1082#1072':'
    end
    object lblKeyVersion: TLabel
      Left = 8
      Top = 128
      Width = 74
      Height = 13
      Caption = #1042#1077#1088#1089#1080#1103' '#1082#1083#1102#1095#1072':'
    end
    object lblAuthType: TLabel
      Left = 8
      Top = 32
      Width = 108
      Height = 13
      Caption = #1058#1080#1087' '#1072#1091#1090#1077#1085#1090#1080#1092#1080#1082#1072#1094#1080#1080':'
    end
    object lblProtocol: TLabel
      Left = 8
      Top = 56
      Width = 52
      Height = 13
      Caption = #1055#1088#1086#1090#1086#1082#1086#1083':'
    end
    object cbAuthType: TComboBox
      Left = 128
      Top = 32
      Width = 129
      Height = 21
      Hint = 'AuthType'
      Style = csDropDownList
      Anchors = [akLeft, akTop, akRight]
      ItemHeight = 13
      TabOrder = 0
      Items.Strings = (
        #1055#1086#1089#1083#1077#1076#1091#1102#1097#1072#1103
        #1055#1077#1088#1074#1072#1103)
    end
    object btnMifarePlusAuthSL1: TButton
      Left = 264
      Top = 32
      Width = 129
      Height = 25
      Hint = 'MifarePlusAuthSL1'
      Anchors = [akTop, akRight]
      Caption = #1040#1074#1090#1086#1088#1080#1079#1072#1094#1080#1103' SL1'
      TabOrder = 5
      OnClick = btnMifarePlusAuthSL1Click
    end
    object btnMifarePlusAuthSL3: TButton
      Left = 264
      Top = 96
      Width = 129
      Height = 25
      Hint = 'MifarePlusAuthSL3'
      Anchors = [akTop, akRight]
      Caption = #1040#1074#1090#1086#1088#1080#1079#1072#1094#1080#1103' SL3'
      TabOrder = 7
      OnClick = btnMifarePlusAuthSL3Click
    end
    object btnMifarePlusResetAuthentication: TButton
      Left = 264
      Top = 128
      Width = 129
      Height = 25
      Hint = 'MifarePlusResetAuthentication'
      Anchors = [akTop, akRight]
      Caption = #1057#1073#1088#1086#1089' '#1072#1074#1090#1086#1088#1080#1079#1072#1094#1080#1080
      TabOrder = 8
      OnClick = btnMifarePlusResetAuthenticationClick
    end
    object seBlockNumber2: TSpinEdit
      Left = 128
      Top = 80
      Width = 129
      Height = 22
      Hint = 'BlockNumber'
      Anchors = [akLeft, akTop, akRight]
      MaxValue = 65535
      MinValue = 0
      TabOrder = 2
      Value = 0
    end
    object seKeyNumber: TSpinEdit
      Left = 128
      Top = 104
      Width = 129
      Height = 22
      Hint = 'KeyNumber'
      Anchors = [akLeft, akTop, akRight]
      MaxValue = 255
      MinValue = 0
      TabOrder = 3
      Value = 0
    end
    object seKeyVersion: TSpinEdit
      Left = 128
      Top = 128
      Width = 129
      Height = 22
      Hint = 'KeyVersion'
      Anchors = [akLeft, akTop, akRight]
      MaxValue = 255
      MinValue = 0
      TabOrder = 4
      Value = 0
    end
    object cbProtocol: TComboBox
      Left = 128
      Top = 56
      Width = 129
      Height = 21
      Hint = 'Protocol'
      Style = csDropDownList
      Anchors = [akLeft, akTop, akRight]
      ItemHeight = 13
      TabOrder = 1
      Items.Strings = (
        'ISO14443-3'
        'ISO14443-4')
    end
    object btnMifarePlusAuthSL2: TButton
      Left = 264
      Top = 64
      Width = 129
      Height = 25
      Hint = 'MifarePlusAuthSL2'
      Anchors = [akTop, akRight]
      Caption = #1040#1074#1090#1086#1088#1080#1079#1072#1094#1080#1103' SL2'
      TabOrder = 6
      OnClick = btnMifarePlusAuthSL2Click
    end
  end
  object gbSAMAV2Key: TGroupBox
    Left = 8
    Top = 192
    Width = 409
    Height = 153
    Anchors = [akLeft, akTop, akRight]
    Caption = #1047#1072#1087#1080#1089#1100' AES128 '#1082#1083#1102#1095#1072' '#1074' SAM AV2'
    TabOrder = 1
    DesignSize = (
      409
      153)
    object lblKeyEntry: TLabel
      Left = 16
      Top = 32
      Width = 76
      Height = 13
      Caption = #1053#1086#1084#1077#1088' '#1079#1072#1087#1080#1089#1080':'
    end
    object lblKeyPosition: TLabel
      Left = 16
      Top = 56
      Width = 81
      Height = 13
      Caption = #1055#1086#1079#1080#1094#1080#1103' '#1082#1083#1102#1095#1072':'
    end
    object lblKeyVersion2: TLabel
      Left = 16
      Top = 80
      Width = 74
      Height = 13
      Caption = #1042#1077#1088#1089#1080#1103' '#1082#1083#1102#1095#1072':'
    end
    object lblKeyData: TLabel
      Left = 16
      Top = 104
      Width = 95
      Height = 13
      Caption = #1050#1083#1102#1095', 16 '#1073#1072#1081#1090' Hex:'
    end
    object seKeyEntryNumber: TSpinEdit
      Left = 128
      Top = 32
      Width = 129
      Height = 22
      Hint = 'KeyEntryNumber'
      Anchors = [akLeft, akTop, akRight]
      MaxValue = 255
      MinValue = 0
      TabOrder = 0
      Value = 0
    end
    object seKeyPosition: TSpinEdit
      Left = 128
      Top = 56
      Width = 129
      Height = 22
      Hint = 'KeyPosition'
      Anchors = [akLeft, akTop, akRight]
      MaxValue = 255
      MinValue = 0
      TabOrder = 1
      Value = 2
    end
    object seKeyVersion2: TSpinEdit
      Left = 128
      Top = 80
      Width = 129
      Height = 22
      Hint = 'KeyVersion'
      Anchors = [akLeft, akTop, akRight]
      MaxValue = 255
      MinValue = 0
      TabOrder = 2
      Value = 3
    end
    object edtBlockDataHex: TEdit
      Left = 128
      Top = 104
      Width = 265
      Height = 21
      Hint = 'BlockDataHex'
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 3
      Text = '000102030405060708090A0B0C0D0E0F'
    end
    object btnSAMAV2WriteKey: TButton
      Left = 264
      Top = 32
      Width = 129
      Height = 25
      Hint = 'SAMAV2WriteKey'
      Anchors = [akTop, akRight]
      Caption = #1047#1072#1087#1080#1089#1072#1090#1100' '#1082#1083#1102#1095
      TabOrder = 4
      OnClick = btnSAMAV2WriteKeyClick
    end
  end
  object gbActivation: TGroupBox
    Left = 8
    Top = 352
    Width = 409
    Height = 73
    Anchors = [akLeft, akTop, akRight]
    Caption = #1040#1082#1090#1080#1074#1072#1094#1080#1103
    TabOrder = 2
    DesignSize = (
      409
      73)
    object lblSerialNumber: TLabel
      Left = 16
      Top = 32
      Width = 96
      Height = 13
      Caption = #1053#1086#1084#1077#1088' '#1082#1072#1088#1090#1099', Hex:'
    end
    object edtUIDHex: TEdit
      Left = 128
      Top = 32
      Width = 161
      Height = 21
      Hint = 'UIDHex'
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      Text = '2697F0B9'
    end
    object btnPiccActivateWakeUp: TButton
      Left = 304
      Top = 32
      Width = 97
      Height = 25
      Hint = 'PiccActivateWakeUp'
      Anchors = [akTop, akRight]
      Caption = #1040#1082#1090#1080#1074#1072#1094#1080#1103
      TabOrder = 1
      OnClick = btnPiccActivateWakeUpClick
    end
  end
end
