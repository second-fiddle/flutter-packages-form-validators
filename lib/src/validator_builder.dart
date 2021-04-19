import 'package:utilities/utilities.dart';
import 'lang.dart';
import 'i18n/message_builder.dart';

typedef ValidatorCallback = String? Function(String value);

/// バリデーション定義作成クラス
class ValidatorBuilder {
  /// 適用するバリデーション群
  final List<ValidatorCallback> _validators = [];

  /// バリデーションメッセージ本体
  final MessageBuilder _messageBuilder;

  /// デフォルトロケール
  static String _locale = 'ja';

  /// コンストラクタ
  ValidatorBuilder({
    bool required = false,
  }) : _messageBuilder = Lang.getLocale(_locale) {
    if (required) {
      _validators.add(_requiredValidator());
    }
  }

  /// 指定ロケールのバリデーションメッセージを追加する。
  /// @param String locale ロケール識別キー
  /// @param MessageBuilder messageBuilder バリデーションメッセージ本体
  static void addMessage(String locale, MessageBuilder messageBuilder) =>
      Lang.add(locale, messageBuilder);

  /// 使用するロケールを設定する。
  /// @param String locale ロケール識別キー
  /// @throw ArgumentError ロケール識別キーが使用可能なバリデーションメッセージとして登録されていない。
  static void setLocale(String locale) {
    if (!Lang.contain(locale)) {
      throw ArgumentError.value(locale, 'locale', 'locale is not available.');
    }

    _locale = locale;
  }

  /// 適用するバリデーションを追加する。
  /// @param ValidationCallback validator バリデーション実行メソッド
  /// @param int? position バリデーション実行メソッド追加位置
  /// @return ValidationBuilder is this
  ValidatorBuilder add(ValidatorCallback validator, {int? position}) {
    _validators.add(validator);
    return this;
  }

  /// 適用されているバリデーションを順番に実行する。
  /// @param String value チェック対象
  /// @return match is validation message, not match is null
  String? test(String value) {
    for (var validator in _validators) {
      final String? result = validator(value);
      if (result != null) {
        return result;
      }
    }
    return null;
  }

  /// 適用されているバリデーションを実行する。
  /// @return ValidatorCallback is Function
  ValidatorCallback validate() => test;

  /// 適用されているバリデーションをクリアする。
  /// @return ValidationBuilder is this
  ValidatorBuilder reset() {
    _validators.clear();
    return this;
  }

  /// ////////////////////////////////////////////////////
  /// Validator Definition
  /// ////////////////////////////////////////////////////
  /// 必須チェック
  /// @param String? message 独自エラーメッセージ
  /// @return ValidatorBuilder is this
  ValidatorBuilder required([String? message]) {
    return add(_requiredValidator(message));
  }

  /// 必須チェックメイン
  /// @param String? message 独自エラーメッセージ
  /// @return ValidatorCallback is Function
  ValidatorCallback _requiredValidator([String? message]) => (v) =>
      v.isEmpty ? message ?? _messageBuilder.required(v) : null;

  /// 最小文字数チェック
  /// @param int length 最小文字数
  /// @param String? message 独自エラーメッセージ
  /// @return ValidatorBuilder is this
  ValidatorBuilder minLength(int length, [String? message]) {
    ValidatorCallback validator = (v) => !isLength(v, length)
        ? message ?? _messageBuilder.minLength(v, length)
        : null;
    return add(validator);
  }

  /// 最大文字数チェック
  /// @param int length 最大文字数
  /// @param String? message 独自エラーメッセージ
  /// @return ValidatorBuilder is this
  ValidatorBuilder maxLength(int length, [String? message]) {
    ValidatorCallback validator = (v) => !isLength(v, 0, length)
        ? message ?? _messageBuilder.maxLength(v, length)
        : null;
    return add(validator);
  }

  /// 文字数範囲チェック
  /// @param int min 最小文字数
  /// @param int max 最大文字数
  /// @param String? message 独自エラーメッセージ
  /// @return ValidatorBuilder is this
  ValidatorBuilder length(int min, int max, [String? message]) {
    ValidatorCallback validator = (v) => !isLength(v, min, max)
        ? message ?? _messageBuilder.length(v, min, max)
        : null;
    return add(validator);
  }

  /// 同値チェック
  /// @param String comparison チェック対象文字列
  /// @param String? message 独自エラーメッセージ
  /// @return ValidatorBuilder is this
  ValidatorBuilder equalTo(String comparison, [String? message]) {
    ValidatorCallback validator = (v) =>
        !equals(v, comparison) ? message ?? _messageBuilder.equalto(v) : null;
    return add(validator);
  }

  /// より大きいチェック
  /// @param int comparison 比較対象値
  /// @param String? message 独自エラーメッセージ
  /// @return ValidatorBuilder is this
  ValidatorBuilder gt(int comparison, [String? message]) {
    ValidatorCallback validator = (v) => !isGt(v, comparison)
        ? message ?? _messageBuilder.gt(v, comparison)
        : null;
    return add(validator);
  }

  /// 以上チェック
  /// @param int comparison 比較対象値
  /// @param String? message 独自エラーメッセージ
  /// @return ValidatorBuilder is this
  ValidatorBuilder gte(int comparison, [String? message]) {
    ValidatorCallback validator = (v) => !isGte(v, comparison)
        ? message ?? _messageBuilder.gte(v, comparison)
        : null;
    return add(validator);
  }

  /// 未満チェック
  /// @param int comparison 比較対象値
  /// @param String? message 独自エラーメッセージ
  /// @return ValidatorBuilder is this
  ValidatorBuilder lt(int comparison, [String? message]) {
    ValidatorCallback validator = (v) => !isLt(v, comparison)
        ? message ?? _messageBuilder.lt(v, comparison)
        : null;
    return add(validator);
  }

  /// 以下チェック
  /// @param int comparison 比較対象値
  /// @param String? message 独自エラーメッセージ
  /// @return ValidatorBuilder is this
  ValidatorBuilder lte(int comparison, [String? message]) {
    ValidatorCallback validator = (v) => !isLte(v, comparison)
        ? message ?? _messageBuilder.lte(v, comparison)
        : null;
    return add(validator);
  }

  /// 範囲チェック
  /// @param int min 比較最小値
  /// @param int max 比較最大値
  /// @param String? message 独自エラーメッセージ
  /// @return ValidatorBuilder is this
  ValidatorBuilder range(int min, int max, [String? message]) {
    ValidatorCallback validator = (v) => !isRange(v, min, max)
        ? message ?? _messageBuilder.range(v, min, max)
        : null;
    return add(validator);
  }

  /// 正規表現チェック
  /// @param String pattern 正規表現文字列
  /// @param String? message 独自エラーメッセージ
  /// @return ValidatorBuilder is this
  ValidatorBuilder pattern(String pattern, [String? message]) {
    ValidatorCallback validator = (v) =>
        !matches(v, pattern) ? message ?? _messageBuilder.pattern(v) : null;
    return add(validator);
  }

  /// メールアドレスチェック
  /// @param String? message 独自エラーメッセージ
  /// @return ValidatorBuilder is this
  ValidatorBuilder email([String? message]) {
    ValidatorCallback validator =
        (v) => !isEmail(v) ? message ?? _messageBuilder.email(v) : null;
    return add(validator);
  }

  /// 電話番号チェック
  /// @param String? message 独自エラーメッセージ
  /// @return ValidatorBuilder is this
  ValidatorBuilder phoneNumber([String? message]) {
    ValidatorCallback validator = (v) =>
        !isPhoneNumber(v) ? message ?? _messageBuilder.phoneNumber(v) : null;
    return add(validator);
  }

  /// URLチェック
  /// @param String? message 独自エラーメッセージ
  /// @return ValidatorBuilder is this
  ValidatorBuilder url([String? message]) {
    ValidatorCallback validator =
        (v) => !isUrl(v) ? message ?? _messageBuilder.url(v) : null;
    return add(validator);
  }

  /// 数値チェック
  /// @param String? message 独自エラーメッセージ
  /// @return ValidatorBuilder is this
  ValidatorBuilder number([String? message]) {
    ValidatorCallback validator =
        (v) => !isNumber(v) ? message ?? _messageBuilder.number(v) : null;
    return add(validator);
  }

  /// 整数チェック
  /// @param String? message 独自エラーメッセージ
  /// @return ValidatorBuilder is this
  ValidatorBuilder integer([String? message]) {
    ValidatorCallback validator =
        (v) => !isInteger(v) ? message ?? _messageBuilder.integer(v) : null;
    return add(validator);
  }

  /// 正の整数チェック
  /// @param String? message 独自エラーメッセージ
  /// @return ValidatorBuilder is this
  ValidatorBuilder digits([String? message]) {
    ValidatorCallback validator =
        (v) => !isDigits(v) ? message ?? _messageBuilder.digits(v) : null;
    return add(validator);
  }

  /// 英字チェック
  /// @param String? message 独自エラーメッセージ
  /// @return ValidatorBuilder is this
  ValidatorBuilder alpha([String? message]) {
    ValidatorCallback validator =
        (v) => !isAlpha(v) ? message ?? _messageBuilder.alpha(v) : null;
    return add(validator);
  }

  /// 英数字チェック
  /// @param String? message 独自エラーメッセージ
  /// @return ValidatorBuilder is this
  ValidatorBuilder alphanum([String? message]) {
    ValidatorCallback validator = (v) =>
        !isAlphanumeric(v) ? message ?? _messageBuilder.alphanum(v) : null;
    return add(validator);
  }

  /// 半角チェック
  /// @param String? message 独自エラーメッセージ
  /// @return ValidatorBuilder is this
  ValidatorBuilder halfChars([String? message]) {
    ValidatorCallback validator =
        (v) => !isHalfWidth(v) ? message ?? _messageBuilder.halfChars(v) : null;
    return add(validator);
  }

  /// 日付チェック
  /// @param String format 日付書式（デフォルト=y-M-d）
  /// @param String? message 独自エラーメッセージ
  /// @return ValidatorBuilder is this
  ValidatorBuilder date([String format = 'y-M-d', String? message]) {
    ValidatorCallback validator =
        (v) => !isDate(v, format) ? message ?? _messageBuilder.date(v) : null;
    return add(validator);
  }

  /// 日付（過去）チェック
  /// @param DateTime? comparison チェック対象日（未指定の場合、当日）
  /// @param String? message 独自エラーメッセージ
  /// @return ValidatorBuilder is this
  ValidatorBuilder before([DateTime? comparison, String? message]) {
    ValidatorCallback validator = (v) =>
        !isBefore(v, comparison) ? message ?? _messageBuilder.date(v) : null;
    return add(validator);
  }

  /// 日付（以前）チェック
  /// @param DateTime? comparison チェック対象日（未指定の場合、当日）
  /// @param String? message 独自エラーメッセージ
  /// @return ValidatorBuilder is this
  ValidatorBuilder todayBefore([DateTime? comparison, String? message]) {
    ValidatorCallback validator = (v) => !isTodayBefore(v, comparison)
        ? message ?? _messageBuilder.halfChars(v)
        : null;
    return add(validator);
  }

  /// 日付（未来）チェック
  /// @param DateTime? comparison チェック対象日（未指定の場合、当日）
  /// @param String? message 独自エラーメッセージ
  /// @return ValidatorBuilder is this
  ValidatorBuilder after([DateTime? comparison, String? message]) {
    ValidatorCallback validator = (v) =>
        !isAfter(v, comparison) ? message ?? _messageBuilder.date(v) : null;
    return add(validator);
  }

  /// 日付（以降）チェック
  /// @param DateTime? comparison チェック対象日（未指定の場合、当日）
  /// @param String? message 独自エラーメッセージ
  /// @return ValidatorBuilder is this
  ValidatorBuilder todayAfter([DateTime? comparison, String? message]) {
    ValidatorCallback validator = (v) => !isTodayAfter(v, comparison)
        ? message ?? _messageBuilder.halfChars(v)
        : null;
    return add(validator);
  }
}
