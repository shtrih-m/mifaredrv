object fmMifarePlusValue: TfmMifarePlusValue
  Left = 556
  Top = 249
  BorderStyle = bsSingle
  Caption = 'MIFARE Plus '#1079#1085#1072#1095#1077#1085#1080#1077
  ClientHeight = 408
  ClientWidth = 448
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
  object gbData: TGroupBox
    Left = 8
    Top = 208
    Width = 435
    Height = 161
    Caption = #1044#1072#1085#1085#1099#1077' '#1073#1083#1086#1082#1072
    TabOrder = 1
    DesignSize = (
      435
      161)
    object lblBlockDataHex: TLabel
      Left = 8
      Top = 88
      Width = 69
      Height = 13
      Caption = #1044#1072#1085#1085#1099#1077', Hex:'
    end
    object lblBlockValue2: TLabel
      Left = 8
      Top = 24
      Width = 51
      Height = 13
      Caption = #1047#1085#1072#1095#1077#1085#1080#1077':'
    end
    object lblBlockAddr: TLabel
      Left = 8
      Top = 56
      Width = 67
      Height = 13
      Caption = #1040#1076#1088#1077#1089' '#1073#1083#1086#1082#1072':'
    end
    object edtBlockDataHex: TEdit
      Left = 88
      Top = 88
      Width = 337
      Height = 21
      Hint = 'BlockData'
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 2
    end
    object btnEncodeValueBlock: TButton
      Left = 176
      Top = 120
      Width = 121
      Height = 25
      Hint = 'EncodeValueBlock'
      Anchors = [akTop, akRight]
      Caption = #1050#1086#1076#1080#1088#1086#1074#1072#1090#1100' '#1073#1083#1086#1082
      TabOrder = 3
      OnClick = btnEncodeValueBlockClick
    end
    object btnDecodeValueBlock: TButton
      Left = 304
      Top = 120
      Width = 121
      Height = 25
      Hint = 'DecodeValueBlock'
      Anchors = [akTop, akRight]
      Caption = #1044#1077#1082#1086#1076#1080#1088#1086#1074#1072#1090#1100' '#1073#1083#1086#1082
      TabOrder = 4
      OnClick = btnDecodeValueBlockClick
    end
    object seBlockValue2: TSpinEdit
      Left = 88
      Top = 24
      Width = 137
      Height = 22
      Hint = 'BlockValue2'
      Anchors = [akLeft, akTop, akRight]
      MaxValue = 2147483647
      MinValue = 0
      TabOrder = 0
      Value = 0
    end
    object seBlockAddr: TSpinEdit
      Left = 88
      Top = 56
      Width = 137
      Height = 22
      Hint = 'BlockAddr'
      Anchors = [akLeft, akTop, akRight]
      MaxValue = 255
      MinValue = 0
      TabOrder = 1
      Value = 0
    end
  end
  object gbOperations: TGroupBox
    Left = 8
    Top = 8
    Width = 433
    Height = 193
    Caption = #1041#1083#1086#1082'-'#1079#1085#1072#1095#1077#1085#1080#1077
    TabOrder = 0
    DesignSize = (
      433
      193)
    object lblBBlock: TLabel
      Left = 8
      Top = 24
      Width = 70
      Height = 13
      Caption = #1053#1086#1084#1077#1088' '#1073#1083#1086#1082#1072':'
    end
    object lblDeltaValue: TLabel
      Left = 8
      Top = 88
      Width = 61
      Height = 13
      Caption = #1048#1079#1084#1077#1085#1077#1085#1080#1077':'
    end
    object lblBlockValue: TLabel
      Left = 8
      Top = 56
      Width = 51
      Height = 13
      Caption = #1047#1085#1072#1095#1077#1085#1080#1077':'
    end
    object btnMifarePlusIncrement: TButton
      Left = 240
      Top = 56
      Width = 89
      Height = 25
      Hint = 'MifarePlusIncrement'
      Anchors = [akTop, akRight]
      Caption = 'Increment'
      TabOrder = 8
      OnClick = btnMifarePlusIncrementClick
    end
    object btnMifarePlusDecrement: TButton
      Left = 336
      Top = 56
      Width = 89
      Height = 25
      Hint = 'MifarePlusDecrement'
      Anchors = [akTop, akRight]
      Caption = 'Decrement'
      TabOrder = 9
      OnClick = btnMifarePlusDecrementClick
    end
    object btnMifarePlusTransfer: TButton
      Left = 240
      Top = 88
      Width = 89
      Height = 25
      Hint = 'MifarePlusTransfer'
      Anchors = [akTop, akRight]
      Caption = 'Transfer'
      TabOrder = 10
      OnClick = btnMifarePlusTransferClick
    end
    object btnMifarePlusRestore: TButton
      Left = 336
      Top = 88
      Width = 89
      Height = 25
      Hint = 'MifarePlusRestore'
      Anchors = [akTop, akRight]
      Caption = 'Restore'
      TabOrder = 11
      OnClick = btnMifarePlusRestoreClick
    end
    object btnMifarePlusReadValue: TButton
      Left = 240
      Top = 24
      Width = 89
      Height = 25
      Hint = 'MifarePlusReadValue'
      Anchors = [akTop, akRight]
      Caption = #1055#1088#1086#1095#1080#1090#1072#1090#1100
      TabOrder = 6
      OnClick = btnMifarePlusReadValueClick
    end
    object btnMifarePlusWriteValue: TButton
      Left = 336
      Top = 24
      Width = 89
      Height = 25
      Hint = 'MifarePlusWriteValue'
      Anchors = [akTop, akRight]
      Caption = #1047#1072#1087#1080#1089#1072#1090#1100
      TabOrder = 7
      OnClick = btnMifarePlusWriteValueClick
    end
    object btnMifarePlusIncrementTransfer: TButton
      Left = 240
      Top = 120
      Width = 185
      Height = 25
      Hint = 'MifarePlusIncrementTransfer'
      Anchors = [akTop, akRight]
      Caption = 'IncrementTransfer'
      TabOrder = 12
      OnClick = btnMifarePlusIncrementTransferClick
    end
    object btnMifarePlusDecrementTransfer: TButton
      Left = 240
      Top = 152
      Width = 185
      Height = 25
      Hint = 'MifarePlusIncrementTransfer'
      Anchors = [akTop, akRight]
      Caption = 'DecrementTransfer'
      TabOrder = 13
      OnClick = btnMifarePlusDecrementTransferClick
    end
    object seBlockNumber: TSpinEdit
      Left = 88
      Top = 24
      Width = 137
      Height = 22
      Hint = 'BlockNumber'
      Anchors = [akLeft, akTop, akRight]
      MaxValue = 65535
      MinValue = 0
      TabOrder = 0
      Value = 0
    end
    object chbEncryptionEnabled: TCheckBox
      Left = 16
      Top = 120
      Width = 193
      Height = 17
      Hint = 'EncryptionEnabled'
      Caption = #1064#1080#1092#1088#1086#1074#1072#1085#1080#1077' '#1074#1082#1083#1102#1095#1077#1085#1086
      TabOrder = 3
    end
    object chbAnswerSignature: TCheckBox
      Left = 16
      Top = 144
      Width = 169
      Height = 17
      Hint = 'AnswerSignature'
      Caption = #1055#1086#1076#1087#1080#1089#1100' '#1086#1090#1074#1077#1090#1072
      TabOrder = 4
    end
    object chbCommandSignature: TCheckBox
      Left = 16
      Top = 168
      Width = 169
      Height = 17
      Hint = 'CommandSignature'
      Caption = #1055#1086#1076#1087#1080#1089#1100' '#1082#1086#1084#1072#1085#1076#1099
      TabOrder = 5
    end
    object edtBlockValue: TEdit
      Left = 88
      Top = 56
      Width = 137
      Height = 21
      Hint = 'BlockValue'
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
      Text = '1'
    end
    object edtDeltaValue: TEdit
      Left = 88
      Top = 88
      Width = 137
      Height = 21
      Hint = 'DeltaValue'
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 2
      Text = '2'
    end
  end
end
