import 'i18n/en.dart';
import 'i18n/ja.dart';
import 'i18n/message_builder.dart';

/// バリデーションメッセージの対象言語適用クラス
class Lang {
  /// バリデーションメッセージ群
  static Map<String, MessageBuilder> _locale = {
    'ja': Ja(),
    'en': En(),
  };

  /// バリデーションメッセージを追加する。
  /// @param String locale ロケール識別キー
  /// @param MessageBuilder messageLocale バリデーションメッセージ本体
  static void add(String locale, MessageBuilder messageLocale) {
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
  static MessageBuilder getLocale(String locale) {
    MessageBuilder? messageLocale = _locale[locale];
    if (messageLocale == null) {
      throw ArgumentError.value(
          locale, 'locale', 'locale is not available.');
    }
    return messageLocale;
  }
}
