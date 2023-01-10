import 'package:flutter/material.dart';

class AppConfig {
  AppConfig._();

  static final AppConfig shared = AppConfig._();

  factory AppConfig() {
    return shared;
  }

  late BuildContext _context;

  BuildContext get getContext => _context;

  void setConfig(BuildContext context) {
    _context = context;
  }
}
