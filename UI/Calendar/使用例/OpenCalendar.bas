Attribute VB_Name = "OpenCalendar"
Option Explicit

'�J�����_�[�p�̕ϐ�
Public clickedDate As Date      '�e�L�X�g�{�b�N�X�̒l���i�[����ϐ�
Public isDateClicked As Boolean '�J�����_�[���N���b�N���ꂽ�����肷��t���O

Sub OpenForm()
  
  With MainForm
    .TextBox1 = Format(Date, "yyyy/mm/dd") '�����l
    .Show
  End With

End Sub
