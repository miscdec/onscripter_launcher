import 'package:hive_ce/hive.dart';
import 'package:onscripter_launcher/models/game.dart';

extension HiveRegistrar on HiveInterface {
  void registerAdapters() {
    registerAdapter(GameAdapter());
  }
}
