. "C:\Users\champuser\TechJournal-SYS320-CSI230\Week6\Local-User-Management-Menu\Event-Logs.ps1"
. "C:\Users\champuser\TechJournal-SYS320-CSI230\Week7\Scheduled_Email_Reports\email.ps1"
. "C:\Users\champuser\TechJournal-SYS320-CSI230\Week7\Scheduled_Email_Reports\configuration.ps1"
. "C:\Users\champuser\TechJournal-SYS320-CSI230\Week7\Scheduled_Email_Reports\scheduler.ps1"

#File_Path
$file_path = "~\TechJournal-SYS320-CSI230\Week7\Scheduled_Email_Reports\configuration.txt"

# Obtaining configuration
$configuration = readConfiguration $file_path

# Obtaining at risk users
$Failed = getRiskUsers $configuration."Days Evaluating"

# Sending at risk users as email
SendAlertEmail ($Failed | Format-Table | Out-String)

# Setting the script to be run daily
ChooseTimeToRun $configuration."Time Scheduled"