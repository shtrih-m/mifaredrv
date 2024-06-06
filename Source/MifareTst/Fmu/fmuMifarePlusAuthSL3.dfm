object fmMifarePlusAuthSL3: TfmMifarePlusAuthSL3
  Left = 416
  Top = 262
  BorderStyle = bsSingle
  Caption = 'MIFARE Plus '#1072#1074#1090#1086#1088#1080#1079#1072#1094#1080#1103' SL3'
  ClientHeight = 408
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
    408)
  PixelsPerInch = 96
  TextHeight = 13
  object gbAuth: TGroupBox
    Left = 8
    Top = 8
    Width = 409
    Height = 313
    Anchors = [akLeft, akTop, akRight]
    Caption = #1040#1074#1090#1086#1088#1080#1079#1072#1094#1080#1103' AES'
    TabOrder = 0
    DesignSize = (
      409
      313)
    object lblBlockNumber: TLabel
      Left = 8
      Top = 64
      Width = 70
      Height = 13
      Caption = #1053#1086#1084#1077#1088' '#1073#1083#1086#1082#1072':'
    end
    object lblAuthType: TLabel
      Left = 8
      Top = 32
      Width = 108
      Height = 13
      Caption = #1058#1080#1087' '#1072#1091#1090#1077#1085#1090#1080#1092#1080#1082#1072#1094#1080#1080':'
    end
    object lblKeyData: TLabel
      Left = 8
      Top = 96
      Width = 95
      Height = 13
      Caption = #1050#1083#1102#1095', 16 '#1073#1072#1081#1090' Hex:'
    end
    object lblDivInputHex: TLabel
      Left = 8
      Top = 128
      Width = 170
      Height = 13
      Caption = #1044#1077#1074#1077#1088#1089#1080#1092#1080#1082#1072#1094#1080#1103', 0..31 '#1073#1072#1081#1090' Hex:'
    end
    object lblStatus: TLabel
      Left = 8
      Top = 184
      Width = 57
      Height = 13
      Caption = #1057#1086#1089#1090#1086#1103#1085#1080#1077':'
    end
    object cbAuthType: TComboBox
      Left = 128
      Top = 32
      Width = 265
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
    object btnMifarePlusAuthSL3: TButton
      Left = 208
      Top = 232
      Width = 185
      Height = 25
      Hint = 'MifarePlusAuthSL3'
      Anchors = [akTop, akRight]
      Caption = #1040#1074#1090#1086#1088#1080#1079#1072#1094#1080#1103' SL3 '#1087#1086' '#1082#1083#1102#1095#1091
      TabOrder = 2
      OnClick = btnMifarePlusAuthSL3Click
    end
    object btnMifarePlusResetAuthentication: TButton
      Left = 208
      Top = 264
      Width = 185
      Height = 25
      Hint = 'MifarePlusResetAuthentication'
      Anchors = [akTop, akRight]
      Caption = #1057#1073#1088#1086#1089' '#1072#1074#1090#1086#1088#1080#1079#1072#1094#1080#1080
      TabOrder = 3
      OnClick = btnMifarePlusResetAuthenticationClick
    end
    object seBlockNumber: TSpinEdit
      Left = 128
      Top = 64
      Width = 265
      Height = 22
      Hint = 'BlockNumber'
      Anchors = [akLeft, akTop, akRight]
      MaxValue = 65535
      MinValue = 0
      TabOrder = 1
      Value = 0
    end
    object edtBlockDataHex: TEdit
      Left = 128
      Top = 96
      Width = 265
      Height = 21
      Hint = 'BlockDataHex'
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 4
      Text = '000102030405060708090A0B0C0D0E0F'
    end
    object edtDivInputHex: TEdit
      Left = 128
      Top = 152
      Width = 265
      Height = 21
      Hint = 'DivInputHex'
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 5
    end
    object edtStatus: TEdit
      Left = 128
      Top = 184
      Width = 265
      Height = 21
      Hint = 'Status'
      Anchors = [akLeft, akTop, akRight]
      Color = clBtnFace
      TabOrder = 6
    end
  end
  object gbActivation: TGroupBox
    Left = 8
    Top = 328
    Width = 409
    Height = 73
    Anchors = [akLeft, akTop, akRight]
    Caption = #1040#1082#1090#1080#1074#1072#1094#1080#1103
    TabOrder = 1
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
