VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} CalendarForm 
   Caption         =   "�J�����_�["
   ClientHeight    =   4425
   ClientLeft      =   120
   ClientTop       =   465
   ClientWidth     =   4470
   OleObjectBlob   =   "CalendarForm.frx":0000
   StartUpPosition =   1  '�I�[�i�[ �t�H�[���̒���
End
Attribute VB_Name = "CalendarForm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

'------------------------------------------------------------------------------
' �J�����_�[�R���g���[��
'
' �y�Q�l�z
' ExcelVBA�ŃJ�����_�[�R���g���[�������삷�� | *Ateitexe
' https://ateitexe.com/excel-vba-calendar-control/
'------------------------------------------------------------------------------

Private Const LAST_BUTTON As Long = 42

'�C�x���g�����p�N���X
Private dayButtons(1 To LAST_BUTTON) As New DayButtonHandler

''
' ������
'
Private Sub UserForm_Initialize()
  
    With Me
        '�N���̑I������o�^
        Dim y As Long
        For y = -3 To 3 '�O��3�N��
            .YearBox.AddItem CStr((Year(clickedDate)) + y)
        Next y
        
        Dim m As Long
        For m = 1 To 12
            .MonthBox.AddItem CStr(m)
        Next m
        
        '�N���̏����l���w��
        .YearBox = Year(clickedDate)
        .MonthBox = Month(clickedDate)
    
        '���x���̃N���b�N�C�x���g���E�����߂̏���
        Dim i As Long
        For i = LBound(dayButtons) To UBound(dayButtons)
            dayButtons(i).Add Me("Label" & i)
        Next
    End With

End Sub
 
''
' �N���ύX���ꂽ�Ƃ�
'
Private Sub YearBox_Change()
    Call setclickedDates
End Sub

''
' �����ύX���ꂽ�Ƃ�
'
Private Sub MonthBox_Change()
    Call setclickedDates
End Sub

''
' �J�����_�[�̕ҏW
'
Private Sub setclickedDates()
    
    With Me
        '�N�����ǂ��炩�����ĂȂ���Β��~
        If .YearBox = "" Or .MonthBox = "" Then Exit Sub
    End With
    
    '���x���̏�����
    Dim i As Long
    For i = 1 To LAST_BUTTON
        With Me("Label" & i)
            .Caption = ""
            .BackColor = Me.BackColor
        End With
    Next
    
    '�I��N�����擾
    With Me
        Dim yy As Long: yy = .YearBox
        Dim mm As Long: mm = .MonthBox
    
        Dim firstDateOfMonth As Date
        firstDateOfMonth = DateSerial(yy, mm, 1)
    End With
    
    '�J�����_�[�ɓ��t��\��
    Dim n As Long
    Dim endDateOfMonth As Long
    n = Weekday(firstDateOfMonth) - 1
    endDateOfMonth = Day( _
        DateAdd("d", -1, DateAdd("m", 1, firstDateOfMonth)) _
    )
    
    Dim j As Long
    For j = 1 To endDateOfMonth
        With Me("Label" & j + n)
            .Caption = j '��
            
            'TextBox�̓��t�̂ݐF�t��
            If DateSerial(yy, mm, j) <> clickedDate Then GoTo Continue
            .BackColor = RGB(255, 217, 102)
'            .ForeColor = RGB(255, 255, 255)
        End With
Continue:
    Next j

End Sub

''
' �Ђƌ��߂�
'
Private Sub SpinButton1_SpinUp()
  
  '1���̂ݔN���𒲐�
  With Me
    If .MonthBox.Value = 1 Then
      .YearBox.Value = .YearBox.Value - 1
      .MonthBox.Value = 12 '12����

    Else
      .MonthBox.Value = .MonthBox.Value - 1

    End If
  End With
  
End Sub
 
''
' �Ђƌ��i��
'
Private Sub SpinButton1_SpinDown()
  
    '12���̂ݔN���𒲐�
    With Me
        If .MonthBox.Value = 12 Then
            .YearBox.Value = .YearBox.Value + 1
            .MonthBox.Value = 1
        
        Else
            .MonthBox.Value = .MonthBox.Value + 1
        
        End If
    End With

End Sub
