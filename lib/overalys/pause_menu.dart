import 'package:flame_nery_platform_demo/game/game.dart';
import 'package:flame_nery_platform_demo/overalys/main_menu.dart';
import 'package:flutter/material.dart';

class PauseMenu extends StatelessWidget {
  static const id = "PuaseMenu";
  final SimplePlatformer gameRef;
  const PauseMenu({super.key, required this.gameRef});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withAlpha(100),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: 100,
                child: ElevatedButton(
                    onPressed: () {
                      gameRef.overlays.remove(id);
                      gameRef.resumeEngine();
                    },
                    child: const Text('Resume'))),
            SizedBox(
                height: 100,
                child: ElevatedButton(
                    onPressed: () {
                      gameRef.overlays.remove(id);
                      gameRef.resumeEngine();
                      gameRef.removeAll(gameRef.children);
                      gameRef.overlays.add(MainMenu.id);
                    },
                    child: const Text('Exit'))),
          ],
        ),
      ),
    );
  }
}
