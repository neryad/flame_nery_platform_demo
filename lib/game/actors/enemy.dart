import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/image_composition.dart';
import 'package:flame_nery_platform_demo/game/actors/palyer.dart';
import 'package:flame_nery_platform_demo/game/game.dart';

class Enemy extends SpriteComponent
    with CollisionCallbacks, HasGameRef<SimplePlatformer> {
  Enemy(
    Image image, {
    Vector2? position,
    Vector2? targetPosition,
    Vector2? size,
    Vector2? scale,
    double? angle,
    Anchor? anchor,
    int? priority,
  }) : super.fromImage(image,
            srcPosition: Vector2(1 * 32, 0),
            srcSize: Vector2.all(32),
            position: position,
            size: size,
            scale: scale,
            angle: angle,
            anchor: anchor,
            priority: priority) {
    if (targetPosition != null && position != null) {
      final effect = SequenceEffect([
        MoveToEffect(
          targetPosition,
          EffectController(speed: 100),
        )..onFinishCallback = () => flipHorizontallyAroundCenter(),
        MoveToEffect(
          position + Vector2(32, 0),
          EffectController(speed: 100),
        )..onFinishCallback = () => flipHorizontallyAroundCenter(),
      ], infinite: true);

      add(effect);
    }
  }
  @override
  Future<void>? onLoad() {
    add(CircleHitbox()..collisionType = CollisionType.passive);
    return super.onLoad();
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player) {
      other.hit();
      if (gameRef.playerData.health.value > 0) {
        print(gameRef.playerData.health.value);
        gameRef.playerData.health.value -= 1;
        print(gameRef.playerData.health.value);
      }
    }

    super.onCollisionStart(intersectionPoints, other);
  }
}
