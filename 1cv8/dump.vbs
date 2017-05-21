Set WShell=WScript.CreateObject("WScript.Shell")

If WScript.Arguments.Count <> 1 Then
	WScript.Quit 0
End If
inFile = WScript.Arguments(0)

inFile = Replace(inFile, "/", "\")
srcDir = "C:\files\repo\mfo_epf\src\" & inFile

Set FSO = CreateObject("Scripting.FileSystemObject")
srcDirTree = Split(srcDir, "\")
For i = 0 To UBound(srcDirTree)
	If srcDirTree(i) <> "" Then
		srcDirNext = srcDiraa & srcDirTree(i) & "\"
		If Not FSO.FolderExists(srcDirNext) Then
			FSO.CreateFolder(srcDirNext)
		End If
	End If
Next

Dump = """C:\Program Files (x86)\1cv8\8.3.10.2252\bin\1cv8.exe"" DESIGNER /F""C:\files\repo\sysdb"" /DumpExternalDataProcessorOrReportToFiles """ & srcDir & """ ""C:\files\repo\mfo_epf\" & inFile & """ -Format Hierarchical"
WShell.Run Dump, 0, True