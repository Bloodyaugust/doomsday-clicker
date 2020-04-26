#!/bin/sh

# set -e

which butler

echo "Checking application versions..."
echo "-----------------------------"
cat ~/.local/share/godot/templates/3.2.stable/version.txt
godot --version
butler -V
echo "-----------------------------"

mkdir build/
mkdir build/linux/
mkdir build/osx/
mkdir build/win/

echo "EXPORTING FOR LINUX"
echo "-----------------------------"
godot --export "Linux/X11" build/linux/doomsday-clicker.x86_64 -v
echo "EXPORTING FOR OSX"
echo "-----------------------------"
godot --export "Mac OSX" build/osx/doomsday-clicker.dmg -v
echo "EXPORTING FOR WINDOZE"
echo "-----------------------------"
godot --export "Windows Desktop" build/win/doomsday-clicker.exe -v
echo "-----------------------------"

echo "CHANGING FILETYPE AND CHMOD EXECUTABLE FOR OSX"
echo "-----------------------------"
cd build/osx/
mv doomsday-clicker.dmg doomsday-clicker-osx-alpha.zip
unzip doomsday-clicker-osx-alpha.zip
rm doomsday-clicker-osx-alpha.zip
chmod +x doomsday-clicker.app/Contents/MacOS/doomsday-clicker
zip -r doomsday-clicker-osx-alpha.zip doomsday-clicker.app
rm -rf doomsday-clicker.app
cd ../../

ls -al
ls -al build/
ls -al build/linux/
ls -al build/osx/
ls -al build/win/

echo "ZIPPING FOR WINDOZE"
echo "-----------------------------"
cd build/win/
zip -r doomsday-clicker-win-alpha.zip doomsday-clicker.exe doomsday-clicker.pck
rm -r doomsday-clicker.exe doomsday-clicker.pck
cd ../../

echo "ZIPPING FOR LINUX"
echo "-----------------------------"
cd build/linux/
zip -r doomsday-clicker-linux-alpha.zip doomsday-clicker.x86_64 doomsday-clicker.pck
rm -r doomsday-clicker.x86_64 doomsday-clicker.pck
cd ../../

echo "Logging in to Butler"
echo "-----------------------------"
butler login

echo "Pushing builds with Butler"
echo "-----------------------------"
butler push build/linux/ synsugarstudio/doomsday-clicker:linux-alpha
butler push build/osx/ synsugarstudio/doomsday-clicker:osx-alpha
butler push build/win/ synsugarstudio/doomsday-clicker:win-alpha
