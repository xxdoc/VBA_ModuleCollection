Attribute VB_Name = "FormatData"
Option Explicit

Sub FormatMessageData()

    Dim pi As New PerformanceImprovement
    pi.WaitingAnime

    Dim dataList As ListObject
    Dim dataListValues As Variant
    Set dataList = shDataType.ListObjects(1)
    dataListValues = dataList.DataBodyRange.Value

    '�ϐ��̏�����
    Dim recordCounts As Long: recordCounts = 1
    Dim record As New MessageRecord: record.Init (recordCounts) '�o��1�s��

    Dim records As MessageRecords: Set records = New MessageRecords

    '�f�[�^�̍s��������
    Dim r As Long
    For r = 1 To UBound(dataListValues)
        '�X�e�[�^�X�o�[
        pi.WaitingAnime r

        '���݂̃f�[�^
        Dim dataValue As Variant: dataValue = dataListValues(r, 2)
        Dim dataType As eDataType: dataType = dataListValues(r, 3)

        '�f�[�^�E�^�C�v�ɂ���ĐU�蕪��
        Select Case dataType
            Case eDataType.edHEADER_RawData

            Case eDataType.edDate

                If VarType(dataValue) = vbString Then
                    If InStr(dataValue, "kaguya") = 0 Then
                         dataType = edLine
                         GoTo pushLine:

                    Else
                        dataValue = TimeValue(Right(dataValue, 5)) '�\�L�̓���

                    End If
                End If

                record.PostTime = dataValue

            Case eDataType.edHEADER_Image
                record.HasImage = True

            Case eDataType.edHEADER_Date
                '1���ڂ͔�΂�
                If recordCounts = 1 And record.UserId = "" Then GoTo continue:
                records.Add record

                '�ēx������
                Set record = New MessageRecord
                recordCounts = recordCounts + 1
                record.Init (recordCounts)

            Case eDataType.edHEADER_UserId

            Case eDataType.edUserId
                record.UserId = dataValue

            Case eDataType.edHEADER_UserName

            Case eDataType.edUserName
                record.UserName = dataValue

            Case eDataType.edHEADER_body

            Case eDataType.edLine
pushLine:
                record.Lines.Push (dataValue)

        End Select

continue:
    Next

    '�Ō�̃��R�[�h
    records.Add record

    Dim outputValues() As Variant
    ReDim outputValues(records.Items.Count - 1, 5)
    outputValues = records.GetValues

    Dim messageList As ListObject
    Set messageList = shOutput.ListObjects(1)

    Call setValues(outputValues, messageList)

End Sub

''
' �V�[�g�ɓ񎟌��z�����
'
' @param {variant} �񎟌��z��
' @param {listobject} �\��t����̃e�[�u��
'
Sub setValues(ByRef source2dArray() As Variant, _
              ByRef destinationListObj As ListObject)

    Dim bodyRange As Range
    Set bodyRange = destinationListObj.DataBodyRange

    Dim upperLeft As Range
    If bodyRange Is Nothing Then
        Set upperLeft = destinationListObj.Parent.Cells(2, 1)
    Else
        Set upperLeft = bodyRange.Cells(1, 1)
    End If

    upperLeft.Resize(UBound(source2dArray, 1) + 1, _
                     UBound(source2dArray, 2) + 1).Value = source2dArray

End Sub
