import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
// import 'package:flame/image_composition.dart';
import 'package:flame_nery_platform_demo/game/actors/palyer.dart';
import 'package:flame_nery_platform_demo/game/game.dart';
import 'package:flame_nery_platform_demo/utils/audio_manager.dart';

class Coins extends SpriteComponent
    with CollisionCallbacks, HasGameRef<SimplePlatformer> {
  Coins(
    super.image, {
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.priority,
  }) : super.fromImage(
            srcPosition: Vector2(3 * 32, 0), srcSize: Vector2.all(32));

  @override
  FutureOr<void> onLoad() {
    add(CircleHitbox()..collisionType = CollisionType.passive);
    add(MoveEffect.by(
        Vector2(0, -4),
        EffectController(
          alternate: true,
          infinite: true,
          duration: 1,
        )));
    return super.onLoad();
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player) {
      AudioManager.playSfx('Collectibles_6.wav');
      add(OpacityEffect.fadeOut(LinearEffectController(0.3),
          onComplete: () => add(
                RemoveEffect(),
              )));
    }
    gameRef.playerData.score.value += 1;
    super.onCollisionStart(intersectionPoints, other);
  }
}
