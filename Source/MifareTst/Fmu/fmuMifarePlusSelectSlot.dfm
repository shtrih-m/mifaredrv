object fmMifarePlusSelectSlot: TfmMifarePlusSelectSlot
  Left = 457
  Top = 254
  BorderStyle = bsSingle
  Caption = 'MIFARE Plus '#1074#1099#1073#1086#1088' '#1089#1083#1086#1090#1072
  ClientHeight = 320
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
    320)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 152
    Width = 69
    Height = 13
    Caption = #1053#1086#1084#1077#1088' '#1089#1083#1086#1090#1072':'
  end
  object gbSelectSlot: TGroupBox
    Left = 8
    Top = 8
    Width = 409
    Height = 281
    Anchors = [akLeft, akTop, akRight]
    Caption = #1055#1077#1088#1077#1082#1083#1102#1095#1077#1085#1080#1077' '#1089#1083#1086#1090#1072' SAM AV2 '#1084#1086#1076#1091#1083#1103
    TabOrder = 0
    DesignSize = (
      409
      281)
    object lblSlotNumber2: TLabel
      Left = 8
      Top = 120
      Width = 69
      Height = 13
      Caption = #1053#1086#1084#1077#1088' '#1089#1083#1086#1090#1072':'
    end
    object lblOptionalValue: TLabel
      Left = 8
      Top = 56
      Width = 117
      Height = 13
      Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1081' '#1073#1072#1081#1090':'
    end
    object lblSlotNumber: TLabel
      Left = 8
      Top = 32
      Width = 93
      Height = 13
      Caption = #1053#1086#1084#1077#1088' '#1089#1083#1086#1090#1072', 0..4:'
    end
    object lblSlotStatus0: TLabel
      Left = 8
      Top = 144
      Width = 98
      Height = 13
      Caption = #1057#1086#1089#1090#1086#1103#1085#1080#1077' '#1089#1083#1086#1090#1072' 0:'
    end
    object lblSlotStatus1: TLabel
      Left = 8
      Top = 168
      Width = 98
      Height = 13
      Caption = #1057#1086#1089#1090#1086#1103#1085#1080#1077' '#1089#1083#1086#1090#1072' 1:'
    end
    object lblSlotStatus2: TLabel
      Left = 8
      Top = 192
      Width = 98
      Height = 13
      Caption = #1057#1086#1089#1090#1086#1103#1085#1080#1077' '#1089#1083#1086#1090#1072' 2:'
    end
    object lblSlotStatus3: TLabel
      Left = 8
      Top = 216
      Width = 98
      Height = 13
      Caption = #1057#1086#1089#1090#1086#1103#1085#1080#1077' '#1089#1083#1086#1090#1072' 3:'
    end
    object lblSlotStatus4: TLabel
      Left = 8
      Top = 240
      Width = 98
      Height = 13
      Caption = #1057#1086#1089#1090#1086#1103#1085#1080#1077' '#1089#1083#1086#1090#1072' 4:'
    end
    object cbSlotNumber: TComboBox
      Left = 136
      Top = 32
      Width = 121
      Height = 21
      Hint = 'SlotNumber'
      Style = csDropDownList
      Anchors = [akLeft, akTop, akRight]
      ItemHeight = 13
      TabOrder = 0
      Items.Strings = (
        '0'
        '1'
        '2'
        '3'
        '4')
    end
    object btnMifarePlusSelectSlot: TButton
      Left = 264
      Top = 32
      Width = 129
      Height = 25
      Hint = 'MifarePlusSelectSlot'
      Anchors = [akTop, akRight]
      Caption = #1055#1077#1088#1077#1082#1083#1102#1095#1077#1085#1080#1077' '#1089#1083#1086#1090#1072
      TabOrder = 3
      OnClick = btnMifarePlusSelectSlotClick
    end
    object seOptionalValue: TSpinEdit
      Left = 136
      Top = 56
      Width = 121
      Height = 22
      Hint = 'OptionalValue'
      Anchors = [akLeft, akTop, akRight]
      MaxValue = 65535
      MinValue = 0
      TabOrder = 1
      Value = 1
    end
    object chbUseOptional: TCheckBox
      Left = 8
      Top = 88
      Width = 249
      Height = 17
      Hint = 'UseOptional'
      Caption = #1055#1077#1088#1077#1076#1072#1074#1072#1090#1100' '#1076#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1081' '#1073#1072#1081#1090
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
    object edtSlotNumber: TEdit
      Left = 120
      Top = 120
      Width = 137
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 4
    end
    object edtSlotStatus0: TEdit
      Left = 120
      Top = 144
      Width = 137
      Height = 21
      Hint = 'SlotStatus0'
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 5
    end
    object edtSlotStatus1: TEdit
      Left = 120
      Top = 168
      Width = 137
      Height = 21
      Hint = 'SlotStatus1'
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 6
    end
    object edtSlotStatus2: TEdit
      Left = 120
      Top = 192
      Width = 137
      Height = 21
      Hint = 'SlotStatus2'
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 7
    end
    object edtSlotStatus3: TEdit
      Left = 120
      Top = 216
      Width = 137
      Height = 21
      Hint = 'SlotStatus3'
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 8
    end
    object edtSlotStatus4: TEdit
      Left = 120
      Top = 240
      Width = 137
      Height = 21
      Hint = 'SlotStatus4'
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 9
    end
  end
end
