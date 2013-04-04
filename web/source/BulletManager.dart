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
      //move forward other bullets
      if(bullet.isDead()) {
        layer.removeChild(bullet);
        bulletsToRemove.add(bullet);
        juggler.remove(bullet);
      }
    }
    bullets.removeAll(bulletsToRemove);
    
    // check if the bomb has cooled down
    var now = new DateTime.now();
    if (playerLastBombTimestamp == null
        || now.millisecondsSinceEpoch - playerLastBombTimestamp.millisecondsSinceEpoch > Statics.MIN_FIRE_INTERVAL*10) {
      Game.hudManager.setBombStatus(false);
    }
    
  }

  math.Random random = new math.Random(new DateTime.now().millisecondsSinceEpoch);

  robotFired(Robot robot) {
    var speedX = robot.x - Game.player.x;
    var speedY = robot.y - Game.player.y;
    //uniform speed
    var ratio = 100 / math.sqrt(speedX * speedX + speedY * speedY);
    speedX = speedX * ratio * -1;
    speedY = speedY * ratio;
    var direction = robot.direction;
    Bullet bullet = new Bullet.gun(
        /* x */direction == 1 ? robot.x + robot.width + 15: robot.x - 5,
        /* y */robot.y + robot.height * 0.2,
        /* speedX */speedX,
        /* speedY */speedY,
        /* accelerationX*/0.0 * direction,
        /* accelerationY*/0.0,
        true, 5);
    bullets.add(bullet);
    layer.addChild(bullet);
  }
  
  birdFire(Bird bird) {
    var speedX = 0;
    var speedY = bird.y - Game.player.y;
    //uniform speed
    var ratio = 100 / math.sqrt(speedX * speedX + speedY * speedY);
    speedX = speedX * ratio * -1;
    speedY = speedY * ratio;
   
    Bullet bullet = new Bullet.gun(
        /* x */bird.x + bird.width / 2,
        /* y */bird.y + bird.height / 3.0,
        /* speedX */speedX,
        /* speedY */speedY,
        /* accelerationX*/0.0,
        /* accelerationY*/10.0,
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
        0.0,
        false, 5);
    bullets.add(bullet);
    layer.addChild(bullet);
    
  }
  playerBombed(Player player) {
    var now = new DateTime.now();
    if (playerLastBombTimestamp != null
        && now.millisecondsSinceEpoch - playerLastBombTimestamp.millisecondsSinceEpoch < Statics.MIN_FIRE_INTERVAL*10) {
      return;
    }
    Game.hudManager.setBombStatus(true);
    
    Sounds.playSoundEffect("bomb");
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

