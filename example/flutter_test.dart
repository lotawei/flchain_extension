import 'package:example/memory_leak_examples.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:leak_tracker_flutter_testing/leak_tracker_flutter_testing.dart';

void main() {
  testWidgets('Memory leak test', (tester) async {
    await tester.runAsync(() async {
      runApp(MemoryLeakExamples());
    });
  });
}
