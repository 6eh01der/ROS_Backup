:local smtpSRVbyName
:local smtpServerName
:local smtpServerIP
:local saveSysBackup
:local encryptSysBackup
:local saveRawExport

:local ftpSRVbyName
:local ftpServerName
:local ftpServerIP
:local ftpPort
:local ftpUser
:local ftpPass
:local backupPassword

:local ts [/system clock get time]
:set ts ([:pick $ts 0 2].[:pick $ts 3 5].[:pick $ts 6 8])

:local ds [/system clock get date]
:set ds ([:pick $ds 7 11].[:pick $ds 0 3].[:pick $ds 4 6])

:local fname ("BACKUP-".[/system identity get name]."-".$ds."-".$ts)
:local sfname ("/".$fname)

:if ($smtpSRVbyName) do={
  :local smtpServerIP [:put [:resolve $smtpServerName]]
}

:if ($ftpSRVbyName) do={
  :local ftpServerIP [:put [:resolve $ftpServerName]]
}

:if ($saveSysBackup) do={
  :if ($encryptSysBackup) do={ /system backup save password=$backupPassword name=($sfname.".backup") }
  else={ /system backup save dont-encrypt=yes name=($sfname.".backup") }
  :log info message="System Backup Finished"
}

if ($saveRawExport) do={
  /export file=($sfname.".rsc")
  :log info message="Raw configuration script export Finished"
}

:local backupFileName ""

:foreach backupFile in=[/file find] do={
  :set backupFileName ("/".[/file get $backupFile name])
  :if ([:typeof [:find $backupFileName $sfname]] != "nil") do={
    /tool fetch address=$ftpServerIP port=$ftpPort src-path=$backupFileName user=$ftpUser mode=ftp password=$ftpPass dst-path="/BACKUP_FOLDER/$backupFileName" upload=yes
  }
}

:delay 5s

:foreach backupFile in=[/file find] do={
  :if ([:typeof [:find [/file get $backupFile name] "BACKUP-"]]!="nil") do={
    /file remove $backupFile
  }
}

:log info message="Successfully removed Temporary Backup Files"
:log info message="Automatic Backup Completed Successfully"

:tool e-mail set address=$smtpServerIP
:tool e-mail set port=25
:tool e-mail set from=mikrotik@contoso.com

:tool e-mail send to="admin@contoso.com" subject="$[/system identity get name]" body="Automatic Backup Completed Successfully" start-tls=yes