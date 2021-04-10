import 'package:validators/validators.dart';

///
/// String Extensions
///
extension StringExt on String {
  /// parameter is empty or null
  /// @param String value parameter
  /// @return bool true is empty or null, false is not empty or not null
  bool isEmptyOrNull() {
    return isNull(this);
  }

  /// parameter is empty or null
  /// @param String value parameter
  /// @return bool true is empty or null, false is not empty or not null
  bool isNotEmptyOrNull() {
    return !isNull(this);
  }

  int toInt() => toDouble().toInt();

  double toDouble() => double.tryParse(this) != null ? double.parse(this) : 0;
}
