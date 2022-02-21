import 'package:flutter/material.dart';
import 'package:get/get.dart' hide ScreenType;
import 'package:global_repository/global_repository.dart';
import 'package:termare_view/termare_view.dart';

import 'logger_view.dart';

class LoggerView extends StatefulWidget {
  const LoggerView({Key? key}) : super(key: key);

  @override
  _LoggerViewState createState() => _LoggerViewState();
}

class _LoggerViewState extends State<LoggerView> {
  bool verbose = true;
  bool debug = true;
  bool info = true;
  bool warning = true;
  bool error = true;

  @override
  void initState() {
    super.initState();
  }

  void onChange() {
    logTerminalCTL.clear();
    for (var v in Log.buffer) {
      final String data =
          '[${twoDigits(v.time.hour)}:${twoDigits(v.time.minute)}:${twoDigits(v.time.second)}] ${v.data}';
      if (v.level == LogLevel.verbose && verbose) {
        logTerminalCTL.write(data + "\r\n");
      }
      if (v.level == LogLevel.debug && debug) {
        logTerminalCTL.write(data + "\r\n");
      }
      if (v.level == LogLevel.info && info) {
        logTerminalCTL.write(data + "\r\n");
      }
      if (v.level == LogLevel.warning && warning) {
        logTerminalCTL.write(data + "\r\n");
      }
      if (v.level == LogLevel.error && error) {
        logTerminalCTL.write(data + "\r\n");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 8.w),
        Expanded(
          child: TermareView(
            controller: logTerminalCTL,
          ),
        ),
        SizedBox(height: 8.w),
        WrapContainerList(
          children: [
            CheckContainer(
              value: verbose,
              data: 'verbose',
              onChanged: (value) {
                verbose = value;
                setState(() {});
                onChange();
              },
            ),
            CheckContainer(
              value: debug,
              data: 'debug',
              onChanged: (value) {
                debug = value;
                setState(() {});
                onChange();
              },
            ),
            CheckContainer(
              value: info,
              data: 'info',
              onChanged: (value) {
                info = value;
                setState(() {});
                onChange();
              },
            ),
            CheckContainer(
              value: warning,
              data: 'warning',
              onChanged: (value) {
                warning = value;
                setState(() {});
                onChange();
              },
            ),
            CheckContainer(
              value: error,
              data: 'error',
              onChanged: (value) {
                error = value;
                setState(() {});
                onChange();
              },
            ),
          ],
        ),
      ],
    );
  }
}

class CheckContainer extends StatelessWidget {
  const CheckContainer({
    Key? key,
    required this.onChanged,
    required this.value,
    required this.data,
  }) : super(key: key);

  final void Function(bool value) onChanged;
  final bool value;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.w),
        border: Border.all(
          color: Colors.transparent,
          width: 2.w,
        ),
      ),
      child: GestureWithScale(
        onTap: () {
          onChanged(!value);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: value
                ? Theme.of(context).primaryColor
                : Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(8.w),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.w),
              child: Text(
                data,
                style: TextStyle(
                  color: value
                      ? Colors.white
                      : Theme.of(context).textTheme.bodyText2?.color,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

typedef ChangeCall<T> = void Function(T value);
String twoDigits(int n) {
  if (n >= 10) return "$n";
  return "0$n";
}
