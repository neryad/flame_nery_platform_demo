import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
// import 'package:flame/image_composition.dart';
import 'package:flame_nery_platform_demo/game/actors/palyer.dart';
import 'package:flame_nery_platform_demo/utils/audio_manager.dart';

class Door extends SpriteComponent with CollisionCallbacks {
  Function? onPlayerEnter;

  Door(
    super.image, {
    this.onPlayerEnter,
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.priority,
  }) : super.fromImage(
            srcPosition: Vector2(2 * 32, 0), srcSize: Vector2.all(32));

  @override
  FutureOr<void> onLoad() {
    add(RectangleHitbox()..collisionType = CollisionType.passive);
    return super.onLoad();
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player) {
      AudioManager.playSfx('Blop_1.wav');
      onPlayerEnter?.call();
    }
    super.onCollisionStart(intersectionPoints, other);
  }
}
