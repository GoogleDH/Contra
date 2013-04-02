part of contra;

class BulletManager implements Animatable {
  
  Sprite layer;
  
  HashSet<Bullet> bullets;
  DateTime lastFireTimestamp;
  
  BulletManager(Sprite layer) {
    this.layer = layer;
    bullets = new HashSet<Bullet>();
  }
  
  addBullet(bool fromPlayer) {
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
        //juggler.remove(bullet);
      }
    }
    bullets.removeAll(bulletsToRemove);
  }

  math.Random random = new math.Random(new DateTime.now().millisecondsSinceEpoch);
  
  playerFired(Player player) {
    var now = new DateTime.now();
    if (lastFireTimestamp != null
        && now.millisecondsSinceEpoch - lastFireTimestamp.millisecondsSinceEpoch < Statics.MIN_FIRE_INTERVAL) {
      return;
    }
    lastFireTimestamp = now;
    
    var direction = player.speedX >= 0 ? 1 : -1; // TODO
    Bullet bullet = new Bullet(
        direction == 1 ? player.x + player.playerBitmap.width : player.x,
        player.y + player.playerBitmap.height / 3.0,
        500.0 * direction,
        200.0,
        -100.0 * direction,
        -1000.0,
        false, 100);
    bullets.add(bullet);
    layer.addChild(bullet);
    bullets.add(bullet);
  }
}

