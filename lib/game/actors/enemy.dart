import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
// import 'package:flame/image_composition.dart';
import 'package:flame_nery_platform_demo/game/actors/palyer.dart';
import 'package:flame_nery_platform_demo/game/game.dart';
import 'package:flame_nery_platform_demo/utils/audio_manager.dart';

class Enemy extends SpriteComponent
    with CollisionCallbacks, HasGameRef<SimplePlatformer> {
  static final Vector2 _up = Vector2(0, -1);
  Enemy(
    super.image, {
    Vector2? position,
    Vector2? targetPosition,
    super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.priority,
  }) : super.fromImage(
            srcPosition: Vector2(1 * 32, 0),
            srcSize: Vector2.all(32),
            position: position) {
    if (targetPosition != null && position != null) {
      final effect = SequenceEffect([
        MoveToEffect(
          targetPosition,
          EffectController(speed: 100),
          onComplete: () => flipHorizontallyAroundCenter(),
        ),
        MoveToEffect(
          position + Vector2(32, 0),
          EffectController(speed: 100),
          onComplete: () => flipHorizontallyAroundCenter(),
        )
      ], infinite: true);

      add(effect);
    }
  }
  @override
  FutureOr<void> onLoad() {
    add(CircleHitbox()..collisionType = CollisionType.passive);
    return super.onLoad();
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player) {
      final playerDir = (other.absoluteCenter - absoluteCenter).normalized();
      if (playerDir.dot(_up) > 0.85) {
        add(OpacityEffect.fadeOut(
          LinearEffectController(0.2),
          onComplete: () => removeFromParent(),
        ));
        other.jump();
      } else {
        AudioManager.playSfx('Hit_2.wav');
        other.hit();
        if (gameRef.playerData.health.value > 0) {
          gameRef.playerData.health.value -= 1;
        }
      }
    }

    super.onCollisionStart(intersectionPoints, other);
  }
}
