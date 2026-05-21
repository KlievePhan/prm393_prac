import 'dart:async';

class Settings {
  String themeMode = 'Light Mode';

// Private static instance cache storing the internal singleton allocation
  static final Settings _internalCacheInstance = Settings
      ._internalConstructor();

// Private generative constructor preventing external instantiate vectors
  Settings._internalConstructor();

// Factory keyword intercepts execution flow, returning the pre-cached instance
  factory Settings() {
    return _internalCacheInstance;
  }
}