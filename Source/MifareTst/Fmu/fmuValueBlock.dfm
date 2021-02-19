object fmValueBlock: TfmValueBlock
  Left = 595
  Top = 180
  BorderStyle = bsSingle
  Caption = #1041#1083#1086#1082'-'#1079#1085#1072#1095#1077#1085#1080#1077
  ClientHeight = 441
  ClientWidth = 528
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
  object gbOperations: TGroupBox
    Left = 8
    Top = 8
    Width = 513
    Height = 321
    Caption = #1054#1087#1077#1088#1072#1094#1080#1080
    TabOrder = 0
    DesignSize = (
      513
      321)
    object lblBBlock: TLabel
      Left = 8
      Top = 120
      Width = 70
      Height = 13
      Caption = #1053#1086#1084#1077#1088' '#1073#1083#1086#1082#1072':'
    end
    object lblDeltaValue: TLabel
      Left = 8
      Top = 168
      Width = 61
      Height = 13
      Caption = #1048#1079#1084#1077#1085#1077#1085#1080#1077':'
    end
    object lblTransBlockNumber: TLabel
      Left = 8
      Top = 144
      Width = 67
      Height = 13
      Caption = #1041#1083#1086#1082' '#1073#1101#1082#1072#1087#1072':'
    end
    object lblOperation: TLabel
      Left = 8
      Top = 192
      Width = 53
      Height = 13
      Caption = #1054#1087#1077#1088#1072#1094#1080#1103':'
    end
    object lblBlockValue: TLabel
      Left = 8
      Top = 56
      Width = 51
      Height = 13
      Caption = #1047#1085#1072#1095#1077#1085#1080#1077':'
    end
    object lblBlockAddr: TLabel
      Left = 8
      Top = 80
      Width = 84
      Height = 13
      Caption = #1057#1089#1099#1083#1082#1072' '#1085#1072' '#1073#1083#1086#1082':'
    end
    object lblBlockData: TLabel
      Left = 8
      Top = 24
      Width = 44
      Height = 13
      Caption = #1044#1072#1085#1085#1099#1077':'
    end
    object Label1: TLabel
      Left = 8
      Top = 216
      Width = 74
      Height = 13
      Anchors = [akLeft, akTop, akRight]
      Caption = #1047#1085#1072#1095#1077#1085#1080#1077', hex:'
    end
    object btnIncrement: TButton
      Left = 320
      Top = 88
      Width = 89
      Height = 25
      Hint = 'PiccValue(voIncrement)'
      Anchors = [akTop, akRight]
      Caption = #1059#1074#1077#1083#1080#1095#1080#1090#1100
      TabOrder = 10
      OnClick = btnIncrementClick
    end
    object btnPiccValueDebit: TButton
      Left = 320
      Top = 152
      Width = 185
      Height = 25
      Hint = 'PiccValueDebit'
      Anchors = [akTop, akRight]
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100' '#1086#1087#1077#1088#1072#1094#1080#1102
      TabOrder = 14
      OnClick = btnPiccValueDebitClick
    end
    object btnDecrement: TButton
      Left = 416
      Top = 88
      Width = 89
      Height = 25
      Hint = 'PiccValue(voDecrement)'
      Anchors = [akTop, akRight]
      Caption = #1059#1084#1077#1085#1100#1096#1080#1090#1100
      TabOrder = 11
      OnClick = btnDecrementClick
    end
    object btnTransfer: TButton
      Left = 320
      Top = 120
      Width = 89
      Height = 25
      Hint = 'PiccValue(voTransfer)'
      Anchors = [akTop, akRight]
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      TabOrder = 12
      OnClick = btnTransferClick
    end
    object btnRestore: TButton
      Left = 416
      Top = 120
      Width = 89
      Height = 25
      Hint = 'PiccValue(voRestore)'
      Anchors = [akTop, akRight]
      Caption = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1080#1090#1100
      TabOrder = 13
      OnClick = btnRestoreClick
    end
    object btnPiccRead: TButton
      Left = 320
      Top = 56
      Width = 89
      Height = 25
      Hint = 'PiccRead'
      Anchors = [akTop, akRight]
      Caption = #1055#1088#1086#1095#1080#1090#1072#1090#1100
      TabOrder = 8
      OnClick = btnReadClick
    end
    object btnPiccWrite: TButton
      Left = 416
      Top = 56
      Width = 89
      Height = 25
      Hint = 'PiccWrite'
      Anchors = [akTop, akRight]
      Caption = #1047#1072#1087#1080#1089#1072#1090#1100
      TabOrder = 9
      OnClick = btnPiccWriteClick
    end
    object cbOperation: TComboBox
      Left = 104
      Top = 192
      Width = 201
      Height = 21
      Hint = 'Operation'
      Style = csDropDownList
      Anchors = [akLeft, akTop, akRight]
      ItemHeight = 13
      TabOrder = 6
      Items.Strings = (
        'Increment'
        'Decrement'
        'Restore'
        'Transfer')
    end
    object seBlockNumber: TSpinEdit
      Left = 104
      Top = 120
      Width = 201
      Height = 22
      Hint = 'BlockNumber'
      Anchors = [akLeft, akTop, akRight]
      MaxValue = 0
      MinValue = 0
      TabOrder = 3
      Value = 1
    end
    object seTransBlockNumber: TSpinEdit
      Left = 104
      Top = 144
      Width = 201
      Height = 22
      Hint = 'TransBlockNumber'
      Anchors = [akLeft, akTop, akRight]
      MaxValue = 0
      MinValue = 0
      TabOrder = 4
      Value = 2
    end
    object seDeltaValue: TSpinEdit
      Left = 104
      Top = 168
      Width = 201
      Height = 22
      Hint = 'DeltaValue'
      Anchors = [akLeft, akTop, akRight]
      MaxValue = 0
      MinValue = 0
      TabOrder = 5
      Value = 3
    end
    object edtBlockDataHex: TEdit
      Left = 104
      Top = 24
      Width = 401
      Height = 21
      Hint = 'BlockDataHex'
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 2
    end
    object seBlockAddr: TSpinEdit
      Left = 104
      Top = 80
      Width = 201
      Height = 22
      Hint = 'BlockAddr'
      Anchors = [akLeft, akTop, akRight]
      MaxValue = 255
      MinValue = 0
      TabOrder = 1
      Value = 0
    end
    object seBlockValue: TSpinEdit
      Left = 104
      Top = 56
      Width = 201
      Height = 22
      Hint = 'BlockValue'
      Anchors = [akLeft, akTop, akRight]
      MaxValue = 2147483647
      MinValue = -2147483648
      TabOrder = 0
      Value = 0
    end
    object btnEncodeBlock: TButton
      Left = 320
      Top = 184
      Width = 185
      Height = 25
      Hint = 'EncodeBlock'
      Anchors = [akTop, akRight]
      Caption = #1050#1086#1076#1080#1088#1086#1074#1072#1090#1100' '#1073#1083#1086#1082
      TabOrder = 15
      OnClick = btnEncodeBlockClick
    end
    object btnDecodeBlock: TButton
      Left = 320
      Top = 216
      Width = 185
      Height = 25
      Hint = 'DecodeBlock'
      Anchors = [akTop, akRight]
      Caption = #1044#1077#1082#1086#1076#1080#1088#1086#1074#1072#1090#1100' '#1073#1083#1086#1082
      TabOrder = 16
      OnClick = btnDecodeBlockClick
    end
    object btnDefaultValue: TButton
      Left = 320
      Top = 280
      Width = 185
      Height = 25
      Hint = 'DefaultValue'
      Anchors = [akTop, akRight]
      Caption = #1055#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
      TabOrder = 18
      OnClick = btnDefaultValueClick
    end
    object btnFillBlock: TButton
      Left = 320
      Top = 248
      Width = 185
      Height = 25
      Hint = 'FillBlock'
      Anchors = [akTop, akRight]
      Caption = #1047#1072#1087#1086#1083#1085#1080#1090#1100' '#1073#1083#1086#1082
      TabOrder = 17
      OnClick = btnFillBlockClick
    end
    object edtFillValue: TEdit
      Left = 104
      Top = 216
      Width = 201
      Height = 21
      Hint = 'FillValue'
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 7
      Text = 'FF'
    end
  end
end
