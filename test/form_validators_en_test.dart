import 'package:flutter_test/flutter_test.dart';
import 'package:form_validators/form_validators.dart';

formValidationEn() {
  test('form validators En', () {
    ValidatorBuilder.setLocale('en');

    var required = ValidatorBuilder().required();
    expect(required.test(''), 'The field is required.');
    expect(required.test('test'), null);

    var minLength = ValidatorBuilder().minLength(5);
    expect(minLength.test("1234"),
        'The field must be at least 5 characters long.');
    expect(minLength.test("12345"), null);
    expect(minLength.test(""), null);

    var maxLength = ValidatorBuilder().maxLength(5);
    expect(maxLength.test("123456"),
        'The field must be at most 5 characters long.');
    expect(maxLength.test("12345"), null);
    expect(maxLength.test(""), null);

    var length = ValidatorBuilder().length(2, 4);
    expect(length.test("1"),
        'This value length is invalid. It should be between 2 and 4 characters long.');
    expect(length.test("12345"),
        'This value length is invalid. It should be between 2 and 4 characters long.');
    expect(length.test("12"), null);
    expect(length.test("1234"), null);
    expect(length.test(""), null);

    var equalto = ValidatorBuilder().equalTo("comparison");
    expect(equalto.test("value"), 'This value should be the same.');
    expect(equalto.test("comparison"), null);

    var gt = ValidatorBuilder().gt(5);
    expect(gt.test("5"), 'This value should be greater than 5.');
    expect(gt.test("6"), null);
    expect(gt.test(""), null);

    var gte = ValidatorBuilder().gte(5);
    expect(gte.test("4"), 'This value should be greater or equal to 5.');
    expect(gte.test("5"), null);
    expect(gte.test("6"), null);
    expect(gte.test(""), null);

    var lt = ValidatorBuilder().lt(5);
    expect(lt.test("5"), 'This value should be less than 5.');
    expect(lt.test("4"), null);
    expect(lt.test(""), null);

    var lte = ValidatorBuilder().lte(5);
    expect(lte.test("6"), 'This value should be less or equal to 5.');
    expect(lte.test("5"), null);
    expect(lte.test("4"), null);
    expect(lte.test(""), null);

    var range = ValidatorBuilder().range(2, 4);
    expect(range.test("1"), 'This value should be between 2 and 4.');
    expect(range.test("15"), 'This value should be between 2 and 4.');
    expect(range.test("2"), null);
    expect(range.test("4"), null);
    expect(range.test(""), null);

    var pattern = ValidatorBuilder().pattern(
        r'[\d]', 'This value seems to be invalid.');
    expect(pattern.test("a"), "This value seems to be invalid.");
    expect(pattern.test("1"), null);
    expect(pattern.test(""), null);

    var email = ValidatorBuilder().email();
    expect(
        email.test('user@'), "The field is not a valid email address.");
    expect(email.test('user@example.jp'), null);
    expect(email.test(""), null);

    var phoneNumber = ValidatorBuilder().phoneNumber();
    expect(
        phoneNumber.test('090123'), "The field is not a valid phone number.");
    expect(phoneNumber.test('09024356020'), null);
    expect(phoneNumber.test(""), null);

    var url = ValidatorBuilder().url();
    expect(url.test('https://yahoo'), "The field is not a valid URL address.");
    expect(url.test('https://yahoo.co.jp'), null);
    expect(url.test(""), null);

    var number = ValidatorBuilder().number();
    expect(number.test('a'), "This value should be a valid number.");
    expect(number.test('1'), null);
    expect(number.test('1.0'), null);
    expect(number.test('0'), null);
    expect(number.test('-1'), null);
    expect(number.test('-1.0'), null);
    expect(number.test(""), null);

    var integer = ValidatorBuilder().integer();
    expect(integer.test('a'), "This value should be a valid integer.");
    expect(integer.test('1'), null);
    expect(integer.test('1.0'), "This value should be a valid integer.");
    expect(integer.test('0'), null);
    expect(integer.test('-1'), null);
    expect(integer.test('-1.0'), "This value should be a valid integer.");
    expect(integer.test(""), null);

    var digits = ValidatorBuilder().digits();
    expect(digits.test('a'), "This value should be positive digits.");
    expect(digits.test('1'), null);
    expect(digits.test('1.0'), "This value should be positive digits.");
    expect(digits.test('0'), 'This value should be positive digits.');
    expect(digits.test('-1'), "This value should be positive digits.");
    expect(digits.test('-1.0'), "This value should be positive digits.");
    expect(digits.test(""), null);

    var alpha = ValidatorBuilder().alpha();
    expect(alpha.test('1#'), 'This value should be a alpha.');
    expect(alpha.test('abc'), null);

    var alphanum = ValidatorBuilder().alphanum();
    expect(alphanum.test('a1#'), 'This value should be alphanumeric.');
    expect(alphanum.test('ａ'), 'This value should be alphanumeric.');
    expect(alphanum.test('a1'), null);

    var halfChas = ValidatorBuilder().halfChars();
    expect(halfChas.test('１２３'), 'This value should be half characters.');
    expect(halfChas.test('123'), null);
    expect(halfChas.test(''), null);

    var date = ValidatorBuilder().date();
    expect(date.test('2021-xx-xx'), 'This field is not a valid date.');
    expect(date.test('2021-04-31'), 'This field is not a valid date.');
    expect(date.test('2021/xx/xx'), 'This field is not a valid date.');
    expect(date.test('2021/04/31'), 'This field is not a valid date.');
    expect(date.test('2021年xx月xx日'), 'This field is not a valid date.');
    expect(date.test('2021年04月31日'), 'This field is not a valid date.');
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
  });
}