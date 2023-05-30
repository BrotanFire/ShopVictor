object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Log in'
  ClientHeight = 309
  ClientWidth = 645
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -19
  Font.Name = 'Comic Sans MS'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 26
  object Label1: TLabel
    Left = 200
    Top = 72
    Width = 44
    Height = 26
    Caption = 'Login'
  end
  object Label2: TLabel
    Left = 200
    Top = 141
    Width = 82
    Height = 26
    Caption = 'Password'
  end
  object PasswordName: TEdit
    Left = 200
    Top = 173
    Width = 257
    Height = 34
    PasswordChar = '*'
    TabOrder = 0
  end
  object LoginEdit: TEdit
    Left = 200
    Top = 104
    Width = 257
    Height = 34
    TabOrder = 1
  end
  object LoginBtn: TButton
    Left = 296
    Top = 219
    Width = 75
    Height = 30
    Caption = 'Login'
    TabOrder = 2
    OnClick = LoginBtnClick
  end
  object Conn: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security In' +
      'fo=False;Initial Catalog=VictorShop;Data Source=DESKTOP-H9FO4E8;' +
      'Use Procedure for Prepare=1;Auto Translate=True;Packet Size=4096' +
      ';Workstation ID=DESKTOP-H9FO4E8;Use Encryption for Data=False;Ta' +
      'g with column collation when possible=False'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 568
    Top = 56
  end
  object AuthPC: TADOStoredProc
    Connection = Conn
    ProcedureName = 'SP_Login;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@Username'
        Attributes = [paNullable]
        DataType = ftString
        Size = 50
        Value = Null
      end
      item
        Name = '@Password'
        Attributes = [paNullable]
        DataType = ftString
        Size = 50
        Value = Null
      end
      item
        Name = '@AccountType'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = Null
      end
      item
        Name = '@AccountId'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = Null
      end>
    Left = 568
    Top = 8
  end
end
