part of contra;

class BulletManager implements Animatable {
  
  Sprite layer;
  
  HashSet<Bullet> bullets;
  
  BulletManager() {
    bullets = new HashSet<Bullet>();
    juggler.add(this);
  }
  
  addBullet(bool fromPlayer) {
    Bullet b = new Bullet.byType(fromPlayer);
    layer.addChild(b);
    bullets.add(b);
  }
  
  bool advanceTime(num time) {
    HashSet<Bullet> bulletsToRemove = new HashSet<Bullet>();
    for (Bullet bullet in bullets) {
      // bullet hit anyone?
      if (bullet.fromPlayer) {
        
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

  Random random = new Random(new DateTime.now().millisecondsSinceEpoch);
  
  playerFired(Player player){
    Bullet bullet = new Bullet.full(
      //random.nextDouble()*50 + 200,
      //random.nextDouble()*50 + 200,
        250.0,250.0,
      random.nextDouble()*10 - 5,
      random.nextDouble()*10 - 5,
      false);
    bullets.add(bullet);
    layer.addChild(bullet);
    bullets.add(bullet);

  }
}

