object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Load WPF Control in VCL'
  ClientHeight = 471
  ClientWidth = 646
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OnDestroy = FormDestroy
  OnShow = FormShow
  DesignSize = (
    646
    471)
  TextHeight = 13
  object lblAddress: TLabel
    Left = 32
    Top = 363
    Width = 39
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'Address'
  end
  object lblName: TLabel
    Left = 32
    Top = 401
    Width = 27
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'Name'
  end
  object lblCity: TLabel
    Left = 32
    Top = 382
    Width = 19
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'City'
  end
  object lblState: TLabel
    Left = 32
    Top = 420
    Width = 26
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'State'
  end
  object lblZip: TLabel
    Left = 32
    Top = 439
    Width = 14
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'Zip'
  end
  object ClrContainer1: TClrContainer
    Left = 8
    Top = 8
    Width = 626
    Height = 337
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'ClrContainer1'
    TabOrder = 0
    ExplicitWidth = 622
    ExplicitHeight = 336
  end
end
