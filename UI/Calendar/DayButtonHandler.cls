VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "DayButtonHandler"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

''
' �C�x���g�����p�̕ϐ�
'
Private WithEvents Target As MSForms.Label
Attribute Target.VB_VarHelpID = -1

''
' �{�^�����i�[
'
Public Sub Add(newControl As MSForms.Label)
    Set Target = newControl
End Sub

''
' �N���b�N�C�x���g
'
Private Sub Target_Click()
    
    If Target.Caption = "" Then Exit Sub '���x�����󂾂����璆�~
    
    '���t�𐶐����ĕϐ��Ɋi�[
    With CalendarForm
        clickedDate = .YearBox & "/" & .MonthBox & "/" & Target.Caption
    End With
    
    isDateClicked = True '�t���O�𗧂Ă�
    
    '�J�����_�[����ďI��
    Unload CalendarForm

End Sub