import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/dispositive.dart';
import '../../domain/entities/user.dart';

class GlobalPreference {
  static const String _dataDispositive = 'dataDispositive';
  static const String _stateLogin = 'stateLogin';
  static const String _dataUser = 'dataUser';

  /// Save data user
  Future<User> setDataUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    const JsonEncoder encoder = JsonEncoder();
    prefs.setString(_dataUser, encoder.convert(user.toMap()));
    return user;
  }

  /// Get data user
  static Future<User?> getDataUser() async {
    const JsonDecoder decoder = JsonDecoder();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user = prefs.getString(_dataUser) ?? "";
    if (user.isEmpty) {
      return null;
    }
    return User.fromMap(decoder.convert(user));
  }

  /// Set state login
  Future<bool> setStateLogin(bool state) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(_stateLogin, state);
  }

  /// Get state login
  static Future<bool> getStateLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_stateLogin) ?? false;
  }

  /// Save data dispositive
  Future<Dispositive> setDataDispositive(Dispositive? dispositive) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    const JsonEncoder encoder = JsonEncoder();
    prefs.setString(_dataDispositive, encoder.convert(dispositive!.toMap()));
    return dispositive;
  }

  /// Get data dispositive
  static Future<Dispositive?> getDataDispositive() async {
    const JsonDecoder decoder = JsonDecoder();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? dispositive = prefs.getString(_dataDispositive) ?? "";
    if (dispositive.isEmpty) {
      return null;
    }
    return Dispositive.fromMap(decoder.convert(dispositive));
  }

  /// Delete data dispositive
  static Future deleteDataDispositive() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(_dataDispositive);
  }

  /// Delete data user
  static Future deleteDataUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(_dataUser);
  }
}
