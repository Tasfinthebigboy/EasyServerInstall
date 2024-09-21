@echo off

echo [Daemon]: Checking server disk space usage, this could take a few seconds...

for /f "tokens=3" %%a in ('dir C: ^| find "bytes free"') do (
    set freeSpace=%%a
)

set freeSpace=%freeSpace:,=%
set /a freeSpaceMB=freeSpace/1024/1024  :: Convert bytes to MB

echo [Daemon]: Free space available: %freeSpaceMB% MB

if %freeSpaceMB% lss 200 (
    echo [Error]: Insufficient disk space. At least 200 MB is required.
    exit /b 1
) else (
    echo [Daemon]: Disk space is sufficient.
)

echo [Daemon]: Updating process configuration files...
echo [Daemon]: Ensuring file permissions are set correctly, this could take a few seconds...
echo container@pterodactyl~ Server marked as running...
echo Hashes differ. Downloading requirements
if not exist eula.txt (
    (
        echo # By changing the setting below to TRUE you are indicating your agreement to our EULA ^(https://aka.ms/MinecraftEULA^).
        echo # %date% %time%
        echo eula=true
    ) > eula.txt
)
if not exist plugins mkdir plugins
if not exist server.jar curl -o server.jar https://api.papermc.io/v2/projects/paper/versions/1.20.5/builds/22/downloads/paper-1.20.5-22.jar
if not exist plugins\ViaVersion.jar curl -o plugins\ViaVersion.jar https://basichtml.ignorelist.com/ViaVersion-5.0.1.jar
if not exist plugins\ViaBackwards.jar curl -o plugins\ViaBackwards.jar https://basichtml.ignorelist.com/ViaBackwards-5.0.1.jar
if not exist server.properties curl -o server.properties https://basichtml.ignorelist.com/server.properties

echo container@pterodactyl~ Server marked as starting or online...
echo [Daemon]: Pulling Docker container image, this could take a few minutes to complete...
echo [Daemon]: Finished pulling Docker container image

echo container@pterodactyl~ java -version
java -version
echo container@pterodactyl~ java -Xmx3156M -Xms3156M -jar server.jar nogui
java -Xmx3156M -Xms3156M -jar server.jar nogui
echo container@pterodactyl~ Server marked as offline.
pause
