object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'How to Run SSRS Reports Locally'
  ClientHeight = 717
  ClientWidth = 926
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OnCreate = FormCreate
  DesignSize = (
    926
    717)
  TextHeight = 13
  object ClrContainer1: TClrContainer
    Left = 2
    Top = 3
    Width = 916
    Height = 680
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'ClrContainer1'
    TabOrder = 0
    ExplicitWidth = 912
    ExplicitHeight = 679
  end
  object Button1: TButton
    Left = 843
    Top = 686
    Width = 75
    Height = 28
    Anchors = [akRight, akBottom]
    Caption = 'Close'
    TabOrder = 1
    OnClick = Button1Click
    ExplicitLeft = 839
    ExplicitTop = 685
  end
  object Button2: TButton
    Left = 732
    Top = 686
    Width = 109
    Height = 28
    Anchors = [akRight, akBottom]
    Caption = 'Generate RDL'
    TabOrder = 2
    OnClick = Button2Click
    ExplicitLeft = 728
    ExplicitTop = 685
  end
end
