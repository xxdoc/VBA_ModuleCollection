VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} MainForm 
   Caption         =   "���t�I��"
   ClientHeight    =   5580
   ClientLeft      =   120
   ClientTop       =   465
   ClientWidth     =   3675
   OleObjectBlob   =   "MainForm.frx":0000
   StartUpPosition =   1  '�I�[�i�[ �t�H�[���̒���
End
Attribute VB_Name = "MainForm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub CommandButton1_Click()
  
  isDateClicked = False '���Z�b�g
  
  '���t�̗L���ŏ����𕪂���
  If IsDate(Me.TextBox1) Then
    clickedDate = Me.TextBox1 '�e�L�X�g�{�b�N�X�̓��t���i�[
  
  Else
    clickedDate = Date '�����̓��t���i�[
  
  End If
  
  '�J�����_�[�ŃN���b�N���ꂽ���t�����
  CalendarForm.Show
  If isDateClicked Then Me.TextBox1 = Format(clickedDate, "yyyy/mm/dd")

End Sub
