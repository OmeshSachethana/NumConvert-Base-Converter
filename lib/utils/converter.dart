// lib/utils/converter.dart
import 'dart:math' as math;

class BaseConverter {
  /// Returns a map containing 'result' and 'steps'
  static Map<String, String> convertWithSteps(String input, String fromBase, String toBase) {
    final normalized = input.trim().toUpperCase();
    final from = _baseValue(fromBase);
    final to = _baseValue(toBase);

    try {
      final number = int.parse(normalized, radix: from);
      final result = number.toRadixString(to).toUpperCase();

      final buffer = StringBuffer();
      // Step 1: show how we got decimal (unless input was already decimal)
      if (from != 10) {
        buffer.writeln('Converting $normalized (base $from) → decimal:');
        buffer.writeln(_toDecimalSteps(normalized, from));
      } else {
        buffer.writeln('Input is decimal: $normalized');
      }

      // Step 2: show how we convert decimal → target base
      if (to != 10) {
        buffer.writeln('\nConverting decimal ($number) → $toBase (base $to):');
        buffer.writeln(_fromDecimalSteps(number, to));
      } else {
        buffer.writeln('\nTarget base is decimal. Result: $number');
      }

      buffer.writeln('\nFinal result: $result');

      return {'result': result, 'steps': buffer.toString()};
    } catch (e) {
      return {'result': 'Invalid Input', 'steps': 'Invalid input for base $fromBase.'};
    }
  }

  // old convenience methods (kept for compatibility)
  static String convert(String input, String fromBase, String toBase) {
    final map = convertWithSteps(input, fromBase, toBase);
    return map['result']!;
  }

  static Map<String, String> convertAll(String input, String fromBase) {
    final from = _baseValue(fromBase);
    try {
      final number = int.parse(input.trim().toUpperCase(), radix: from);
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

  // produce step-by-step positional sum to decimal
  static String _toDecimalSteps(String input, int base) {
    final chars = input.split('');
    final len = chars.length;
    final lines = <String>[];
    int total = 0;
    for (int i = 0; i < len; i++) {
      final ch = chars[i];
      final digit = _digitValue(ch);
      final power = len - i - 1;
      final placeValue = math.pow(base, power).toInt();
      final contrib = digit * placeValue;
      lines.add('$ch × $base^$power = $digit × $placeValue = $contrib');
      total += contrib;
    }
    lines.add('Sum = $total (decimal)');
    return lines.join('\n');
  }

  // produce repeated division method from decimal to target base
  static String _fromDecimalSteps(int number, int base) {
    if (number == 0) return '0';
    final rows = <String>[];
    int n = number;
    final remainders = <String>[];

    while (n > 0) {
      final q = n ~/ base;
      final r = n % base;
      rows.add('$n ÷ $base = $q remainder $r (${_digitChar(r)})');
      remainders.add(_digitChar(r));
      n = q;
    }

    final reversed = remainders.reversed.join();
    rows.add('\nTake remainders bottom → top: $reversed');
    return rows.join('\n');
  }

  static int _digitValue(String ch) {
    if (RegExp(r'^[0-9]$').hasMatch(ch)) return int.parse(ch);
    final code = ch.codeUnitAt(0);
    // A-F -> 10-15
    return code - 'A'.codeUnitAt(0) + 10;
  }

  static String _digitChar(int val) {
    if (val < 10) return val.toString();
    return String.fromCharCode('A'.codeUnitAt(0) + (val - 10));
  }
}
