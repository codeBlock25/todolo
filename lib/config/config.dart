import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

/// ## Config
/// All application config with be store here
class AppConfig {
  /// Platform name
  ///
  /// @default AppName
  static String get platformName => 'Todolo';

  /// This code snippet is defining a static variable `apiUrl` in the `AppConfig` class. The value of
  /// `apiUrl` is determined based on the current environment and platform.
  ///
  /// - If the application is running in debug mode, the value of `apiUrl` is determined based on the android/ios platform being used.
  static String apiUrl = kDebugMode
      ? GetPlatform.isAndroid
            ? 'http://10.0.2.2:2090/api'
            : 'http://localhost:2090/api'
      : 'https://api.todolo.com/api';
}
