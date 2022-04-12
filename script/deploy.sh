# deploy macos
flutter clean
flutter pub get
flutter build macos
cd ../installers/macos
rm shinobi_tool.dmg
npx appdmg ./config.json ./shinobi_tool.dmg


