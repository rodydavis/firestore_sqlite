import 'dart:io';

extension FileUtils on File {
  void check() {
    if (!existsSync()) createSync(recursive: true);
  }
}
