@echo off

echo container@pterodactyl~ Server marked as running...
echo Hashes differ. Downloading requirements

if not exist plugins mkdir plugins
if not exist eula.txt (
    (
        echo # By changing the setting below to TRUE you are indicating your agreement to our EULA ^(https://aka.ms/MinecraftEULA^).
        echo # %date% %time%
        echo eula=true
    ) > eula.txt
)
if not exist server.jar curl -o server.jar https://api.papermc.io/v2/projects/paper/versions/1.20.1/builds/196/downloads/paper-1.20.1-196.jar
if not exist plugins\ViaVersion.jar curl -o plugins\ViaVersion.jar https://basichtml.ignorelist.com/ViaVersion-5.0.1.jar
if not exist plugins\ViaBackwards.jar curl -o plugins\ViaBackwards.jar https://basichtml.ignorelist.com/ViaBackwards-5.0.1.jar
if not exist server.properties curl -o server.properties https://basichtml.ignorelist.com/server.properties
echo container@pterodactyl~ java -version
java -version
echo container@pterodactyl~ java -Xmx3156M -Xms3156M -jar server.jar nogui
echo container@pterodactyl~ Server marked as starting or online...
java -Xmx3156M -Xms3156M -jar server.jar nogui
echo container@pterodactyl~ Server marked as offline.
pause
