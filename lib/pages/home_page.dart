import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/game_provider.dart';
import '../models/game.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final games = ref.watch(gameListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ONScripter游戏启动器'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _importGame(context, ref),
          ),
        ],
      ),
      body: games.isEmpty
          ? const Center(
              child: Text('没有游戏，点击右上角按钮导入游戏'),
            )
          : ListView.builder(
              itemCount: games.length,
              itemBuilder: (context, index) {
                final game = games[index];
                return ListTile(
                  title: Text(game.name),
                  subtitle: Text('最后更新: ${game.lastModified.toString()}'),
                  onTap: () {
                    // TODO: 启动游戏
                  },
                );
              },
            ),
    );
  }

  Future<void> _importGame(BuildContext context, WidgetRef ref) async {
    try {
      await ref.read(gameManagerProvider).importGame();
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('导入失败: $e')),
        );
      }
    }
  }
} 