import 'i18n/en.dart';
import 'i18n/ja.dart';
import 'i18n/validtor_locale.dart';

/// バリデーションメッセージの対象言語適用クラス
class Lang {
  /// バリデーションメッセージ群
  static Map<String, ValidatorLocale> _locale = {
    'ja': Ja(),
    'en': En(),
  };

  /// バリデーションメッセージを追加する。
  /// @param String locale ロケール識別キー
  /// @param MessageBuilder messageLocale バリデーションメッセージ本体
  static void add(String locale, ValidatorLocale messageLocale) {
    _locale[locale] = messageLocale;
  }

  /// 扱えるロケールか判定する。
  /// @param String locale ロケール識別キー
  /// @return boot true is avail, false is not avail
  static bool contain(String locale) {
    return _locale.containsKey(locale);
  }

  /// ロケールに対応するバリデーションメッセージを取得する。
  /// @param String locale ロケール識別キー
  /// @return MessageBuilder is バリデーションメッセージ本体
  static ValidatorLocale getLocale(String locale) {
    ValidatorLocale? messageLocale = _locale[locale];
    if (messageLocale == null) {
      throw ArgumentError.value(
          locale, 'locale', 'locale is not available.');
    }
    return messageLocale;
  }
}
