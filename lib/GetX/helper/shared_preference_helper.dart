import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user_model.dart';



 SharedPreferences? _sharedPreferences;

class SharedPreferenceHelper {
  static const String _USER = 'SharedPreferenceHelper.user';

  static final SharedPreferenceHelper instance = SharedPreferenceHelper._internal();

  SharedPreferenceHelper._internal();

  static void initializeSharedPreference() {
     SharedPreferences.getInstance().then((value) => _sharedPreferences = value);
  }

  Future<void> storeUser(UserModel user) async {
    final userSerialization = json.encode(user.toJson());
    print(userSerialization);
    _sharedPreferences?.setString(_USER, userSerialization);
  }

  Future<UserModel?> user() async {
     final  userSerialization =  _sharedPreferences?.getString(_USER);
     print(userSerialization);
     print('get string');
    if (userSerialization == null) return null;
    print(json.decode(userSerialization));
    return UserModel.fromJson((await json.decode(userSerialization)));
  }

  Future<void> clear() async => await _sharedPreferences?.clear();
}
