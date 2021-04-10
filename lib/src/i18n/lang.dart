import 'en.dart';
import 'ja.dart';
import '../message_builder.dart';

class Lang {
  static Map<String, MessageBuilder> lang = {
    'en': En(),
    'ja': Ja(),
  };

  static void add(String locale, MessageBuilder messageLocale) {
    lang[locale] = messageLocale;
  }

  static bool contain(String locale) {
    return lang.containsKey(locale);
  }

  static MessageBuilder getLocale(String locale) {
    MessageBuilder? messageLocale = lang[locale];
    if (messageLocale == null) {
      throw ArgumentError.value(
          locale, 'locale', 'locale is not available.');
    }
    return messageLocale;
  }
}
