Attribute VB_Name = "FormatSheet"
Option Explicit

''
' �X�^�C�����쐬���ăe�[�u���ɐݒ肷��
'
Public Sub FormatSheet()

    Dim myFormat As AutoFormat
    Set myFormat = New AutoFormat

    Call myFormat.Apply(ActiveSheet)

End Sub

''
' Excel�̕W���t�H���g���C������
'
Public Sub ModifyExcelFont()

    Dim myFormat As AutoFormat
    Set myFormat = New AutoFormat

    Call myFormat.SetExcelFont(ActiveWorkbook)

End Sub
