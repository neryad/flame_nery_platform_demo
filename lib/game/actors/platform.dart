import 'package:flame/components.dart';
import 'package:flame/geometry.dart';

class Platform extends PositionComponent with HasHitboxes, Collidable {
  Platform({
    required Vector2 position,
    required Vector2 size,
    Vector2? scale,
    double? angle,
    Anchor? anchor,
    int? priority,
  }) : super(position: position, size: size, scale: scale, anchor: anchor);

  @override
  Future<void>? onLoad() {
    // debugMode = true;
    collidableType = CollidableType.passive;
    addHitbox(HitboxRectangle());
    return super.onLoad();
  }
}
