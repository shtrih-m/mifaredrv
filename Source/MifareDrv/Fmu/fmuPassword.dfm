object fmPassword: TfmPassword
  Left = 416
  Top = 167
  BorderStyle = bsDialog
  Caption = #1054#1096#1080#1073#1082#1072
  ClientHeight = 247
  ClientWidth = 366
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 8
    Top = 16
    Width = 32
    Height = 32
    AutoSize = True
    Picture.Data = {
      07544269746D617076020000424D760200000000000076000000280000002000
      0000200000000100040000000000000200000000000000000000100000000000
      0000000000000000800000800000008080008000000080008000808000008080
      8000C0C0C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
      FF00DDDDDDDDDDDDD77777777DDDDDDDDDDDDDDDDDDDDD77777777777777DDDD
      DDDDDDDDDDDDD7711111111777777DDDDDDDDDDDDDD71119999999911177777D
      DDDDDDDDDD7199999999999999177777DDDDDDDDD11999999999999999911777
      7DDDDDDD1999999999999999999991777DDDDDD1999999999999999999999917
      77DDDDD1999999999999999999999917777DDD1999999F9999999999F9999991
      777DD1999999FFF99999999FFF999999177DD199999FFFFF999999FFFFF99999
      1777D1999999FFFFF9999FFFFF9999991777199999999FFFFF99FFFFF9999999
      91771999999999FFFFFFFFFF99999999917719999999999FFFFFFFF999999999
      9177199999999999FFFFFF99999999999177199999999999FFFFFF9999999999
      917719999999999FFFFFFFF99999999991771999999999FFFFFFFFFF99999999
      917D199999999FFFFF99FFFFF9999999917DD1999999FFFFF9999FFFFF999999
      177DD199999FFFFF999999FFFFF9999917DDD1999999FFF99999999FFF999999
      1DDDDD1999999F9999999999F99999917DDDDDD1999999999999999999999917
      DDDDDDD199999999999999999999991DDDDDDDDD1999999999999999999991DD
      DDDDDDDDD11999999999999999911DDDDDDDDDDDDDD1999999999999991DDDDD
      DDDDDDDDDDDD11199999999111DDDDDDDDDDDDDDDDDDDDD11111111DDDDDDDDD
      DDDD}
    Transparent = True
  end
  object lblErrorText: TLabel
    Left = 64
    Top = 16
    Width = 297
    Height = 57
    AutoSize = False
    Caption = 'lblErrorText'
    WordWrap = True
  end
  object lblPassword: TLabel
    Left = 56
    Top = 172
    Width = 41
    Height = 13
    Caption = #1055#1072#1088#1086#1083#1100':'
  end
  object Bevel1: TBevel
    Left = 8
    Top = 208
    Width = 353
    Height = 17
    Shape = bsTopLine
  end
  object Label1: TLabel
    Left = 56
    Top = 96
    Width = 305
    Height = 65
    AutoSize = False
    Caption = 
      #1042#1074#1077#1076#1080#1090#1077' '#1087#1072#1088#1086#1083#1100' '#1076#1083#1103' '#1076#1086#1089#1090#1091#1087#1072' '#1082' '#1089#1077#1082#1090#1086#1088#1091' '#1080' '#1085#1072#1078#1084#1080#1090#1077':'#13#10#13#10'"OK" - '#1076#1083#1103' '#1091#1076 +
      #1072#1083#1077#1085#1080#1103' '#1089#1077#1082#1090#1086#1088#1072'.'#13#10'"'#1054#1090#1084#1077#1085#1072'" - '#1076#1083#1103' '#1074#1099#1093#1086#1076#1072'.'
    WordWrap = True
  end
  object edtPassword: TEdit
    Left = 112
    Top = 168
    Width = 113
    Height = 21
    TabOrder = 0
    Text = '00 01 02 03 04 05'
  end
  object btnCancel: TButton
    Left = 288
    Top = 216
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 4
  end
  object btnOK: TButton
    Left = 208
    Top = 216
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 3
    OnClick = btnOKClick
  end
  object rbText: TRadioButton
    Left = 288
    Top = 170
    Width = 57
    Height = 17
    Caption = #1058#1077#1082#1089#1090
    TabOrder = 2
  end
  object rbHex: TRadioButton
    Left = 232
    Top = 170
    Width = 49
    Height = 17
    Caption = 'Hex'
    Checked = True
    TabOrder = 1
    TabStop = True
  end
end
