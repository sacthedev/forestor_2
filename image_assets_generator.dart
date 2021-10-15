import 'dart:io';

void main() async {
  Directory dir = Directory('./assets/tree_images/');
  await for (var entity in dir.list(recursive: true, followLinks: false)) {
    print("- " + entity.path);
  }
}
/*
dir.list(recursive = false).forEach((f) {
  print(f);
});
*/