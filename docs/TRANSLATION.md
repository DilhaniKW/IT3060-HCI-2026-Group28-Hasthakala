# Translating screens (English / Sinhala / Tamil)

1. Add your text to `lib/core/localization/app_strings.dart`:

```dart
'cart_title': {'en': 'My Cart', 'si': 'මගේ කරත්තය', 'ta': 'எனது கூடை'},
```

2. Use it in a widget:

```dart
import '../../../../core/localization/tr.dart';

Text(context.tr('cart_title'))
Text(context.tr('items_count', {'count': '3'}))   // text with {count} inside
```

- Widgets that use `context.tr` can't be `const` (remove `const` from that Text).
- If a key has no Sinhala/Tamil text yet, English is shown.
- If you see a key name on screen (e.g. `cart_title`), the key is missing from app_strings.dart.
- Text typed by users (product names, descriptions, messages) is not translated.
- Ask a Sinhala / Tamil speaker in the group to check new text before testing.
