package {
	
	
	/**
	 * @author Jonathan Henly
	 */
	public class LargeAsteroid extends Asteroid {
		private const SPAWN_MORE_COUNT:uint = 2;
		private const ORIG_HEALTH:uint = 5;
		private const X_HITBOX:uint = 14;
		private const Y_HITBOX:uint = 14;
		
		public function LargeAsteroid(x:int, y:int) {
			super(x, y);
			this.health = ORIG_HEALTH;
			// this.createAsteroid();
		}
		
		override public function createAsteroid():void
		{
			this.graphics.lineStyle(0.1, this.WHITE);
			this.graphics.beginFill(0x000000, 1);
			this.graphics.moveTo( -20, 10); // -10, -3 : 0, 7
			this.graphics.lineTo( -10, 20); // -10, 5 : 0, 15
			// this.graphics.moveTo(0, 15); // " " : " "
			this.graphics.lineTo(10, 20); // -5, 10 : 5, 20
			// this.graphics.moveTo(5, 20); // " " : " "
			this.graphics.lineTo(20, 10); // 5, 10 : 15, 20
			// this.graphics.moveTo(15, 20); // " " : " "
			this.graphics.lineTo(8, 2); // 5, 5 : 15, 15
			// this.graphics.moveTo(15, 15); // " " : " "
			this.graphics.lineTo(15, -10); // 10, 5 : 20, 15
			// this.graphics.moveTo(20, 15); // " " : " "
			this.graphics.lineTo(0, -20);// 10, -3 : 20, 7
			// this.graphics.moveTo(20, 7); // " " : " "
			this.graphics.lineTo( -15, -12); // 5, -3 : 15, 7
			this.graphics.lineTo( -12, -2);
			// this.graphics.moveTo(15, 7); // " " : " "
			this.graphics.lineTo( -20, 3); // 7, -6 : 17, 4
			// this.graphics.moveTo(17, 4); // " " : " "
			this.graphics.lineTo( -20, 10); // 3, -10 : 13, 0
			this.graphics.endFill();
		}
		
		override public function createHitBox():void
		{
			this.hitBox.graphics.beginFill(0x3354df, 1.0);
			this.hitBox.graphics.moveTo(-X_HITBOX, Y_HITBOX);
			this.hitBox.graphics.lineTo(X_HITBOX, Y_HITBOX);
			this.hitBox.graphics.lineTo(X_HITBOX, -Y_HITBOX);
			this.hitBox.graphics.lineTo(-X_HITBOX, -Y_HITBOX);
			this.hitBox.graphics.lineTo(-X_HITBOX, Y_HITBOX);
			this.hitBox.graphics.endFill();
			this.addChild(hitBox);
		}
		
		override public function modifyHealth():void
		{
			switch(this.health) {
				case 0:
					this.isDestroyed = true;
					break;
			}
		}
		
		override public function splitAsteroid():Array
		{
			if (!this.hasSpawned) {
				Asteroids.updateArray.push(Asteroids.mainStage.addChild(
				new ParticleContainer(this.x - 50, this.y - 50, 1000, ParticleContainer.A_ON_A)
				));
				var tmpAstArray:Array = new Array();
					for (var x:int = 0; x < SPAWN_MORE_COUNT; x++) {
						var tmpMediumAsteroid:Asteroid = new MediumAsteroid(this.x, this.y);
						tmpMediumAsteroid.vX = (2 * Math.random() - 1);
						tmpMediumAsteroid.vY = (2 * Math.random() - 1);
						tmpMediumAsteroid.isColliding = true;
						tmpAstArray.push(tmpMediumAsteroid);
						Asteroids.miniMap.addItemToMiniMap(tmpMediumAsteroid);
					}
				this.hasSpawned = true;
				return tmpAstArray;
			} else {
				return [];
			}
		}
		
	}
	
}
