Attribute VB_Name = "fomatNumbers"
Option Explicit

Sub test()

    Dim nFormat As numberFormatter
    Set nFormat = New numberFormatter
    
    Debug.Print nFormat.NumberFormat("0,000", "�~", Positive_Negative_Zero, BlueBlack, "��", RedPurple, LightGreen)
    
End Sub
