library logger_view;

export 'log_page.dart';
import 'package:flutter/material.dart';
import 'package:termare_view/termare_view.dart';

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}

TermareController logTerminalCTL = TermareController(
  enableLog: false,
  theme: TermareStyles.macos.copyWith(
    cursorColor: Colors.transparent,
    backgroundColor: Colors.transparent,
    fontSize: 10,
  ),
)..hideCursor();
