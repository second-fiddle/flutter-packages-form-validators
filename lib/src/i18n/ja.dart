import 'validtor_locale.dart';

/// バリデーションメッセージ（日本語）
class Ja extends ValidatorLocale {
  @override
  String required(String v) => 'この値は必須です。';

  @override
  String minLength(String v, int n) => '$n 文字以上で入力してください。';

  @override
  String maxLength(String v, int n) => '$n 文字以下で入力してください。';

  @override
  String length(String v, int min, int max) => '$min から $max 文字の間で入力してください。';

  @override
  String equalto(String v) => '値が違います。';

  @override
  String gt(String v, int n) => '$n より大きい値を入力してください。';

  @override
  String gte(String v, int n) => '$n より大きいか、同じ値を入力してください。';

  @override
  String lt(String v, int n) => '$n より小さい値を入力してください。';

  @override
  String lte(String v, int n) => '$n より小さいか、同じ値を入力してください。';

  @override
  String range(String v, int min, int max) => '$min から $max の値にしてください。';

  @override
  String pattern(String v) => 'この値は無効です。';

  @override
  String email(String v) => '有効なメールアドレスではありません。';

  @override
  String phoneNumber(String v) => '有効な電話番号ではありません。';

  @override
  String url(String v) => '有効なURLではありません。';

  String number(String v) => '数値を入力してください。';

  @override
  String integer(String v) => '整数を入力してください。';

  @override
  String digits(String v) => '1以上の整数を入力してください。';

  @override
  String alpha(String v) => '英字を入力してください。';

  @override
  String alphanum(String v) => '英数字を入力してください。';

  @override
  String halfChars(String v) => '半角文字を入力してください。';

  @override
  String date(String v) => '有効な日付を入力してください。';
}
