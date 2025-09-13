# Script de Limpeza do Windows
##
#Parando e desativando o Citrix
#
sc stop AnalyticsSrv
sc config AnalyticsSrv start= disabled
#
sc stop "Concentr Redirector"
sc config "Concentr Redirector" start= disabled
#
sc stop "redirector"
sc config "redirector" start= disabled
#
rmdir /s /q "C:\Program Files (x86)\Citrix"
#######
# Limpar a Lixeira
Clear-RecycleBin -Force

# Limpar arquivos temporários
Remove-Item -Path "$env:TEMP\*" -Recurse -Force
Remove-Item -Path "$env:SystemRoot\Temp\*" -Recurse -Force

# Limpar cache do Windows Update
Stop-Service -Name wuauserv -Force
Remove-Item -Path "$env:SystemRoot\SoftwareDistribution\Download\*" -Recurse -Force
Start-Service -Name wuauserv

# Limpar cache do navegador (Edge, Chrome, Firefox)
$edgeCache = "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Cache\*"
$chromeCache = "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Cache\*"
$firefoxCache = "$env:LOCALAPPDATA\Mozilla\Firefox\Profiles\*"

if (Test-Path $edgeCache) {
    Remove-Item -Path $edgeCache -Recurse -Force
}

if (Test-Path $chromeCache) {
    Remove-Item -Path $chromeCache -Recurse -Force
}

if (Test-Path $firefoxCache) {
    Remove-Item -Path $firefoxCache -Recurse -Force
}

# Limpar logs de eventos (opcional, use com cuidado)
# Wevtutil.exe clear-log Application
# Wevtutil.exe clear-log System
# Wevtutil.exe clear-log Security

# Limpar arquivos de pré-boot (opcional, use com cuidado)
# Remove-Item -Path "$env:SystemRoot\Prefetch\*" -Recurse -Force

# Limpar cache do DNS
ipconfig /flushdns

# Limpar cache do Windows Store
Get-AppxPackage -AllUsers | ForEach-Object {
    Remove-Item -Path "$env:LOCALAPPDATA\Packages\$($_.PackageFamilyName)\AC\*" -Recurse -Force
}

# Finalização
Write-Host "Limpeza concluída com sucesso!"

# Script para limpar a pasta %TEMP% de todos os usuários

# Obter todos os perfis de usuários no sistema
$userProfiles = Get-ChildItem -Path "C:\Users" -Directory

# Percorrer cada perfil de usuário
foreach ($profile in $userProfiles) {
    $tempPath = Join-Path -Path $profile.FullName -ChildPath "AppData\Local\Temp"

    # Verificar se a pasta Temp existe
    if (Test-Path -Path $tempPath) {
        Write-Host "Limpando a pasta Temp do usuário: $($profile.Name)"
        
        # Remover todos os arquivos e pastas dentro da pasta Temp
        Remove-Item -Path "$tempPath\*" -Recurse -Force -ErrorAction SilentlyContinue
    } else {
        Write-Host "Pasta Temp não encontrada para o usuário: $($profile.Name)"
    }
}

Write-Host "Limpeza concluída para todos os usuários!"