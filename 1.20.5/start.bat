@echo off

echo container@pterodactyl~ Server marked as running...
echo Hashes differ. Downloading requirements

if not exist plugins mkdir plugins
if not exist server.jar curl -o server.jar https://api.papermc.io/v2/projects/paper/versions/1.20.5/builds/22/downloads/paper-1.20.5-22.jar
if not exist plugins\ViaVersion.jar curl -o plugins\ViaVersion.jar https://basichtml.ignorelist.com/ViaVersion-5.0.1.jar
if not exist plugins\ViaBackwards.jar curl -o plugins\ViaBackwards.jar https://basichtml.ignorelist.com/ViaBackwards-5.0.1.jar
if not exist server.properties curl -o server.properties https://basichtml.ignorelist.com/server.properties
echo container@pterodactyl~ java -version
java -version
echo container@pterodactyl~ ./run ./start.sh -port 25565 -uptime true -memory Xmx3156M Xms3156M
echo container@pterodactyl~ Server marked as starting or online...
java -Xmx3156M -Xms3156M -jar server.jar nogui
echo container@pterodactyl~ Server marked as offline.
pause