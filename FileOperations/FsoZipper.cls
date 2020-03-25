VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "FsoZipper"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Private pFso As Object

Private Sub Class_Initialize()

    Set pFso = CreateObject("Scripting.FileSystemObject")

End Sub

''
' �t�@�C���E�t�H���_��ZIP�`���ň��k
'
' �y�Q�l�z
' ZIP�`���ň��k�E�𓀂��s��VBA�}�N�� | ���S�Ҕ��Y�^
' https://www.ka-net.org/blog/?p=7605
'
' @param {Variant} SrcPath        ���t�@�C���E�t�H���_
' @param {Variant} DestFolderPath �o�͐�i�w�肵�Ȃ��ꍇ�͌��t�@�C���E�t�H���_�Ɠ����ꏊ�j
'
Public Sub Zip(ByVal SrcPath As Variant, _
               Optional ByVal DestFolderPath As Variant = "")
    
    With pFso
        '�p�X�̎�ނ��`�F�b�N
        If isFolder(DestFolderPath) = False Then
            If isFolder(SrcPath) = True Then
                DestFolderPath = SrcPath
            
            ElseIf isFile(SrcPath) = True Then
                DestFolderPath = .GetFile(SrcPath).ParentFolder.Path
            
            Else
                Exit Sub
            
            End If
        End If
        
        '�o�͐�̐ݒ�
        Dim DestFilePath As Variant
        DestFilePath = addPathSeparator(DestFolderPath) & .GetBaseName(SrcPath) & ".zip"
        
        '���ZIP�t�@�C�����쐬
        With .CreateTextFile(DestFilePath, True)
          .Write ChrW(&H50) & ChrW(&H4B) & ChrW(&H5) & ChrW(&H6) & String(18, ChrW(0))
          .Close
        End With
    
    End With
     
    'ZIP�t�@�C���ɃR�s�[���i�[
    With CreateObject("Shell.Application")
        With .Namespace(DestFilePath)
            .CopyHere SrcPath
            
            While .Items.Count < 1
                DoEvents
            Wend
        End With
    End With

End Sub

''
' ZIP�t�@�C������
'
' �y�Q�l�z
' ZIP�`���ň��k�E�𓀂��s��VBA�}�N�� | ���S�Ҕ��Y�^
' https://www.ka-net.org/blog/?p=7605
'
' @param {Variant} SrcPath        ���t�@�C��
' @param {Variant} DestFolderPath �o�͐�i�w�肵�Ȃ��ꍇ�͌��t�@�C���E�t�H���_�Ɠ����ꏊ�j
'                                 ���o�͐�ɓ����t�@�C�����������ꍇ�̓��[�U�[���f�ŏ���
'
Public Sub UnZip(ByVal SrcPath As Variant, _
                 Optional ByVal DestFolderPath As Variant = "")
  
    '���s�O�`�F�b�N
    With pFso
        If .FileExists(SrcPath) = False Then Exit Sub               '���݊m�F
        If LCase(.GetExtensionName(SrcPath)) <> "zip" Then Exit Sub '�g���q
        
        '�t�@�C�����w�肵�Ă���ꍇ�́A���̐e�t�H���_�ɕύX
        If isFolder(DestFolderPath) = False Then
            DestFolderPath = .GetFile(SrcPath).ParentFolder.Path
        End If
    End With
    
    '��
    With CreateObject("Shell.Application")
        .Namespace(DestFolderPath).CopyHere .Namespace(SrcPath).Items
    End With
End Sub
 
''
' �w��̃p�X���t�H���_�ł��邩�m�F����
'
' �y�Q�l�z
' ZIP�`���ň��k�E�𓀂��s��VBA�}�N�� | ���S�Ҕ��Y�^
' https://www.ka-net.org/blog/?p=7605
'
' @param {String} SrcPath �m�F����p�X
'
' @return {Boolean} �t�H���_���ǂ���
'
Private Function isFolder(ByVal SrcPath As String) As Boolean
    isFolder = pFso.FolderExists(SrcPath)
End Function
 
''
' �w��̃p�X���t�@�C���ł��邩�m�F����
'
' �y�Q�l�z
' ZIP�`���ň��k�E�𓀂��s��VBA�}�N�� | ���S�Ҕ��Y�^
' https://www.ka-net.org/blog/?p=7605
'
' @param {String} SrcPath �m�F����p�X
'
' @return {Boolean} �t�@�C�����ǂ���
'
Private Function isFile(ByVal SrcPath As String) As Boolean
    isFile = pFso.FileExists(SrcPath)
End Function
 
''
' ��؂蕶����}��
'
' �y�Q�l�z
' ZIP�`���ň��k�E�𓀂��s��VBA�}�N�� | ���S�Ҕ��Y�^
' https://www.ka-net.org/blog/?p=7605
'
' @param {String} SrcPath ���̃p�X
'
' @return {String} �}����̃p�X
'
Private Function addPathSeparator(ByVal SrcPath As String) As String
  
    If Right(SrcPath, 1) <> ChrW(92) Then SrcPath = SrcPath & ChrW(92)
    addPathSeparator = SrcPath

End Function