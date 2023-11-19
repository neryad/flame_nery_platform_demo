import 'package:flame_nery_platform_demo/game/game.dart';
import 'package:flame_nery_platform_demo/game/game_play.dart';
import 'package:flame_nery_platform_demo/overalys/setting_overlay.dart';
import 'package:flutter/material.dart';

class MainMenu extends StatelessWidget {
  static const id = "MainMenu";
  final SimplePlatformer gameRef;

  const MainMenu({super.key, required this.gameRef});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: 100,
                child: ElevatedButton(
                    onPressed: () {
                      gameRef.overlays.remove(id);
                      gameRef.add(GamePlay());
                    },
                    child: const Text('Play'))),
            SizedBox(
                height: 100,
                child: ElevatedButton(
                    onPressed: () {
                      gameRef.overlays.remove(id);
                      gameRef.overlays.add(SettingMenu.id);
                    },
                    child: const Text('Settings'))),
          ],
        ),
      ),
    );
  }
}
