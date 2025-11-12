class BaseConverter {
  static String convert(String input, String fromBase, String toBase) {
    int from = _baseValue(fromBase);
    int to = _baseValue(toBase);
    try {
      int number = int.parse(input, radix: from);
      return number.toRadixString(to).toUpperCase();
    } catch (e) {
      return "Invalid Input";
    }
  }

  static Map<String, String> convertAll(String input, String fromBase) {
    int from = _baseValue(fromBase);
    try {
      int number = int.parse(input, radix: from);
      return {
        'Decimal': number.toRadixString(10).toUpperCase(),
        'Binary': number.toRadixString(2).toUpperCase(),
        'Octal': number.toRadixString(8).toUpperCase(),
        'Hexadecimal': number.toRadixString(16).toUpperCase(),
      };
    } catch (_) {
      return {'Error': 'Invalid Input'};
    }
  }

  static int _baseValue(String base) {
    switch (base) {
      case 'Binary':
        return 2;
      case 'Octal':
        return 8;
      case 'Decimal':
        return 10;
      case 'Hexadecimal':
        return 16;
      default:
        return 10;
    }
  }
}
