object fmLogParams: TfmLogParams
  Left = 400
  Top = 192
  AutoScroll = False
  Caption = #1051#1086#1075
  ClientHeight = 159
  ClientWidth = 432
  Color = clBtnFace
  Constraints.MinHeight = 176
  Constraints.MinWidth = 335
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object gbParams: TGroupBox
    Left = 8
    Top = 8
    Width = 417
    Height = 137
    Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099
    TabOrder = 0
    DesignSize = (
      417
      137)
    object lblLogFileName: TLabel
      Left = 32
      Top = 52
      Width = 96
      Height = 13
      Caption = #1055#1072#1087#1082#1072' '#1083#1086#1075' '#1092#1072#1081#1083#1086#1074':'
    end
    object chbLogEnabled: TCheckBox
      Left = 8
      Top = 24
      Width = 161
      Height = 17
      Caption = #1042#1077#1089#1090#1080' '#1083#1086#1075
      TabOrder = 0
    end
    object edtLogFilePath: TEdit
      Left = 32
      Top = 72
      Width = 369
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
    end
  end
end
