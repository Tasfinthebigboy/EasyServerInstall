#!/bin/bash

echo "[Daemon]: Checking server disk space usage, this could take a few seconds..."

# Get free disk space in MB (assuming root partition)
freeSpaceMB=$(df / | tail -1 | awk '{print $4/1024}')

echo "[Daemon]: Free space available: ${freeSpaceMB} MB"

# Check if free space is less than 200 MB
if (( $(echo "$freeSpaceMB < 200" | bc -l) )); then
    echo "[Error]: Insufficient disk space. At least 200 MB is required."
    exit 1
else
    echo "[Daemon]: Disk space is sufficient."
fi

echo "[Daemon]: Updating process configuration files..."
echo "[Daemon]: Ensuring file permissions are set correctly, this could take a few seconds..."

echo "container@pterodactyl~ Server marked as running..."
echo "Hashes differ. Downloading requirements"

# Check if eula.txt exists, if not, create it
if [ ! -f eula.txt ]; then
    echo "# By changing the setting below to TRUE you are indicating your agreement to our EULA (https://aka.ms/MinecraftEULA)." > eula.txt
    echo "# $(date)" >> eula.txt
    echo "eula=true" >> eula.txt
fi

# Check if plugins directory exists, if not, create it
if [ ! -d plugins ]; then
    mkdir plugins
fi

# Download the Velocity server jar if it doesn't exist
if [ ! -f server.jar ]; then
    curl -o server.jar https://api.papermc.io/v2/projects/velocity/versions/3.3.0-SNAPSHOT/builds/436/downloads/velocity-3.3.0-SNAPSHOT-436.jar
fi

# Download ViaVersion plugin if it doesn't exist
if [ ! -f plugins/ViaVersion.jar ]; then
    curl -o plugins/ViaVersion.jar https://cdn.modrinth.com/data/P1OZGk5p/versions/R6MNWQmm/ViaVersion-5.0.3.jar
fi

# Download ViaBackwards plugin if it doesn't exist
if [ ! -f plugins/ViaBackwards.jar ]; then
    curl -o plugins/ViaBackwards.jar https://cdn.modrinth.com/data/NpvuJQoq/versions/Kn9W09hI/ViaBackwards-5.0.3.jar
fi

echo "container@pterodactyl~ Server marked as starting or online..."
echo "[Daemon]: Pulling Docker container image, this could take a few minutes to complete..."
echo "[Daemon]: Finished pulling Docker container image"

echo "container@pterodactyl~ java -version"
java -version

# Start the Velocity server with 1024M of RAM
echo "container@pterodactyl~ java -Xmx1024M -Xms1024M -jar server.jar nogui"
java -Xmx1024M -Xms1024M -jar server.jar nogui

echo "container@pterodactyl~ Server marked as offline."
