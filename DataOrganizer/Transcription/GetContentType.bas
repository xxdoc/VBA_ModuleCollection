Attribute VB_Name = "GetDataType"
Option Explicit

Enum eDataType
    edSOMETHING = 0
    edHEADER_RawData
    edDate
    edHEADER_Image
    edHEADER_Date
    edHEADER_UserId
    edUserId
    edHEADER_UserName
    edUserName
    edHEADER_body
    edLine
End Enum

Sub GetDataType()

    Dim pi As New PerformanceImprovement
    pi.WaitingAnime

    '�f�[�^�e�[�u���̏�����
    Dim dataTypeList As ListObject
    Set dataTypeList = shDataType.ListObjects(1)

    If Not (dataTypeList.DataBodyRange Is Nothing) Then
        dataTypeList.DataBodyRange.Delete
    End If

    '�ŏI�s���擾
    Dim lastRow As Long
    With shRawData
        lastRow = .Cells(.Rows.Count, 1).End(xlUp).Row
    End With

    Dim valueType As eDataType
    valueType = 0

    Dim dataTypeSheetValues() As Variant
    ReDim dataTypeSheetValues(lastRow - 1)

    '�~���ɑ���
    Dim i As Long
    Dim dataTypeListRow As Long: dataTypeListRow = 2
    For i = lastRow To 1 Step -1

        '�X�e�[�^�X�o�[
        pi.WaitingAnime (dataTypeListRow)

        Dim val As Variant
        val = shRawData.Cells(i, 1).Value

        Select Case val
            Case "�������ɓ\��t���Ă��������B"
                valueType = edHEADER_RawData

            Case "�摜�����M����܂���"
                valueType = edHEADER_Image

            Case "���b�Z�[�W���͂��܂���"
                valueType = edHEADER_Date

            Case "ID"
                valueType = edHEADER_UserId

            Case "���[�U��"
                valueType = edHEADER_UserName

            Case "�{��"
                valueType = edHEADER_body

            Case Else
                Select Case valueType
                    Case edHEADER_Date
                        If VarType(val) = vbString Then
                            If InStr(val, "kaguya�A�v��") = 0 _
                           And InStr(val, ":") = 0 Then

                                valueType = edLine
                            Else
                                valueType = edDate
                            End If

                        Else
                            valueType = edDate
                        End If

                    Case edDate
                        valueType = edLine

                    Case edHEADER_UserId
                        valueType = edHEADER_Date

                    Case edHEADER_UserName
                        valueType = edUserId

                    Case edHEADER_body
                        valueType = edUserName

                    Case Else
                        valueType = edLine
                End Select

        End Select

        '���X�g�ɒǉ�
        Dim rowValues As Variant
        rowValues = Array(i, val, valueType)
        dataTypeSheetValues(dataTypeListRow - 2) = rowValues

        dataTypeListRow = dataTypeListRow + 1
    Next

    '�V�[�g�ɓ\�t�ł���悤�ɕϊ�
    dataTypeSheetValues = get2dValues(dataTypeSheetValues)

    '��s������Βu������
    For dataTypeListRow = 0 To UBound(dataTypeSheetValues, 1)
        If dataTypeListRow = UBound(dataTypeSheetValues, 1) Then Exit For

        If dataTypeSheetValues(dataTypeListRow, 2) <> eDataType.edDate Then GoTo continue:
        If dataTypeSheetValues(dataTypeListRow + 1, 1) <> "" Then GoTo continue:

        dataTypeSheetValues(dataTypeListRow + 1, 2) = 0
continue:
    Next

    '�\�ɏo��
    shDataType.Cells(2, 1).Resize(UBound(dataTypeSheetValues, 1) + 1, _
                                  UBound(dataTypeSheetValues, 2) + 1).Value = dataTypeSheetValues

    '�����ɖ߂�
    Dim list As ListObject
    Set list = shDataType.ListObjects(1)
    list.Range.Sort Key1:=shDataType.Cells(1, 1), _
                    Order1:=xlAscending, _
                    Header:=xlYes, _
                    Orientation:=xlTopToBottom, _
                    SortMethod:=xlPinYin

End Sub

''
' 2�w�ɂȂ����z���񎟌��z��ɒu��������
' �y�Q�Ɓz
' https://qiita.com/11295/items/7364a80814bca5b734ff
'
' @param {array} [arr(0)(0)]���̔z��
'
' @return {array} [arr(0,0)]���̔z��
'
Private Function get2dValues(ByRef nest2dArr As Variant) As Variant

    Dim ret() As Variant
    ReDim ret(0 To UBound(nest2dArr), 0 To UBound(nest2dArr(0)))

    Dim r As Long: r = 0
    Dim rowData As Variant
    For Each rowData In nest2dArr
        Dim c As Long: c = 0
        Dim element As Variant
        For Each element In rowData
            ret(r, c) = element
            c = c + 1
        Next
        r = r + 1
    Next

    get2dValues = ret
End Function
