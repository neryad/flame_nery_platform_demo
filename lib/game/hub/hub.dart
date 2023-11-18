import 'package:flame/components.dart';
import 'package:flame_nery_platform_demo/game/game.dart';

class Hub extends Component with HasGameRef<SimplePlatformer> {
  Hub({super.children, super.priority}) {
    positionType = PositionType.viewport;
  }

  @override
  Future<void>? onLoad() {
    final scoreTextComponent =
        TextBoxComponent(text: 'Score: 0', position: Vector2.all(10));
    add(scoreTextComponent);
    final healthTextComponent = TextBoxComponent(
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

    return super.onLoad();
  }
}
