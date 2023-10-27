flutter pub run build_runner build --delete-conflicting-outputs
flutter pub run easy_localization:generate --source-dir assets/translations -f keys -o locale_keys.g.dart
flutter pub run easy_localization:generate --source-dir assets/translations/