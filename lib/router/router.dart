import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../main.dart';  
import '../page/home_screen/home_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const MyHomePage(title: 'Home',),
      ),
      // 可以添加更多路由
    ],
    // 错误页面处理
    errorBuilder: (context, state) => const ErrorPage(),
  );
});


class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('页面未找到'),
      ),
    );
  }
} 