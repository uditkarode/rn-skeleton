#!/bin/bash

if [ "$(git remote get-url origin)" != "https://github.com/uditkarode/rn-skeleton" ]; then
  echo "Script must be run directly from the cloned folder!"
  exit
fi

echo -n "Run 'npx react-native init' and enter the path to the freshly created project: "
read TARGET

if [ ! -d $TARGET ]; then
  echo "Invalid directory!"
fi

echo "Operating on directory: '$TARGET' which contains $(ls "$TARGET" | wc -l) files and folders"
echo "Press any key to continue, or ^C to exit"
read

echo "Enabling hermes..."
sed -i 's/\(enableHermes: \)false/\1true/' "$TARGET"/android/app/build.gradle

echo "Enabling architecture splitting..."
sed -i 's/\(enableSeparateBuildPerCPUArchitecture = \)false/\1true/' "$TARGET"/android/app/build.gradle

echo "Enabling proguard on release builds..."
sed -i 's/\(enableProguardInReleaseBuilds = \)false/\1true/' "$TARGET"/android/app/build.gradle

echo "Removing initial files and adjusting index.js accordingly..."
rm -rf "$TARGET"/__tests__
rm -f "$TARGET"/App.js
sed -i "s/\\(import App from\\).*/\1 '\.\/src\/App'\;/" "$TARGET"/index.js

function install() {
  yarn --cwd "$TARGET" add $1
}

function install-and-link() {
  install $1
  yarn --cwd "$TARGET" react-native link $1
}

echo "Installing dependencies..."

yarn --cwd "$TARGET" install
yarn --cwd "$TARGET" add -D @types/react
yarn --cwd "$TARGET" add -D @types/react-native

install-and-link react-native-navigation-bar-color
install-and-link react-native-safe-area-context
install-and-link react-native-gesture-handler
install-and-link react-native-screens
install-and-link react-native-svg
install-and-link expo-status-bar

install @react-navigation/native
install @react-navigation/stack
install react-native-paper

echo "Importing skeleton files..."
cp -r ./* "$TARGET"

echo "Process complete!"
