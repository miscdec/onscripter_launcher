

import 'package:hive_ce/hive.dart';

part 'game.g.dart';

@HiveType(typeId: 1)
class Game extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String path;

  @HiveField(2)
  DateTime lastModified;

  Game({
    required this.name,
    required this.path,
    required this.lastModified,
  });
} 