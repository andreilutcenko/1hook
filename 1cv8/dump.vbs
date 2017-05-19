Set WShell=WScript.CreateObject("WScript.Shell")

If WScript.Arguments.Count <> 1 Then
	WScript.Quit 0
End If

epfFile = WScript.Arguments(0)

srcDir = "C:\files\repo\mfo_epf\src\" & epfFile
Set FSO = CreateObject("Scripting.FileSystemObject")
If Not FSO.FolderExists(srcDir) Then 
	FSO.CreateFolder(srcDir)
End If

Dump = """C:\Program Files (x86)\1cv8\8.3.9.2170\bin\1cv8.exe"" DESIGNER /F""C:\files\repo\sysdb"" /DumpExternalDataProcessorOrReportToFiles """ & srcDir & """ ""C:\files\repo\mfo_epf\" & epfFile & """ -Format Hierarchical"
'MsgBox Dump
WShell.Run Dump, 0, True