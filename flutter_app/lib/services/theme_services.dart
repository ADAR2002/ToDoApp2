import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
class ThemeServices {

  final GetStorage _box = GetStorage();
  final _key = 'isDarkMode';

  _saveMode(bool isMode) {
    return _box.write(_key, isMode);
  }

  bool  _loadMode() => _box.read(_key) ?? false;

  ThemeMode  get theme => _loadMode() ? ThemeMode.dark : ThemeMode.light;

  modeSwitch() {
    Get.changeThemeMode(_loadMode() ? ThemeMode.dark : ThemeMode.light);
    _saveMode(!_loadMode());

  }
}