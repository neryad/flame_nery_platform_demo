import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame_nery_platform_demo/game/game.dart';
import 'package:flame_nery_platform_demo/overalys/game_over.dart';
import 'package:flame_nery_platform_demo/overalys/pause_menu.dart';

class Hub extends Component with HasGameRef<SimplePlatformer> {
  late final TextComponent scoreTextComponent;
  late final TextComponent healthTextComponent;
  Hub({super.children, super.priority}) {
    positionType = PositionType.viewport;
  }

  @override
  Future<void>? onLoad() {
    scoreTextComponent =
        TextBoxComponent(text: 'Score: 0', position: Vector2.all(10));
    add(scoreTextComponent);
    healthTextComponent = TextBoxComponent(
        text: '5x',
        anchor: Anchor.topRight,
        position: Vector2(gameRef.size.x - 10, 10));

    add(healthTextComponent);

    final playerSprite = SpriteComponent.fromImage(gameRef.spriteSheet,
        srcPosition: Vector2.zero(),
        srcSize: Vector2.all(32),
        anchor: Anchor.topRight,
        position: Vector2(healthTextComponent.position.x - 5, 5));

    add(playerSprite);
    gameRef.playerData.score.addListener(() {
      onScoreChange();
    });

    gameRef.playerData.health.addListener(() {
      onHealthChange();
    });

    final puaseButton = SpriteButtonComponent(
        onPressed: () {
          gameRef.pauseEngine();
          gameRef.overlays.add(PauseMenu.id);
        },
        button: Sprite(gameRef.spriteSheet,
            srcSize: Vector2.all(32), srcPosition: Vector2(32 * 4, 0)),
        size: Vector2.all(32),
        position: Vector2(gameRef.size.x / 2, 5),
        anchor: Anchor.topCenter)
      ..positionType = PositionType.viewport;
    ;
    add(puaseButton);
    return super.onLoad();
  }

  void onScoreChange() {
    scoreTextComponent.text = 'Score: ${gameRef.playerData.score.value}';
  }

  void onHealthChange() {
    healthTextComponent.text = 'x${gameRef.playerData.health.value}';
    if (gameRef.playerData.health.value == 0) {
      gameRef.pauseEngine();
      gameRef.overlays.add(GameOVer.id);
    }
  }

  @override
  void onRemove() {
    gameRef.playerData.health.removeListener(() {
      onHealthChange();
    });
    gameRef.playerData.score.removeListener(() {
      onScoreChange();
    });
    super.onRemove();
  }
}
