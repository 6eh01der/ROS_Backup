# ROS_Backup
MikroTik RouterOS backup script

Based on some code parts from https://github.com/beeyev/Mikrotik-RouterOS-automatic-backup-and-update/blob/master/BackupAndUpdate.rsc

Variables:

smtpSRVbyName - set value as "true" (without quotes) if smtp server must be set by name
smtpServerName - set smtp server name if smtp server must be set by name
smtpServerIP - set smtp server ip address if smtp server must be set by ip
saveSysBackup - set value as "true" (without quotes) if system backup must be created
encryptSysBackup - set value as "true" (without quotes) if system backup must be encrypted
saveRawExport - set value as "true" (without quotes) if raw configuration script must be exported
ftpSRVbyName - set value as "true" (without quotes) if ftp server must be set by name
ftpServerName - set ftp server name if ftp server must be set by name
ftpServerIP - set ftp server ip address if ftp server must be set by ip
ftpPort - ftp server port
ftpUser - ftp server user
ftpPass - ftp server password
backupPassword - encryption password
