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

echo "Installing dependencies..."

yarn --cwd "$TARGET" install
yarn --cwd "$TARGET" add -D @types/react
yarn --cwd "$TARGET" add -D @types/react-native

install react-native-navigation-bar-color
install react-native-safe-area-context
install react-native-gesture-handler
install react-native-svg-transformer
install react-native-screens
install react-native-svg
install expo-status-bar

install @react-navigation/native
install @react-navigation/stack
install react-native-paper

# required by react-navigation
sed -i 's/\(public class MainActivity extends ReactActivity {\)/import android.os.Bundle;\n\n\1\n\n  @Override\n  protected void onCreate(Bundle savedInstanceState) {\n    super.onCreate(null);\n  }/' "$TARGET"/android/app/src/main/java/com/*/MainActivity.java

echo "Importing skeleton files..."

cp -r template-files/* "$TARGET"
cp template-files/.* "$TARGET" >/dev/null 2>/dev/null

echo "Process complete!"
