import 'package:flutter_test/flutter_test.dart';
import 'package:form_validators/form_validators.dart';

formValidationJa() {
  test('form validators Ja', () {
    var required = ValidatorBuilder().required();
    expect(required.test(''), 'この値は必須です。');
    expect(required.test('test'), null);
    required = ValidatorBuilder(required: true);
    expect(required.test(''), 'この値は必須です。');
    expect(required.test('test'), null);

    var minLength = ValidatorBuilder().minLength(5);
    expect(minLength.test("1234"), '5 文字以上で入力してください。');
    expect(minLength.test("12345"), null);
    expect(minLength.test(""), null);

    var maxLength = ValidatorBuilder().maxLength(5);
    expect(maxLength.test("123456"), '5 文字以下で入力してください。');
    expect(maxLength.test("12345"), null);
    expect(maxLength.test(""), null);

    var length = ValidatorBuilder().length(2, 4);
    expect(length.test("1"), '2 から 4 文字の間で入力してください。');
    expect(length.test("12345"), '2 から 4 文字の間で入力してください。');
    expect(length.test("12"), null);
    expect(length.test("1234"), null);
    expect(length.test(""), null);

    var equalto = ValidatorBuilder().equalTo("comparison");
    expect(equalto.test("value"), '値が違います。');
    expect(equalto.test("comparison"), null);

    var gt = ValidatorBuilder().gt(5);
    expect(gt.test("5"), '5 より大きい値を入力してください。');
    expect(gt.test("6"), null);
    expect(gt.test(""), null);

    var gte = ValidatorBuilder().gte(5);
    expect(gte.test("4"), '5 より大きいか、同じ値を入力してください。');
    expect(gte.test("5"), null);
    expect(gte.test("6"), null);
    expect(gte.test(""), null);

    var lt = ValidatorBuilder().lt(5);
    expect(lt.test("5"), '5 より小さい値を入力してください。');
    expect(lt.test("4"), null);
    expect(lt.test(""), null);

    var lte = ValidatorBuilder().lte(5);
    expect(lte.test("6"), '5 より小さいか、同じ値を入力してください。');
    expect(lte.test("5"), null);
    expect(lte.test("4"), null);
    expect(lte.test(""), null);

    var range = ValidatorBuilder().range(2, 4);
    expect(range.test("1"), '2 から 4 の値にしてください。');
    expect(range.test("15"), '2 から 4 の値にしてください。');
    expect(range.test("2"), null);
    expect(range.test("4"), null);
    expect(range.test(""), null);

    var pattern = ValidatorBuilder().pattern(r'[\d]', '値が違います。');
    expect(pattern.test("a"), "値が違います。");
    expect(pattern.test("1"), null);
    expect(pattern.test(""), null);

    var email = ValidatorBuilder().email();
    expect(email.test('user@'), "有効なメールアドレスではありません。");
    expect(email.test('user@example.jp'), null);
    expect(email.test(""), null);

    var phoneNumber = ValidatorBuilder().phoneNumber();
    expect(phoneNumber.test('090123'), "有効な電話番号ではありません。");
    expect(phoneNumber.test('09024356020'), null);
    expect(phoneNumber.test(""), null);

    var url = ValidatorBuilder().url();
    expect(url.test('https://yahoo'), "有効なURLではありません。");
    expect(url.test('https://yahoo.co.jp'), null);
    expect(url.test(""), null);

    var number = ValidatorBuilder().number();
    expect(number.test('a'), "数値を入力してください。");
    expect(number.test('1'), null);
    expect(number.test('1.0'), null);
    expect(number.test('0'), null);
    expect(number.test('-1'), null);
    expect(number.test('-1.0'), null);
    expect(number.test(""), null);

    var integer = ValidatorBuilder().integer();
    expect(integer.test('a'), "整数を入力してください。");
    expect(integer.test('1'), null);
    expect(integer.test('1.0'), "整数を入力してください。");
    expect(integer.test('0'), null);
    expect(integer.test('-1'), null);
    expect(integer.test('-1.0'), "整数を入力してください。");
    expect(integer.test(""), null);

    var digits = ValidatorBuilder().digits();
    expect(digits.test('a'), "1以上の整数を入力してください。");
    expect(digits.test('1'), null);
    expect(digits.test('1.0'), "1以上の整数を入力してください。");
    expect(digits.test('0'), "1以上の整数を入力してください。");
    expect(digits.test('-1'), "1以上の整数を入力してください。");
    expect(digits.test('-1.0'), "1以上の整数を入力してください。");
    expect(digits.test(""), null);

    var alpha = ValidatorBuilder().alpha();
    expect(alpha.test('1#'), '英字を入力してください。');
    expect(alpha.test('abc'), null);

    var alphanum = ValidatorBuilder().alphanum();
    expect(alphanum.test('a1#'), '英数字を入力してください。');
    expect(alphanum.test('ａ'), '英数字を入力してください。');
    expect(alphanum.test('a1'), null);

    var halfChas = ValidatorBuilder().halfChars();
    expect(halfChas.test('１２３'), '半角文字を入力してください。');
    expect(halfChas.test('123'), null);
    expect(halfChas.test(''), null);

    var date = ValidatorBuilder().date();
    expect(date.test('2021-xx-xx'), '有効な日付を入力してください。');
    expect(date.test('2021-04-31'), '有効な日付を入力してください。');
    expect(date.test('2021/xx/xx'), '有効な日付を入力してください。');
    expect(date.test('2021/04/31'), '有効な日付を入力してください。');
    expect(date.test('2021年xx月xx日'), '有効な日付を入力してください。');
    expect(date.test('2021年04月31日'), '有効な日付を入力してください。');
    expect(date.test('2021-4-1'), null);
    expect(date.test('9999-12-31'), null);
    expect(date.test('1900-1-1'), null);

    date = ValidatorBuilder().date('y-MM-dd');
    expect(date.test('2021-04-01'), null);
    expect(date.test('1900-01-01'), null);

    date = ValidatorBuilder().date('y/M/d');
    expect(date.test('2021/4/30'), null);
    expect(date.test('9999/12/31'), null);
    expect(date.test('1900/1/1'), null);
    expect(date.test('1900/01/01'), null);

    date = ValidatorBuilder().date('y年M月d日');
    expect(date.test('2021年4月30日'), null);
    expect(date.test('9999年12月31日'), null);
    expect(date.test('1900年1月1日'), null);
    expect(date.test('1900年01月01日'), null);
  });
}