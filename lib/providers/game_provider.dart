import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:archive/archive.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hive_ce/hive.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import '../models/game.dart';

final gameBoxProvider = Provider<Box<Game>>((ref) {
  throw UnimplementedError();
});

final gameListProvider = Provider<List<Game>>((ref) {
  final box = ref.watch(gameBoxProvider);
  return box.values.toList();
});

final gameManagerProvider = Provider((ref) => GameManager(ref));

class GameManager {
  final Ref _ref;
  
  GameManager(this._ref);

  Future<void> importGame() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['zip','7z'],
    );

    if (result == null) return;

    final file = File(result.files.single.path!);
    final fileName = path.basenameWithoutExtension(file.path);
    final bytes = await file.readAsBytes();
    final archive = ZipDecoder().decodeBytes(bytes);

    final appDir = await getApplicationDocumentsDirectory();
    final gameDir = Directory(path.join(appDir.path, 'games', fileName));
    
    if (!gameDir.existsSync()) {
      gameDir.createSync(recursive: true);
    }

    for (final file in archive) {
      final filename = file.name;
      if (file.isFile) {
        final data = file.content as List<int>;
        File(path.join(gameDir.path, filename))
          ..createSync(recursive: true)
          ..writeAsBytesSync(data);
      }
    }

    final game = Game(
      name: fileName,
      path: gameDir.path,
      lastModified: DateTime.now(),
    );

    final box = _ref.read(gameBoxProvider);
    await box.add(game);
  }
} 