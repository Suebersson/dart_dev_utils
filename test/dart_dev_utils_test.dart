import 'package:dart_dev_utils/dart_dev_utils.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    final awesome = Constants.i;

    setUp(() {
      // Additional setup goes here.
    });

    test('First Test', () {
      expect(awesome.getOperatingSystem, isTrue);
    });
  });
}
