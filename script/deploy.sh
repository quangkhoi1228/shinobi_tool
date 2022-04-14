# deploy macos
current_path="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
cd $current_path
flutter pub get
flutter build macos
cd $current_path/../installers/macos
rm shinobi_tool.dmg
npx appdmg ./config.json ./shinobi_tool.dmg


open ./

