import 'package:form_validators/src/message_builder.dart';
import 'package:intl/intl.dart';
import 'package:validators/validators.dart';
import 'extensions/string.dart';
import 'i18n/lang.dart';

typedef ValidatorCallback = String? Function(String value);

class ValidatorBuilder {
  final List<ValidatorCallback> _validators = [];
  final MessageBuilder _messageBuilder;
  static String _locale = 'en';
  static List<String> _datePatterns = ['', 'yyyy-MM-dd', 'yyyy/MM/dd', 'yyyy年MM月dd日'];

  ValidatorBuilder() : _messageBuilder = Lang.getLocale(_locale);

  static void addMessage(String locale, MessageBuilder messageLocale) =>
      Lang.add(locale, messageLocale);

  static void setLocale(String locale) {
    if (!Lang.contain(locale)) {
      throw ArgumentError.value(locale, 'locale', 'locale is not available.');
    }

    _locale = locale;
  }

  static void addDatePatterns(List<String> patterns) {
    _datePatterns = [..._datePatterns, ...patterns];
  }

  ValidatorBuilder add(ValidatorCallback validator) {
    _validators.add(validator);
    return this;
  }

  String? test(String value) {
    for (var validator in _validators) {
      final String? result = validator(value);
      if (result != null) {
        return result;
      }
    }
    return null;
  }

  ValidatorCallback validate() => test;

  ValidatorBuilder reset() {
    _validators.clear();
    return this;
  }

  /// ////////////////////////////////////////////////////
  /// Validator Definition
  /// ////////////////////////////////////////////////////
  ValidatorBuilder required([String? message]) {
    ValidatorCallback validator =
        (v) => isNull(v) ? message ?? _messageBuilder.required() : null;
    return add(validator);
  }

  ValidatorBuilder minLength(int length, [String? message]) {
    ValidatorCallback validator = (v) => (!isNull(v) && !isLength(v, length))
        ? message ?? _messageBuilder.minLength(v, length)
        : null;
    return add(validator);
  }

  ValidatorBuilder maxLength(int length, [String? message]) {
    ValidatorCallback validator = (v) => !isLength(v, 0, length)
        ? message ?? _messageBuilder.maxLength(v, length)
        : null;
    return add(validator);
  }

  ValidatorBuilder length(int min, int max, [String? message]) {
    ValidatorCallback validator = (v) => (!isNull(v) && !isLength(v, min, max))
        ? message ?? _messageBuilder.length(v, min, max)
        : null;
    return add(validator);
  }

  ValidatorBuilder min(int min, [String? message]) {
    ValidatorCallback validator = (v) => (!isNull(v) && v.toInt() < min)
        ? message ?? _messageBuilder.min(v, min)
        : null;
    return add(validator);
  }

  ValidatorBuilder max(int max, [String? message]) {
    ValidatorCallback validator = (v) => (!isNull(v) && v.toInt() > max)
        ? message ?? _messageBuilder.max(v, max)
        : null;
    return add(validator);
  }

  ValidatorBuilder range(int min, int max, [String? message]) {
    ValidatorCallback validator = (v) =>
        (!isNull(v) && (v.toInt() < min || v.toInt() > max))
            ? message ?? _messageBuilder.range(v, min, max)
            : null;
    return add(validator);
  }

  ValidatorBuilder equalTo(String comparison, [String? message]) {
    ValidatorCallback validator = (v) =>
        !equals(v, comparison) ? message ?? _messageBuilder.equalto(v) : null;
    return add(validator);
  }

  ValidatorBuilder gt(int compare, [String? message]) {
    ValidatorCallback validator = (v) => (!isNull(v) && v.toInt() <= compare)
        ? message ?? _messageBuilder.gt(v, compare)
        : null;
    return add(validator);
  }

  ValidatorBuilder gte(int compare, [String? message]) {
    ValidatorCallback validator = (v) => (!isNull(v) && v.toInt() < compare)
        ? message ?? _messageBuilder.gte(v, compare)
        : null;
    return add(validator);
  }

  ValidatorBuilder lt(int compare, [String? message]) {
    ValidatorCallback validator = (v) => (!isNull(v) && v.toInt() >= compare)
        ? message ?? _messageBuilder.lt(v, compare)
        : null;
    return add(validator);
  }

  ValidatorBuilder lte(int compare, [String? message]) {
    ValidatorCallback validator = (v) => (!isNull(v) && v.toInt() > compare)
        ? message ?? _messageBuilder.lte(v, compare)
        : null;
    return add(validator);
  }

  ValidatorBuilder pattern(String pattern, String message) {
    ValidatorCallback validator =
        (v) => (!isNull(v) && !matches(v, pattern)) ? message : null;
    return add(validator);
  }

  ValidatorBuilder email([String? message]) {
    ValidatorCallback validator = (v) =>
        (!isNull(v) && !isEmail(v)) ? message ?? _messageBuilder.email(v) : null;
    return add(validator);
  }

  ValidatorBuilder phoneNumber([String? message]) {
    ValidatorCallback validator = (v) =>
        (!isNull(v) && !matches(v, r'^\d{7,15}$'))
            ? message ?? _messageBuilder.phoneNumber(v)
            : null;
    return add(validator);
  }

  ValidatorBuilder ip([String? message]) {
    ValidatorCallback validator = (v) =>
        (!isNull(v) && !isIP(v)) ? message ?? _messageBuilder.ip(v) : null;
    return add(validator);
  }

  ValidatorBuilder url([String? message]) {
    ValidatorCallback validator = (v) =>
        (!isNull(v) && !isURL(v)) ? message ?? _messageBuilder.url(v) : null;
    return add(validator);
  }

  ValidatorBuilder number([String? message]) {
    ValidatorCallback validator = (v) => (!isNull(v) && !isFloat(v))
        ? message ?? _messageBuilder.number(v)
        : null;
    return add(validator);
  }

  ValidatorBuilder integer([String? message]) {
    ValidatorCallback validator = (v) =>
        (!isNull(v) && !isInt(v)) ? message ?? _messageBuilder.integer(v) : null;
    return add(validator);
  }

  ValidatorBuilder digits([String? message]) {
    ValidatorCallback validator = (v) => (!isNull(v) && !matches(v, r'^\d+$'))
        ? message ?? _messageBuilder.digits(v)
        : null;
    return add(validator);
  }

  ValidatorBuilder alpha([String? message]) {
    ValidatorCallback validator = (v) =>
        (!isNull(v) && !isAlpha(v)) ? message ?? _messageBuilder.alpha(v) : null;
    return add(validator);
  }

  ValidatorBuilder alphanum([String? message]) {
    ValidatorCallback validator = (v) => (!isNull(v) && !isAlphanumeric(v))
        ? message ?? _messageBuilder.alphanum(v)
        : null;
    return add(validator);
  }

  ValidatorBuilder halfChars([String? message]) {
    ValidatorCallback validator = (v) => (!isNull(v) && !isHalfWidth(v))
        ? message ?? _messageBuilder.halfChars(v)
        : null;
    return add(validator);
  }

  ValidatorBuilder date([String? message]) {
    ValidatorCallback validator = (v) {
      if (isNull(v)) {
        return null;
      }

      for (int i = 0; i < _datePatterns.length; i++) {
        String pattern = _datePatterns[i];
        try {
          if (isNull(pattern)) {
            DateFormat().parseStrict(v);
          } else {
            DateFormat().addPattern(pattern).parseStrict(v);
          }
          return null;
        } catch(e){}
      }

      return message ?? _messageBuilder.date(v);
    };
    return add(validator);
  }
}
