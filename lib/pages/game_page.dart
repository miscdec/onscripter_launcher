import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import '../models/game.dart';

class GamePage extends StatefulWidget {
  final Game game;

  const GamePage({super.key, required this.game});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  InAppWebViewController? _webViewController;
  final GlobalKey webViewKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: InAppWebView(
          key: webViewKey,
          initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(
              useShouldOverrideUrlLoading: true,
              mediaPlaybackRequiresUserGesture: false,
            ),
          ),
          onWebViewCreated: (controller) {
            _webViewController = controller;
            controller.loadFile(assetFilePath: "assets/onsyuri.html");
          },
          shouldOverrideUrlLoading: (controller, navigationAction) async {
            var uri = navigationAction.request.url!;
            
            // 处理游戏资源请求
            if (uri.path.endsWith('onsyuri_index.json')) {
              var gameIndexJson = await _generateGameIndex();
              controller.evaluateJavascript(source: """
                window.localStorage.setItem('onsyuri_index', '$gameIndexJson');
              """);
              return NavigationActionPolicy.CANCEL;
            }
            
            // 处理游戏文件请求
            if (uri.path.startsWith('/game/')) {
              var filePath = uri.path.replaceFirst('/game/', '');
              // TODO: 从game对象中读取实际文件并返回
                
              return NavigationActionPolicy.CANCEL;
            }

            return NavigationActionPolicy.ALLOW;
          },
        ),
      ),
    );
  }

  Future<String> _generateGameIndex() async {
    var gameIndex = {
      'games': [
        {
          'title': widget.game.name,
          'path': '/game/${widget.game.path}',
          'lastModified': widget.game.lastModified.toIso8601String(),
        }
      ]
    };
    return jsonEncode(gameIndex);
  }

  @override
  void initState() {
    super.initState();
    // 设置横屏
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    // 恢复竖屏
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }
} 