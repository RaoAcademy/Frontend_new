rm -r ~/.pub-cache
rm -r ./pubspec.lock
flutter clean
flutter channel stable
flutter upgrade
flutter pub get
flutter pub cache clean
flutter pub cache repair
flutter precache
dart pub upgrade
dart pub outdated
dart pub upgrade --major-versions
flutter packages upgrade
flutter doctor
flutter pub run build_runner build --delete-conflicting-outputs
flutter pub get -v
