# form_validators

Provides simple form validation for widgets.

## Getting Started

### Installation

dd form_validators as dependency to your flutter project by adding this lines to pubspec.yaml.

```
dependencies:
  git:
    url: https://github.com/second-fiddle/flutter-packages-form-validators.git
```

Then run flutter pub get to install required dependencies.

### Code

Import form_validators package to your dart widgets by writing:

import 'package:form_validators/form_validators.dart';

### Supported Language

- Japanese(default)
- English

#### Add Support Language

First, you need to extend abstract MessageBuilder class.

```
import 'package:form_validators/message_builder.dart';

class CustomMessageBuilder extends MessageBuilder {
  @override
  String required() => "Field is required";

  ...
}
```

Then add the the CustomMessageBuilder class you defined.

```
void main() {
  ValidatorBuilder.addMessage('custom',  CustomMessageBuilder());
  ...
}
```

### Localaization

Use the setLocale method to set th locale to use.

```
void main() {
  ValidatorBuilder.setLocale('ja');
  ...
}
```

**When use with custom message_builder, the locale must be setLocale method after the addMessage method.**

### Methods

|validator|english|japanese|
|--|--|--|
|required()|The field is required.|この値は必須です。|
|minLength(int length, [String? message])|The field must be at least $length characters long.|$length 文字以上で入力してください。|
|maxLength(int length, [String? message])|The field must be at most $length characters long.|$length 文字以下で入力してください。|
|length(int min, int max, [String? message])|This value length is invalid. It should be between $min and $max characters long.|$min から $max 文字の間で入力してください。|
|equalto(String comparison, [String? message])|This value should be the same.|値が違います。|
|gt(int compare, [String? message])|This value should be greater than $compare.|$compare より大きい値を入力してください。|
|gte(int compare, [String? message])|This value should be greater or equal to $compare.|$compare より大きいか、同じ値を入力してください。|
|lt(int compare, [String? message])|This value should be less than $compare.|$compare より小さい値を入力してください。|
|lte(int compare, [String? message])|This value should be less or equal to $compare.|$compare より小さいか、同じ値を入力してください。|
|range(int min, int max, [String? message])|This value should be between $min and $max.|$min から $max の値にしてください。|
|pattern(String pattern, [String? message])|This value seems to be invalid.|この値は無効です。|
|email([String? message])|The field is not a valid email address.|有効なメールアドレスではありません。|
|phoneNumber([String? message])|The field is not a valid phone number.|有効な電話番号ではありません。|
|url([String? message])|The field is not a valid URL address.|有効なURLではありません。|
|number([String? message])|This value should be a valid number.|数値を入力してください。|
|integer([String? message])|This value should be a valid integer.|整数を入力してください。|
|digits([String? message])|This value should be digits.|0以上の整数を入力してください。|
|alpha([String? message])|This value should be a alpha.|英字を入力してください。|
|alphanum([String? message])|This value should be alphanumeric.|英数字を入力してください。|
|halfChars([String? message])|This value should be half characters.|半角文字を入力してください。|
|date([String? message])|This field is not a valid date.|有効な日付を入力してください。|


