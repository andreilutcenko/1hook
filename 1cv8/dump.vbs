If WScript.Arguments.Count <> 2 Then
	WScript.Quit 0
End If

inDir = WScript.Arguments(0)
inDir = Replace(inDir, "/", "\")

inFile = WScript.Arguments(1)
inFile = Replace(inFile, "/", "\")

srcDir = inDir & "\src\" & inFile

Set FSO = CreateObject("Scripting.FileSystemObject")
srcDirTree = Split(srcDir, "\")
For i = 0 To UBound(srcDirTree)
	If srcDirTree(i) <> "" Then
		srcDirNext = srcDirNext & srcDirTree(i) & "\"
		If Not FSO.FolderExists(srcDirNext) Then
			FSO.CreateFolder(srcDirNext)
		End If
	End If
Next

bin1C = ""
Set fileConf = FSO.OpenTextFile(inDir & "\.git\hooks\1cv8\dump.conf", 1, False)
Do While Not fileConf.AtEndOfStream
	bin1C = Trim(fileConf.ReadLine)
	Exit Do
Loop
fileConf.Close

If Len(bin1C) = 0 Then
	WScript.Quit 0
End If

bin1C = """" & bin1C & """"
sysdb = """" & inDir & "\.git\hooks\1cv8\sysdb"""

Dump = bin1C & " DESIGNER /F" & sysdb & " /DumpExternalDataProcessorOrReportToFiles """ & srcDir & """ """ & inDir & "\" & inFile & """ -Format Hierarchical"

Set WShell = WScript.CreateObject("Wscript.Shell")
WShell.Run Dump, 0, True
