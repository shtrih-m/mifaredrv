object fmMain: TfmMain
  Left = 490
  Top = 102
  Width = 672
  Height = 619
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = #1058#1077#1089#1090' '#1076#1088#1072#1081#1074#1077#1088#1072' '#1089#1095#1080#1090#1099#1074#1072#1090#1077#1083#1077#1081' Mifare'
  Color = clBtnFace
  Constraints.MinHeight = 467
  Constraints.MinWidth = 536
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  DesignSize = (
    656
    581)
  PixelsPerInch = 96
  TextHeight = 13
  object lblResult: TLabel
    Left = 8
    Top = 492
    Width = 43
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = #1054#1096#1080#1073#1082#1072':'
  end
  object lblTime: TLabel
    Left = 8
    Top = 564
    Width = 59
    Height = 13
    Anchors = [akLeft, akBottom]
    AutoSize = False
    Caption = #1042#1088#1077#1084#1103', '#1084#1089'.:'
  end
  object Bevel: TBevel
    Left = 8
    Top = 480
    Width = 649
    Height = 17
    Anchors = [akLeft, akRight, akBottom]
    Shape = bsTopLine
  end
  object lblTxData: TLabel
    Left = 8
    Top = 516
    Width = 53
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = #1055#1077#1088#1077#1076#1072#1085#1086':'
  end
  object lblRxData: TLabel
    Left = 8
    Top = 540
    Width = 46
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = #1055#1088#1080#1085#1103#1090#1086':'
  end
  object ListBox: TListBox
    Left = 8
    Top = 8
    Width = 201
    Height = 465
    Style = lbOwnerDrawFixed
    Anchors = [akLeft, akTop, akBottom]
    ItemHeight = 18
    TabOrder = 0
    OnClick = ListBoxClick
  end
  object edtResult: TEdit
    Left = 72
    Top = 488
    Width = 449
    Height = 21
    Anchors = [akLeft, akRight, akBottom]
    Color = clBtnFace
    TabOrder = 2
  end
  object btnProperties: TButton
    Left = 528
    Top = 520
    Width = 121
    Height = 25
    Hint = 'ShowProperties'
    Anchors = [akRight, akBottom]
    Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1089#1074#1086#1081#1089#1090#1074
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
    OnClick = btnPropertiesClick
  end
  object edtTime: TEdit
    Left = 72
    Top = 560
    Width = 449
    Height = 21
    TabStop = False
    Anchors = [akLeft, akRight, akBottom]
    AutoSize = False
    Color = clBtnFace
    TabOrder = 5
  end
  object btnAbout: TButton
    Left = 528
    Top = 488
    Width = 121
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077'...'
    TabOrder = 6
    OnClick = btnAboutClick
  end
  object btnClose: TButton
    Left = 528
    Top = 552
    Width = 121
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 8
    OnClick = btnCloseClick
  end
  object pnlPage: TPanel
    Left = 216
    Top = -1
    Width = 433
    Height = 474
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    TabOrder = 1
  end
  object edtTxData: TEdit
    Left = 72
    Top = 512
    Width = 449
    Height = 21
    Anchors = [akLeft, akRight, akBottom]
    Color = clBtnFace
    TabOrder = 3
  end
  object edtRxData: TEdit
    Left = 72
    Top = 536
    Width = 449
    Height = 21
    Anchors = [akLeft, akRight, akBottom]
    Color = clBtnFace
    TabOrder = 4
  end
end
