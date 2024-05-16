object fmMifarePlusData: TfmMifarePlusData
  Left = 506
  Top = 220
  BorderStyle = bsSingle
  Caption = 'MIFARE Plus '#1076#1072#1085#1085#1099#1077
  ClientHeight = 340
  ClientWidth = 423
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  ShowHint = True
  DesignSize = (
    423
    340)
  PixelsPerInch = 96
  TextHeight = 13
  object gbBlockData: TGroupBox
    Left = 8
    Top = 8
    Width = 409
    Height = 329
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = #1044#1072#1085#1085#1099#1077' '#1073#1083#1086#1082#1072
    TabOrder = 0
    DesignSize = (
      409
      329)
    object lblBBlock: TLabel
      Left = 16
      Top = 24
      Width = 70
      Height = 13
      Caption = #1053#1086#1084#1077#1088' '#1073#1083#1086#1082#1072':'
    end
    object lblBlockCount: TLabel
      Left = 16
      Top = 64
      Width = 101
      Height = 13
      Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1073#1083#1086#1082#1086#1074':'
    end
    object lblBlockData: TLabel
      Left = 16
      Top = 96
      Width = 69
      Height = 13
      Caption = #1044#1072#1085#1085#1099#1077', Hex:'
    end
    object btnMifarePlusMultiblockRead: TButton
      Left = 114
      Top = 260
      Width = 135
      Height = 25
      Hint = 'MifarePlusMultiblockRead'
      Anchors = [akRight, akBottom]
      Caption = #1055#1088#1086#1095#1080#1090#1072#1090#1100' '#1073#1083#1086#1082#1080
      TabOrder = 8
      OnClick = btnMifarePlusMultiblockReadClick
    end
    object btnMifarePlusMultiblockWrite: TButton
      Left = 258
      Top = 260
      Width = 135
      Height = 25
      Hint = 'MifarePlusMultiblockWrite'
      Anchors = [akRight, akBottom]
      Caption = #1047#1072#1087#1080#1089#1072#1090#1100' '#1073#1083#1086#1082#1080
      TabOrder = 9
      OnClick = btnMifarePlusMultiblockWriteClick
    end
    object btnMifarePlusRead: TButton
      Left = 114
      Top = 228
      Width = 135
      Height = 25
      Hint = 'MifarePlusRead'
      Anchors = [akRight, akBottom]
      Caption = #1055#1088#1086#1095#1080#1090#1072#1090#1100' '#1073#1083#1086#1082
      TabOrder = 6
      OnClick = btnMifarePlusReadClick
    end
    object btnMifarePlusWrite: TButton
      Left = 258
      Top = 228
      Width = 135
      Height = 25
      Hint = 'MifarePlusWrite'
      Anchors = [akRight, akBottom]
      Caption = #1047#1072#1087#1080#1089#1072#1090#1100' '#1073#1083#1086#1082
      TabOrder = 7
      OnClick = btnMifarePlusWriteClick
    end
    object memBlockData: TMemo
      Left = 16
      Top = 112
      Width = 382
      Height = 102
      Anchors = [akLeft, akTop, akRight, akBottom]
      ScrollBars = ssVertical
      TabOrder = 5
    end
    object seBlockNumber: TSpinEdit
      Left = 128
      Top = 24
      Width = 89
      Height = 22
      Hint = 'BlockNumber'
      MaxValue = 65535
      MinValue = 0
      TabOrder = 0
      Value = 0
    end
    object seBlockCount: TSpinEdit
      Left = 128
      Top = 64
      Width = 89
      Height = 22
      Hint = 'BlockCount'
      MaxValue = 255
      MinValue = 0
      TabOrder = 1
      Value = 4
    end
    object chbEncryptionEnabled: TCheckBox
      Left = 232
      Top = 24
      Width = 164
      Height = 17
      Hint = 'EncryptionEnabled'
      Caption = #1064#1080#1092#1088#1086#1074#1072#1085#1080#1077' '#1074#1082#1083#1102#1095#1077#1085#1086
      TabOrder = 2
    end
    object chbAnswerSignature: TCheckBox
      Left = 232
      Top = 48
      Width = 159
      Height = 17
      Hint = 'AnswerSignature'
      Caption = #1055#1086#1076#1087#1080#1089#1100' '#1086#1090#1074#1077#1090#1072
      TabOrder = 3
    end
    object chbCommandSignature: TCheckBox
      Left = 232
      Top = 72
      Width = 164
      Height = 17
      Hint = 'CommandSignature'
      Caption = #1055#1086#1076#1087#1080#1089#1100' '#1082#1086#1084#1072#1085#1076#1099
      TabOrder = 4
    end
    object btnMifarePlusMultiblockReadSL2: TButton
      Left = 114
      Top = 292
      Width = 135
      Height = 25
      Hint = 'MifarePlusMultiblockReadSL2'
      Anchors = [akRight, akBottom]
      Caption = #1055#1088#1086#1095#1080#1090#1072#1090#1100' '#1073#1083#1086#1082#1080' SL2'
      TabOrder = 10
      OnClick = btnMifarePlusMultiblockReadSL2Click
    end
    object btnMifarePlusMultiblockWriteSL2: TButton
      Left = 258
      Top = 292
      Width = 137
      Height = 25
      Hint = 'MifarePlusMultiblockWriteSL2'
      Anchors = [akRight, akBottom]
      Caption = #1047#1072#1087#1080#1089#1072#1090#1100' '#1073#1083#1086#1082#1080' SL2'
      TabOrder = 11
      OnClick = btnMifarePlusMultiblockWriteSL2Click
    end
  end
end
