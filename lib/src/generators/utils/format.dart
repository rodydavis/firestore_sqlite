import 'package:dart_style/dart_style.dart';

String formatDart(String source) {
  final formatter = DartFormatter();
  return formatter.format(source);
}
