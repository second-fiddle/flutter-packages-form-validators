import 'package:utilities/utilities.dart';
import 'lang.dart';
import 'i18n/validtor_locale.dart';

typedef ValidatorCallback = String? Function(String? value);

/// バリデーション定義作成クラス
class ValidatorBuilder {
  /// 適用するバリデーション群
  final List<ValidatorCallback> _validators = [];

  /// バリデーションメッセージ本体
  final ValidatorLocale _validatorLocale;

  /// デフォルトロケール
  static String _locale = 'ja';

  /// コンストラクタ
  /// @param bool required 必須条件
  /// @param int? minLength 最小文字数
  /// @param int? maxLength 最大文字数
  /// @param int? min 最小値
  /// @param int? max 最大値
  /// @param List<ValidatorCallback>? validators 適用するバリデーション
  ValidatorBuilder(
      {bool required = false,
      int? minLength,
      int? maxLength,
      int? min,
      int? max,
      List<ValidatorCallback>? validators})
      : _validatorLocale = Lang.getLocale(_locale) {
    if (required) {
      _validators.add(_requiredValidator());
    }
    if (minLength != null && maxLength != null) {
      _validators.add(_lengthValidator(minLength, maxLength));
    } else if (minLength != null) {
      _validators.add(_minLengthValidator(minLength));
    } else if (maxLength != null) {
      _validators.add(_maxLengthValidator(maxLength));
    }
    if (min != null && max != null) {
      _validators.add(_rangeValidator(min, max));
    } else if (min != null) {
      _validators.add(_gteValidator(min));
    } else if (max != null) {
      _validators.add(_lteValidator(max));
    }
    if (validators != null && validators.length > 0) {
      _validators.addAll(validators);
    }
  }

  /// 指定ロケールのバリデーションメッセージを追加する。
  /// @param String locale ロケール識別キー
  /// @param MessageBuilder messageBuilder バリデーションメッセージ本体
  static void addMessage(String locale, ValidatorLocale messageBuilder) =>
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

  /// 適用されているバリデーションを取得する。
  /// @return List<ValidatorCallback> is apply validators
  List<ValidatorCallback> getValidators() => _validators;

  /// 適用されているバリデーションを順番に実行する。
  /// @param String value チェック対象
  /// @return match is validation message, not match is null
  String? test(String? value) {
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
  ValidatorBuilder required([String? message]) =>
      add(_requiredValidator(message));

  /// 必須チェックメイン
  /// @param String? message 独自エラーメッセージ
  /// @return ValidatorCallback is Function
  ValidatorCallback _requiredValidator([String? message]) => (v) =>
      (v?.isEmpty ?? true) ? message ?? _validatorLocale.required(v!) : null;

  /// 最小文字数チェック
  /// @param int length 最小文字数
  /// @param String? message 独自エラーメッセージ
  /// @return ValidatorBuilder is this
  ValidatorBuilder minLength(int length, [String? message]) =>
      add(_minLengthValidator(length, message));

  /// 最小文字数チェックメイン
  /// @param int length 最小文字数
  /// @param String? message 独自エラーメッセージ
  /// @return ValidatorCallback is Function
  ValidatorCallback _minLengthValidator(int length, [String? message]) =>
      (v) => !isLength(v!, length)
          ? message ?? _validatorLocale.minLength(v, length)
          : null;

  /// 最大文字数チェック
  /// @param int length 最大文字数
  /// @param String? message 独自エラーメッセージ
  /// @return ValidatorBuilder is this
  ValidatorBuilder maxLength(int length, [String? message]) =>
      add(_maxLengthValidator(length, message));

  /// 最大文字数チェックメイン
  /// @param int length 最大文字数
  /// @param String? message 独自エラーメッセージ
  /// @return ValidatorCallback is Function
  ValidatorCallback _maxLengthValidator(int length, [String? message]) =>
      (v) => !isLength(v!, 0, length)
          ? message ?? _validatorLocale.maxLength(v, length)
          : null;

  /// 文字数範囲チェック
  /// @param int min 最小文字数
  /// @param int max 最大文字数
  /// @param String? message 独自エラーメッセージ
  /// @return ValidatorBuilder is this
  ValidatorBuilder length(int min, int max, [String? message]) {
    ValidatorCallback validator = (v) => !isLength(v!, min, max)
        ? message ?? _validatorLocale.length(v, min, max)
        : null;
    return add(validator);
  }

  /// 文字数範囲チェックメイン
  /// @param int min 最小文字数
  /// @param int max 最大文字数
  /// @param String? message 独自エラーメッセージ
  /// @return ValidatorCallback is Function
  ValidatorCallback _lengthValidator(int min, int max, [String? message]) =>
      (v) => !isLength(v!, min, max)
          ? message ?? _validatorLocale.length(v, min, max)
          : null;

  /// 同値チェック
  /// @param String comparison チェック対象文字列
  /// @param String? message 独自エラーメッセージ
  /// @return ValidatorBuilder is this
  ValidatorBuilder equalTo(String comparison, [String? message]) {
    ValidatorCallback validator = (v) =>
        !equals(v, comparison) ? message ?? _validatorLocale.equalto(v!) : null;
    return add(validator);
  }

  /// より大きいチェック
  /// @param int comparison 比較対象値
  /// @param String? message 独自エラーメッセージ
  /// @return ValidatorBuilder is this
  ValidatorBuilder gt(int comparison, [String? message]) {
    ValidatorCallback validator = (v) => !isGt(v!, comparison)
        ? message ?? _validatorLocale.gt(v, comparison)
        : null;
    return add(validator);
  }

  /// 以上チェック
  /// @param int comparison 比較対象値
  /// @param String? message 独自エラーメッセージ
  /// @return ValidatorBuilder is this
  ValidatorBuilder gte(int comparison, [String? message]) =>
      add(_gteValidator(comparison, message));

  /// 以上チェックメイン
  /// @param int comparison 比較対象値
  /// @param String? message 独自エラーメッセージ
  /// @return ValidatorCallback is Function
  ValidatorCallback _gteValidator(int comparison, [String? message]) =>
      (v) => !isGte(v!, comparison)
          ? message ?? _validatorLocale.gte(v, comparison)
          : null;

  /// 未満チェック
  /// @param int comparison 比較対象値
  /// @param String? message 独自エラーメッセージ
  /// @return ValidatorBuilder is this
  ValidatorBuilder lt(int comparison, [String? message]) {
    ValidatorCallback validator = (v) => !isLt(v!, comparison)
        ? message ?? _validatorLocale.lt(v, comparison)
        : null;
    return add(validator);
  }

  /// 以下チェック
  /// @param int comparison 比較対象値
  /// @param String? message 独自エラーメッセージ
  /// @return ValidatorBuilder is this
  ValidatorBuilder lte(int comparison, [String? message]) =>
      add(_lteValidator(comparison, message));

  /// 以下チェックメイン
  /// @param int comparison 比較対象値
  /// @param String? message 独自エラーメッセージ
  /// @return ValidatorCallback is Function
  ValidatorCallback _lteValidator(int comparison, [String? message]) =>
      (v) => !isLte(v!, comparison)
          ? message ?? _validatorLocale.lte(v, comparison)
          : null;

  /// 範囲チェック
  /// @param int min 比較最小値
  /// @param int max 比較最大値
  /// @param String? message 独自エラーメッセージ
  /// @return ValidatorBuilder is this
  ValidatorBuilder range(int min, int max, [String? message]) =>
      add(_rangeValidator(min, max, message));

  /// 範囲チェックメイン
  /// @param int min 比較最小値
  /// @param int max 比較最大値
  /// @param String? message 独自エラーメッセージ
  /// @return ValidatorCallback is Function
  ValidatorCallback _rangeValidator(int min, int max, [String? message]) =>
      (v) => !isRange(v!, min, max)
          ? message ?? _validatorLocale.range(v, min, max)
          : null;

  /// 正規表現チェック
  /// @param String pattern 正規表現文字列
  /// @param String? message 独自エラーメッセージ
  /// @return ValidatorBuilder is this
  ValidatorBuilder pattern(String pattern, [String? message]) {
    ValidatorCallback validator = (v) =>
        !matches(v!, pattern) ? message ?? _validatorLocale.pattern(v) : null;
    return add(validator);
  }

  /// メールアドレスチェック
  /// @param String? message 独自エラーメッセージ
  /// @return ValidatorBuilder is this
  ValidatorBuilder email([String? message]) {
    ValidatorCallback validator =
        (v) => !isEmail(v!) ? message ?? _validatorLocale.email(v) : null;
    return add(validator);
  }

  /// 電話番号チェック
  /// @param String? message 独自エラーメッセージ
  /// @return ValidatorBuilder is this
  ValidatorBuilder phoneNumber([String? message]) {
    ValidatorCallback validator = (v) =>
        !isPhoneNumber(v!) ? message ?? _validatorLocale.phoneNumber(v) : null;
    return add(validator);
  }

  /// URLチェック
  /// @param String? message 独自エラーメッセージ
  /// @return ValidatorBuilder is this
  ValidatorBuilder url([String? message]) {
    ValidatorCallback validator =
        (v) => !isUrl(v!) ? message ?? _validatorLocale.url(v) : null;
    return add(validator);
  }

  /// 数値チェック
  /// @param String? message 独自エラーメッセージ
  /// @return ValidatorBuilder is this
  ValidatorBuilder number([String? message]) {
    ValidatorCallback validator =
        (v) => !isNumber(v!) ? message ?? _validatorLocale.number(v) : null;
    return add(validator);
  }

  /// 整数チェック
  /// @param String? message 独自エラーメッセージ
  /// @return ValidatorBuilder is this
  ValidatorBuilder integer([String? message]) {
    ValidatorCallback validator =
        (v) => !isInteger(v!) ? message ?? _validatorLocale.integer(v) : null;
    return add(validator);
  }

  /// 正の整数チェック
  /// @param String? message 独自エラーメッセージ
  /// @return ValidatorBuilder is this
  ValidatorBuilder digits([String? message]) {
    ValidatorCallback validator =
        (v) => !isDigits(v!) ? message ?? _validatorLocale.digits(v) : null;
    return add(validator);
  }

  /// 英字チェック
  /// @param String? message 独自エラーメッセージ
  /// @return ValidatorBuilder is this
  ValidatorBuilder alpha([String? message]) {
    ValidatorCallback validator =
        (v) => !isAlpha(v!) ? message ?? _validatorLocale.alpha(v) : null;
    return add(validator);
  }

  /// 英数字チェック
  /// @param String? message 独自エラーメッセージ
  /// @return ValidatorBuilder is this
  ValidatorBuilder alphanum([String? message]) {
    ValidatorCallback validator = (v) =>
        !isAlphanumeric(v!) ? message ?? _validatorLocale.alphanum(v) : null;
    return add(validator);
  }

  /// 半角チェック
  /// @param String? message 独自エラーメッセージ
  /// @return ValidatorBuilder is this
  ValidatorBuilder halfChars([String? message]) {
    ValidatorCallback validator = (v) =>
        !isHalfWidth(v!) ? message ?? _validatorLocale.halfChars(v) : null;
    return add(validator);
  }

  /// 日付チェック
  /// @param String format 日付書式（デフォルト=y-M-d）
  /// @param String? message 独自エラーメッセージ
  /// @return ValidatorBuilder is this
  ValidatorBuilder date([String format = 'y-M-d', String? message]) {
    ValidatorCallback validator =
        (v) => !isDate(v!, format) ? message ?? _validatorLocale.date(v) : null;
    return add(validator);
  }

  /// 日付（過去）チェック
  /// @param DateTime? comparison チェック対象日（未指定の場合、当日）
  /// @param String? message 独自エラーメッセージ
  /// @return ValidatorBuilder is this
  ValidatorBuilder before([DateTime? comparison, String? message]) {
    ValidatorCallback validator = (v) =>
        !isBefore(v!, comparison) ? message ?? _validatorLocale.date(v) : null;
    return add(validator);
  }

  /// 日付（以前）チェック
  /// @param DateTime? comparison チェック対象日（未指定の場合、当日）
  /// @param String? message 独自エラーメッセージ
  /// @return ValidatorBuilder is this
  ValidatorBuilder todayBefore([DateTime? comparison, String? message]) {
    ValidatorCallback validator = (v) => !isTodayBefore(v!, comparison)
        ? message ?? _validatorLocale.halfChars(v)
        : null;
    return add(validator);
  }

  /// 日付（未来）チェック
  /// @param DateTime? comparison チェック対象日（未指定の場合、当日）
  /// @param String? message 独自エラーメッセージ
  /// @return ValidatorBuilder is this
  ValidatorBuilder after([DateTime? comparison, String? message]) {
    ValidatorCallback validator = (v) =>
        !isAfter(v!, comparison) ? message ?? _validatorLocale.date(v) : null;
    return add(validator);
  }

  /// 日付（以降）チェック
  /// @param DateTime? comparison チェック対象日（未指定の場合、当日）
  /// @param String? message 独自エラーメッセージ
  /// @return ValidatorBuilder is this
  ValidatorBuilder todayAfter([DateTime? comparison, String? message]) {
    ValidatorCallback validator = (v) => !isTodayAfter(v!, comparison)
        ? message ?? _validatorLocale.halfChars(v)
        : null;
    return add(validator);
  }
}
