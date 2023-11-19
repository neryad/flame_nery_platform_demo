import 'package:flame/game.dart';
import 'package:flame_nery_platform_demo/game/game.dart';
import 'package:flame_nery_platform_demo/overalys/game_over.dart';
import 'package:flame_nery_platform_demo/overalys/main_menu.dart';
import 'package:flame_nery_platform_demo/overalys/pause_menu.dart';
import 'package:flame_nery_platform_demo/overalys/setting_overlay.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

final _game = SimplePlatformer();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: GameWidget<SimplePlatformer>(
          game: kDebugMode ? SimplePlatformer() : _game,
          overlayBuilderMap: {
            MainMenu.id: (context, game) => MainMenu(gameRef: game),
            PauseMenu.id: (context, game) => PauseMenu(gameRef: game),
            GameOVer.id: (context, game) => GameOVer(gameRef: game),
            SettingMenu.id: (context, game) => SettingMenu(gameRef: game)
          },
          initialActiveOverlays: const [MainMenu.id],
        ),
      ),
    );
  }
}
