part of contra;

class BulletManager implements Animatable {
  
  Sprite layer;
  
  HashSet<Bullet> bullets;
  
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
    Bullet bullet = new Bullet(player.playerBitmap.pivotX, player.playerBitmap.pivotY,
        random.nextDouble() * 1000 - 500, random.nextDouble() * 500,
        -100.0, -1000.0,
        false, 100);
    bullets.add(bullet);
    layer.addChild(bullet);
    bullets.add(bullet);
  }
}

