import 'dart:io';

void main() async {
  Directory dir = Directory('./assets/tree_images/');
  await for (var entity in dir.list(recursive: true, followLinks: false)) {
    // ignore: avoid_print
    print("- " + entity.path);
  }
}
