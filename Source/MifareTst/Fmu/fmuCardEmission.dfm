object fmCardEmission: TfmCardEmission
  Left = 384
  Top = 204
  BorderStyle = bsSingle
  Caption = #1069#1084#1080#1089#1089#1080#1103' '#1082#1072#1088#1090
  ClientHeight = 311
  ClientWidth = 448
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    448
    311)
  PixelsPerInch = 96
  TextHeight = 13
  object gbOperations: TGroupBox
    Left = 8
    Top = 8
    Width = 433
    Height = 265
    Anchors = [akLeft, akTop, akRight]
    Caption = #1047#1072#1087#1080#1089#1100' '#1079#1072#1096#1080#1092#1088#1086#1074#1072#1085#1085#1099#1093' AES128 '#1082#1083#1102#1095#1086#1084' '#1076#1072#1085#1085#1099#1093' '#1085#1072' '#1082#1072#1088#1090#1099
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    DesignSize = (
      433
      265)
    object lblBlockData: TLabel
      Left = 16
      Top = 200
      Width = 108
      Height = 13
      Caption = #1044#1072#1085#1085#1099#1077', 16 '#1073#1072#1081#1090' hex:'
    end
    object Label1: TLabel
      Left = 16
      Top = 32
      Width = 361
      Height = 33
      AutoSize = False
      Caption = 
        #1047#1072#1087#1080#1089#1099#1074#1072#1077#1090' '#1085#1072' '#1082#1072#1088#1090#1091' '#1073#1083#1086#1082' '#1076#1072#1085#1085#1099#1093', '#1087#1088#1077#1076#1074#1072#1088#1080#1090#1077#1083#1100#1085#1086' '#1088#1072#1089#1096#1080#1092#1088#1086#1074#1072#1074' '#1077#1075#1086' ' +
        #13#10#1091#1082#1072#1079#1072#1085#1085#1099#1084' AES '#1082#1083#1102#1095#1086#1084'.'
      WordWrap = True
    end
    object lblProtocol: TLabel
      Left = 16
      Top = 72
      Width = 52
      Height = 13
      Caption = #1055#1088#1086#1090#1086#1082#1086#1083':'
    end
    object lblBlockNumber: TLabel
      Left = 16
      Top = 104
      Width = 70
      Height = 13
      Caption = #1053#1086#1084#1077#1088' '#1073#1083#1086#1082#1072':'
    end
    object lblKeyNumber: TLabel
      Left = 16
      Top = 136
      Width = 71
      Height = 13
      Caption = #1053#1086#1084#1077#1088' '#1082#1083#1102#1095#1072':'
    end
    object lblKeyVersion: TLabel
      Left = 16
      Top = 168
      Width = 74
      Height = 13
      Caption = #1042#1077#1088#1089#1080#1103' '#1082#1083#1102#1095#1072':'
    end
    object btnWriteEncryptedData: TButton
      Left = 304
      Top = 232
      Width = 121
      Height = 25
      Hint = 'WriteEncryptedData'
      Anchors = [akTop, akRight]
      Caption = #1047#1072#1087#1080#1089#1072#1090#1100
      TabOrder = 5
      OnClick = btnWriteEncryptedDataClick
    end
    object edtBlockDataHex: TEdit
      Left = 136
      Top = 200
      Width = 289
      Height = 21
      Hint = 'BlockDataHex'
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 4
    end
    object cbProtocol: TComboBox
      Left = 136
      Top = 72
      Width = 129
      Height = 21
      Hint = 'Protocol'
      Style = csDropDownList
      Anchors = [akLeft, akTop, akRight]
      ItemHeight = 13
      TabOrder = 0
      Items.Strings = (
        'ISO14443-3'
        'ISO14443-4')
    end
    object seBlockNumber: TSpinEdit
      Left = 136
      Top = 104
      Width = 129
      Height = 22
      Hint = 'BlockNumber'
      Anchors = [akLeft, akTop, akRight]
      MaxValue = 65535
      MinValue = 0
      TabOrder = 1
      Value = 1
    end
    object seKeyNumber: TSpinEdit
      Left = 136
      Top = 136
      Width = 129
      Height = 22
      Hint = 'KeyNumber'
      Anchors = [akLeft, akTop, akRight]
      MaxValue = 255
      MinValue = 0
      TabOrder = 2
      Value = 2
    end
    object seKeyVersion: TSpinEdit
      Left = 136
      Top = 168
      Width = 129
      Height = 22
      Hint = 'KeyVersion'
      Anchors = [akLeft, akTop, akRight]
      MaxValue = 255
      MinValue = 0
      TabOrder = 3
      Value = 3
    end
  end
end
