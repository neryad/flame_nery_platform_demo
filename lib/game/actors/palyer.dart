import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/image_composition.dart';
import 'package:flame/input.dart';
import 'package:flame_nery_platform_demo/game/actors/platform.dart';
import 'package:flutter/src/services/keyboard_key.g.dart';
import 'package:flutter/src/services/raw_keyboard.dart';

class Player extends SpriteComponent
    with HasHitboxes, Collidable, KeyboardHandler {
  int _hAxisInput = 0;
  bool _jumpInput = false;
  bool _isOnGroud = false;
  final double _moveSpeed = 200;
  final double _jumpSpeed = 360;
  final double _gravity = 10;
  final Vector2 _up = Vector2(0, -1);
  final Vector2 _velocity = Vector2.zero();
  Player(
    Image image, {
    Vector2? position,
    Vector2? size,
    Vector2? scale,
    double? angle,
    Anchor? anchor,
    int? priority,
  }) : super.fromImage(image,
            srcPosition: Vector2.zero(),
            srcSize: Vector2.all(32),
            position: position,
            size: size,
            scale: scale,
            angle: angle,
            anchor: anchor,
            priority: priority);

  @override
  Future<void>? onLoad() {
    //debugMode = true;
    addHitbox(HitboxCircle());
    return super.onLoad();
  }

  @override
  void update(double dt) {
    _velocity.x = _hAxisInput * _moveSpeed;
    _velocity.y += _gravity;
    if (_jumpInput) {
      if (_isOnGroud) {
        _velocity.y = -_jumpSpeed;
        _isOnGroud = false;
      }

      _jumpInput = false;
    }
    _velocity.y = _velocity.y.clamp(-_jumpSpeed, 150);
    position += _velocity * dt;
    if (_hAxisInput < 0 && scale.x > 0) {
      flipHorizontallyAroundCenter();
    } else if (_hAxisInput > 0 && scale.x < 0) {
      flipHorizontallyAroundCenter();
    }
    super.update(dt);
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    _hAxisInput = 0;

    _hAxisInput += keysPressed.contains(LogicalKeyboardKey.keyA) ? -1 : 0;
    _hAxisInput += keysPressed.contains(LogicalKeyboardKey.keyD) ? 1 : 0;
    _jumpInput = keysPressed.contains(LogicalKeyboardKey.space);
    return true;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    if (other is Platform) {
      if (intersectionPoints.length == 2) {
        // Calculate the collision normal and separation distance.
        final mid = (intersectionPoints.elementAt(0) +
                intersectionPoints.elementAt(1)) /
            2;

        final collisionNormal = absoluteCenter - mid;
        final separationDistance = (size.x / 2) - collisionNormal.length;
        collisionNormal.normalize();

        // If collision normal is almost upwards,
        // player must be on ground.
        if (_up.dot(collisionNormal) > 0.9) {
          _isOnGroud = true;
        }

        // Resolve collision by moving player along
        // collision normal by separation distance.
        position += collisionNormal.scaled(separationDistance);
      }
    }
    super.onCollision(intersectionPoints, other);
  }
}
