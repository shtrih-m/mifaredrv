object fmMifarePlusPerso: TfmMifarePlusPerso
  Left = 364
  Top = 134
  BorderStyle = bsSingle
  Caption = 'MIFARE Plus '#1087#1077#1088#1089#1086#1085#1072#1083#1080#1079#1072#1094#1080#1103
  ClientHeight = 383
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
    383)
  PixelsPerInch = 96
  TextHeight = 13
  object gbPerso: TGroupBox
    Left = 8
    Top = 168
    Width = 409
    Height = 209
    Caption = #1055#1077#1088#1089#1086#1085#1072#1083#1080#1079#1072#1094#1080#1103
    TabOrder = 0
    DesignSize = (
      409
      209)
    object lblBlockNumber: TLabel
      Left = 8
      Top = 64
      Width = 118
      Height = 13
      Caption = #1053#1086#1084#1077#1088' '#1073#1083#1086#1082#1072', 0..65535:'
    end
    object lblBlockDataHex: TLabel
      Left = 8
      Top = 36
      Width = 110
      Height = 13
      Caption = #1044#1072#1085#1085#1099#1077', 16 '#1073#1072#1081#1090' Hex:'
    end
    object lblPersoCommit: TLabel
      Left = 80
      Top = 176
      Width = 150
      Height = 13
      Anchors = [akTop, akRight]
      Caption = #1047#1072#1074#1077#1088#1096#1077#1085#1080#1077' '#1087#1077#1088#1089#1086#1085#1072#1083#1080#1079#1072#1094#1080#1080
    end
    object lblWritePerso: TLabel
      Left = 96
      Top = 144
      Width = 135
      Height = 13
      Anchors = [akTop, akRight]
      Caption = #1047#1072#1087#1080#1089#1100' '#1087#1072#1088#1072#1084#1077#1090#1088#1086#1074' '#1082#1072#1088#1090#1099
    end
    object edtBlockDataHex: TEdit
      Left = 136
      Top = 32
      Width = 265
      Height = 21
      Hint = 'BlockDataHex'
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      Text = '000102030405060708090A0B0C0D0E0F'
    end
    object btnMifarePlusWritePerso: TButton
      Left = 240
      Top = 136
      Width = 161
      Height = 25
      Hint = 'MifarePlusWritePerso'
      Anchors = [akTop, akRight]
      Caption = #1047#1072#1087#1080#1089#1072#1090#1100' '#1073#1083#1086#1082
      TabOrder = 3
      OnClick = btnMifarePlusWritePersoClick
    end
    object btnMifarePlusCommitPerso: TButton
      Left = 240
      Top = 168
      Width = 161
      Height = 25
      Hint = 'MifarePlusCommitPerso'
      Anchors = [akTop, akRight]
      Caption = #1055#1086#1076#1090#1074#1077#1088#1078#1076#1077#1085#1080#1077
      TabOrder = 4
      OnClick = btnMifarePlusCommitPersoClick
    end
    object seBlockNumber: TSpinEdit
      Left = 136
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
    object cbBlockNumber: TComboBox
      Left = 136
      Top = 96
      Width = 265
      Height = 21
      Hint = 'BlockNumber'
      Style = csDropDownList
      Anchors = [akLeft, akTop, akRight]
      ItemHeight = 13
      TabOrder = 2
      OnChange = cbBlockNumberChange
      Items.Strings = (
        '0x9000, Card Master Key Address'
        '0x9001, Card Configuration Key Address'
        '0x9002, Level 2 Switch Key Address'
        '0x9003, Level 3 Switch Key Address'
        '0x9004, SL1 Card Authentication Key Address'
        '0xA000, Select VC Key Address'
        '0xA001, Proximity Check Key Address'
        '0xA080, VC Polling ENC Key Address'
        '0xA081, VC Polling MAC Key Address'
        '0xB000, MIFARE Plus Configuration block Address'
        '0xB001, Installation Identifier Address'
        '0xB003, Field Configuration block Address'
        '0x4000, physical start address of AES key location Address'
        '0x404F, physical end address of AES key location Address')
    end
  end
  object pnlInfo: TPanel
    Left = 8
    Top = 8
    Width = 409
    Height = 153
    Anchors = [akLeft, akTop, akRight]
    BorderWidth = 5
    BorderStyle = bsSingle
    Color = clWindow
    TabOrder = 1
    object Label1: TLabel
      Left = 6
      Top = 6
      Width = 393
      Height = 137
      Align = alClient
      Caption = 
        #1044#1083#1103' '#1087#1077#1088#1089#1086#1085#1072#1083#1080#1079#1072#1094#1080#1080' '#1082#1072#1088#1090#1099' '#1085#1077#1086#1073#1093#1086#1076#1080#1084#1086':'#13#10'- '#1047#1072#1087#1080#1089#1072#1090#1100' '#1084#1072#1089#1090#1077#1088' '#1082#1083#1102#1095' '#1082#1072#1088 +
        #1090#1099', 0x9000h'#13#10'- '#1047#1072#1087#1080#1089#1072#1090#1100' '#1082#1083#1102#1095' '#1082#1086#1085#1092#1080#1075#1091#1088#1072#1094#1080#1080' '#1082#1072#1088#1090#1099', 0x9001h'#13#10'- '#1047#1072#1087#1080 +
        #1089#1072#1090#1100' '#1082#1083#1102#1095' '#1087#1077#1088#1077#1093#1086#1076#1072' '#1085#1072' '#1091#1088#1086#1074#1077#1085#1100' SL2'#13#10'    ('#1082#1072#1088#1090#1072' Mifare PLUS S '#1085#1077' '#1087 +
        #1086#1076#1076#1077#1088#1078#1080#1074#1072#1077#1090' SL2 '#1080' '#1101#1090#1086#1090' '#1082#1083#1102#1095' '#1085#1077' '#1090#1088#1077#1073#1091#1077#1090#1089#1103')'#13#10'- '#1047#1072#1087#1080#1089#1072#1090#1100' '#1082#1083#1102#1095' '#1087#1077#1088#1077#1093 +
        #1086#1076#1072' '#1085#1072' '#1091#1088#1086#1074#1077#1085#1100' SL3'#13#10#13#10#1058#1072#1082#1078#1077' '#1088#1077#1082#1086#1084#1077#1085#1076#1091#1077#1090#1089#1103':'#13#10'- '#1079#1072#1087#1080#1089#1072#1090#1100' '#1074#1089#1077' '#1082#1083#1102#1095#1080 +
        #13#10'- '#1079#1072#1087#1080#1089#1072#1090#1100' '#1074#1089#1077' '#1073#1083#1086#1082#1080' '#1082#1086#1085#1092#1080#1075#1091#1088#1072#1094#1080#1080
    end
  end
end
