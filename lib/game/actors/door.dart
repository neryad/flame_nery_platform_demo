import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/image_composition.dart';
import 'package:flame_nery_platform_demo/game/actors/palyer.dart';
import 'package:flame_nery_platform_demo/utils/audio_manager.dart';

class Door extends SpriteComponent with CollisionCallbacks {
  Function? onPlayerEnter;

  Door(
    Image image, {
    this.onPlayerEnter,
    Vector2? position,
    Vector2? size,
    Vector2? scale,
    double? angle,
    Anchor? anchor,
    int? priority,
  }) : super.fromImage(image,
            srcPosition: Vector2(2 * 32, 0),
            srcSize: Vector2.all(32),
            position: position,
            size: size,
            scale: scale,
            angle: angle,
            anchor: anchor,
            priority: priority);

  @override
  Future<void>? onLoad() {
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
