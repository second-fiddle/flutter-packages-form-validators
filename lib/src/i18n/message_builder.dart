/// バリデーションメッセージ作成メソッド群
abstract class MessageBuilder {
  /// 必須チェック該当時のバリデーションメッセージ
  /// @param String v チェック対象文字列
  /// @return String is validation message
  String required(String v);

  /// 最小文字数チェック該当時のバリデーションメッセージ
  /// @param String v チェック対象文字列
  /// @param int n 最小文字数
  /// @return String is validation message
  String minLength(String v, int n);

  /// 最大文字数チェック該当時のバリデーションメッセージ
  /// @param String v チェック対象文字列
  /// @param int n 最大文字数
  /// @return String is validation message
  String maxLength(String v, int n);

  /// 最小文字数〜最大文字数チェック該当時のバリデーションメッセージ
  /// @param String v チェック対象文字列
  /// @param int min 最小文字数
  /// @param int max 最大文字数
  /// @return String is validation message
  String length(String v, int min, int max);

  /// 同値チェック該当時のバリデーションメッセージ
  /// @param String v チェック対象文字列
  /// @return String is validation message
  String equalto(String v);

  /// より大きいチェック該当時のバリデーションメッセージ
  /// @param String v チェック対象文字列
  /// @param int n 比較対象値
  /// @return String is validation message
  String gt(String v, int n);

  /// 以上チェック該当時のバリデーションメッセージ
  /// @param String v チェック対象文字列
  /// @param int n 比較対象値
  /// @return String is validation message
  String gte(String v, int n);

  /// 未満チェック該当時のバリデーションメッセージ
  /// @param String v チェック対象文字列
  /// @param int n 比較対象値
  /// @return String is validation message
  String lt(String v, int n);

  /// 以下チェック該当時のバリデーションメッセージ
  /// @param String v チェック対象文字列
  /// @param int n 比較対象値
  /// @return String is validation message
  String lte(String v, int n);

  /// 指定範囲内チェック該当時のバリデーションメッセージ
  /// @param String v チェック対象文字列
  /// @param int min 最小値
  /// @param int max 最大値
  /// @return String is validation message
  String range(String v, int min, int max);

  /// メールアドレスチェック該当時のバリデーションメッセージ
  /// @param String v チェック対象文字列
  /// @return String is validation message
  String email(String v);

  /// 電話番号チェック該当時のバリデーションメッセージ
  /// @param String v チェック対象文字列
  /// @return String is validation message
  String phoneNumber(String v);

  /// URLチェック該当時のバリデーションメッセージ
  /// @param String v チェック対象文字列
  /// @return String is validation message
  String url(String v);

  /// 数値チェック該当時のバリデーションメッセージ
  /// @param String v チェック対象文字列
  /// @return String is validation message
  String number(String v);

  /// 整数チェック該当時のバリデーションメッセージ
  /// @param String v チェック対象文字列
  /// @return String is validation message
  String integer(String v);

  /// 正の整数チェック該当時のバリデーションメッセージ
  /// @param String v チェック対象文字列
  /// @return String is validation message
  String digits(String v);

  /// 英字チェック該当時のバリデーションメッセージ
  /// @param String v チェック対象文字列
  /// @return String is validation message
  String alpha(String v);

  /// 英数字チェック該当時のバリデーションメッセージ
  /// @param String v チェック対象文字列
  /// @return String is validation message
  String alphanum(String v);

  /// 半角チェック該当時のバリデーションメッセージ
  /// @param String v チェック対象文字列
  /// @return String is validation message
  String halfChars(String v);

  /// 正規表現チェック該当時のバリデーションメッセージ
  /// @param String v チェック対象文字列
  /// @return String is validation message
  String pattern(String v);

  /// 日付チェック該当時のバリデーションメッセージ
  /// @param String v チェック対象文字列
  /// @return String is validation message
  String date(String v);
}
