part of contra;

class BulletManager implements Animatable {

  Sprite layer;

  HashSet<Bullet> bullets;
  DateTime playerLastBombTimestamp;
  DateTime playerLastFireTimestamp;

  BulletManager(Sprite layer) {
    this.layer = layer;
    bullets = new HashSet<Bullet>();
  }

  bool advanceTime(num time) {
    HashSet<Bullet> bulletsToRemove = new HashSet<Bullet>();
    for (Bullet bullet in bullets) {
      // bullet hit anyone?
      if (bullet.hostile) {

      } else {

      }
      //move forward other bullets
      if(bullet.isDead()) {
        layer.removeChild(bullet);
        bulletsToRemove.add(bullet);
        juggler.remove(bullet);
      }
    }
    bullets.removeAll(bulletsToRemove);
  }

  math.Random random = new math.Random(new DateTime.now().millisecondsSinceEpoch);

  robotFired(Robot robot) {

    var direction = robot.speedX >= 0 ? 1 : -1; // TODO
    Bullet bullet = new Bullet(
        direction == 1 ? robot.x + robot.width : robot.x,
        robot.y + robot.height / 3.0,
        500.0 * direction,
        200.0,
        -100.0 * direction,
        -1000.0,
        true, 5);
    bullets.add(bullet);
    layer.addChild(bullet);
  }

  
  playerFired(Player player) {
    var now = new DateTime.now();
    if (playerLastFireTimestamp != null
        && now.millisecondsSinceEpoch - playerLastFireTimestamp.millisecondsSinceEpoch < Statics.MIN_FIRE_INTERVAL) {
      return;
    }
    playerLastFireTimestamp = now;

    Bullet bullet = new Bullet.gun(
        player.direction == Statics.DIRECTION_RIGHT ? player.x + player.width : player.x,
        player.y + player.height * 0.2,
        500.0 * player.direction + player.speedX,
        0.0,
        -10.0 * player.direction,
        -0.0,
        false, 1);
    bullets.add(bullet);
    layer.addChild(bullet);
    
  }
  playerBombed(Player player) {
    var now = new DateTime.now();
    if (playerLastBombTimestamp != null
        && now.millisecondsSinceEpoch - playerLastBombTimestamp.millisecondsSinceEpoch < Statics.MIN_FIRE_INTERVAL*10) {
      return;
    }
    playerLastBombTimestamp = now;

    Bullet bullet = new Bullet(
        player.direction == Statics.DIRECTION_RIGHT ? player.x + player.width : player.x,
        player.y + player.height * 0.2,
        500.0 * player.direction + player.speedX,
        200.0,
        -100.0 * player.direction,
        -1000.0,
        false, 100);
    bullets.add(bullet);
    layer.addChild(bullet);
  }
}

