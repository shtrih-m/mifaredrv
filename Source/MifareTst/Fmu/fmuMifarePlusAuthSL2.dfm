object fmMifarePlusAuthSL2: TfmMifarePlusAuthSL2
  Left = 400
  Top = 167
  BorderStyle = bsSingle
  Caption = 'MIFARE Plus '#1072#1074#1090#1086#1088#1080#1079#1072#1094#1080#1103' SL2'
  ClientHeight = 338
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
    338)
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 7
    Top = 8
    Width = 410
    Height = 169
    Anchors = [akLeft, akTop, akRight]
    Caption = #1040#1074#1090#1086#1088#1080#1079#1072#1094#1080#1103' SL2 '#1082#1083#1102#1095#1086#1084' Crypto-1'
    TabOrder = 0
    DesignSize = (
      410
      169)
    object lblKeyNumber: TLabel
      Left = 8
      Top = 80
      Width = 71
      Height = 13
      Caption = #1053#1086#1084#1077#1088' '#1082#1083#1102#1095#1072':'
    end
    object lblBlockNumber: TLabel
      Left = 8
      Top = 32
      Width = 70
      Height = 13
      Caption = #1053#1086#1084#1077#1088' '#1073#1083#1086#1082#1072':'
    end
    object KeyVersion: TLabel
      Left = 8
      Top = 104
      Width = 74
      Height = 13
      Caption = #1042#1077#1088#1089#1080#1103' '#1082#1083#1102#1095#1072':'
    end
    object btnKeyType: TLabel
      Left = 8
      Top = 56
      Width = 56
      Height = 13
      Caption = #1058#1080#1087' '#1082#1083#1102#1095#1072':'
    end
    object lblUID: TLabel
      Left = 8
      Top = 128
      Width = 81
      Height = 13
      Caption = 'UID '#1082#1072#1088#1090#1099', Hex:'
    end
    object btnMifarePlusAuthSL2Crypto1: TButton
      Left = 267
      Top = 64
      Width = 129
      Height = 25
      Hint = 'MifarePlusAuthSL2Crypto1'
      Anchors = [akTop, akRight]
      Caption = #1040#1074#1090#1086#1088#1080#1079#1072#1094#1080#1103' SL2'
      TabOrder = 6
      OnClick = btnMifarePlusAuthSL2Crypto1Click
    end
    object seBlockNumber: TSpinEdit
      Left = 128
      Top = 32
      Width = 130
      Height = 22
      Hint = 'BlockNumber'
      Anchors = [akLeft, akTop, akRight]
      MaxValue = 65535
      MinValue = 0
      TabOrder = 0
      Value = 1
    end
    object seKeyNumber: TSpinEdit
      Left = 128
      Top = 80
      Width = 130
      Height = 22
      Hint = 'KeyNumber'
      Anchors = [akLeft, akTop, akRight]
      MaxValue = 255
      MinValue = 0
      TabOrder = 2
      Value = 2
    end
    object seKeyVersion: TSpinEdit
      Left = 128
      Top = 104
      Width = 130
      Height = 22
      Hint = 'KeyVersion'
      Anchors = [akLeft, akTop, akRight]
      MaxValue = 255
      MinValue = 0
      TabOrder = 3
      Value = 3
    end
    object cbKeyType: TComboBox
      Left = 128
      Top = 56
      Width = 130
      Height = 21
      Hint = 'KeyType'
      Style = csDropDownList
      Anchors = [akLeft, akTop, akRight]
      ItemHeight = 13
      TabOrder = 1
      Items.Strings = (
        'A'
        'B')
    end
    object edtUIDHex: TEdit
      Left = 128
      Top = 128
      Width = 130
      Height = 21
      Hint = 'UIDHex'
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 4
    end
    object btnPiccActivateWakeUp: TButton
      Left = 267
      Top = 32
      Width = 129
      Height = 25
      Hint = 'PiccActivateWakeUp'
      Anchors = [akTop, akRight]
      Caption = #1040#1082#1090#1080#1074#1072#1094#1080#1103
      TabOrder = 5
      OnClick = btnPiccActivateWakeUpClick
    end
  end
end
