import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Platform extends PositionComponent with CollisionCallbacks {
  Platform({
    required Vector2 super.position,
    required Vector2 super.size,
    super.scale,
    double? angle,
    super.anchor,
    int? priority,
  });

  @override
  FutureOr<void> onLoad() {
    // debugMode = true;

    add(RectangleHitbox()..collisionType = CollisionType.passive);
    return super.onLoad();
  }
}
