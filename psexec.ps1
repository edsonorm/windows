##@echo off
cd c:\psexecinstall
psexec @hosts.txt cmd /c mkdir c:\psexecinstall
for /F %%i in (hosts.txt) do xcopy /E c:\psexecinstall \\%%i\c$\psexecinstall
psexec @hosts.txt c:\psexecinstall\vlc.exe /S
psexec @hosts.txt c:\psexecinstall\npp.exe /S
psexec @hosts.txt c:\psexecinstall\FileZilla.exe /S
psexec @hosts.txt msiexec -i c:\psexecinstall\7z.msi /qb!
psexec @hosts.txt msiexec -i c:\psexecinstall\Firefox.msi /qb!
psexec @hosts.txt msiexec -i c:\psexecinstall\googlechrome.msi /qb!
psexec @hosts.txt msiexec -i c:\psexecinstall\putty.msi /qb!
psexec @hosts.txt msiexec -i c:\psexecinstall\AcroRdr\AcroRead.msi /qb!
psexec @hosts.txt c:\psexecinstall\anydesk.exe --install  “C:\Program Files (x86)\AnyDesk” --start-with-win --create-desktop-icon --silent