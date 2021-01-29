import 'package:shared_preferences/shared_preferences.dart';

Future<T> getSetting<T>(String setting) async {
  return await SharedPreferences.getInstance()
      .then((preferences) => preferences.get(setting));
}

void setSetting<T>(String setting, T value) {
  SharedPreferences.getInstance().then((preferences) {
    switch (value.runtimeType) {
      case String:
        preferences.setString(setting, value as String);
        break;
      case int:
        preferences.setInt(setting, value as int);
        break;
      case bool:
        preferences.setBool(setting, value as bool);
        break;
    }
  });
}
