package {
	
	/**
	 * @author Jonathan Henly
	 */
	public class MediumAsteroid extends Asteroid {
		private const ORIG_HEALTH:uint = 2;
		private const SPAWN_MORE_COUNT:uint = 3;
		private const X_HITBOX:uint = 6;
		private const Y_HITBOX:uint = 6;
		
		public function MediumAsteroid(x:int, y:int) {
			super(x, y);
			this.health = this.ORIG_HEALTH;
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
		
		override public function createAsteroid():void
		{
			this.graphics.lineStyle(0.1, this.WHITE);
			this.graphics.beginFill(0x000000, 1);
			this.graphics.moveTo(-10, -3); // -10, -3 : 0, 7
			this.graphics.lineTo(-10, 5); // -10, 5 : 0, 15
			// this.graphics.moveTo(0, 15); // " " : " "
			this.graphics.lineTo(-5, 10); // -5, 10 : 5, 20
			// this.graphics.moveTo(5, 20); // " " : " "
			this.graphics.lineTo(5, 10); // 5, 10 : 15, 20
			// this.graphics.moveTo(15, 20); // " " : " "
			this.graphics.lineTo(5, 5); // 5, 5 : 15, 15
			// this.graphics.moveTo(15, 15); // " " : " "
			this.graphics.lineTo(10, 5); // 10, 5 : 20, 15
			// this.graphics.moveTo(20, 15); // " " : " "
			this.graphics.lineTo(10, -3); // 10, -3 : 20, 7
			// this.graphics.moveTo(20, 7); // " " : " "
			this.graphics.lineTo(5, -3); // 5, -3 : 15, 7
			// this.graphics.moveTo(15, 7); // " " : " "
			this.graphics.lineTo(7, -6); // 7, -6 : 17, 4
			// this.graphics.moveTo(17, 4); // " " : " "
			this.graphics.lineTo(3, -10); // 3, -10 : 13, 0
			// this.graphics.moveTo(4, -10); // 4, -10 : 14, 0
			this.graphics.lineTo(-5, -10); // -5, -10 : 5, 0
			// this.graphics.moveTo(5, 0); // " " : " "
			this.graphics.lineTo(-5, -3); // -5, -3 : 5, 7
			// this.graphics.moveTo(5, 7); // " " : " "
			// this.graphics.lineTo(-10, -3); // -10, -3 : 0, 7
			this.graphics.endFill();
		}
		
		override public function modifyHealth():void
		{
			this.graphics.lineStyle(0.1, this.WHITE);
			switch(this.health) {
				case 3:
					// First Scratch
					this.graphics.moveTo(5, 5);
					this.graphics.lineTo(3, 3);
					this.graphics.lineTo(4, 1);
					// Second Scratch
					this.graphics.moveTo(3, -10);
					this.graphics.lineTo(0, -8);
					this.graphics.lineTo(3, -6);
					// Third Scratch
					this.graphics.moveTo( -10, 5);
					this.graphics.lineTo( -7, 3);
					this.graphics.lineTo( -6, 5);
					
					break; // END: First Damage
					
				case 2:
					// First Scratch +1
					this.graphics.moveTo(4, 1);
					this.graphics.lineTo(1, 2);
					// Second Scratch +1
					this.graphics.moveTo(3, -6);
					this.graphics.lineTo(1, -4);
					// Third Scratch +1
					this.graphics.moveTo( -7, 3);
					this.graphics.lineTo( -5, 1);
					
					break; // END: Second Damage
					
				case 1:
					// First Scratch +2
					this.graphics.moveTo(1, 2);
					this.graphics.lineTo(0, 0);
					// Second Scratch +2
					this.graphics.moveTo(1, -4);
					this.graphics.lineTo(0, -2);
					// Third Scratch +2
					this.graphics.moveTo( -5, 1);
					this.graphics.lineTo( -2, 0);
					this.graphics.lineTo( -10, 3);
					
					this.graphics.lineStyle(0.1, 0x000000);
					this.graphics.moveTo( -10, 3);
					this.graphics.lineTo( -10, 5);
					break; // END: Fourth Damage
					
				case 0:
					this.isDestroyed = true;
					break; // END: Break Apart
					
			}
			this.graphics.endFill();
		}
		
		override public function splitAsteroid():Array
		{
			if(!this.hasSpawned) {
				var tmpAstArray:Array = new Array();
					for (var x:int = 0; x < SPAWN_MORE_COUNT; x++) {
						var tmpSmallAsteroid:Asteroid = new SmallAsteroid(this.x, this.y);
						tmpSmallAsteroid.vX = (2 * Math.random() - 1);
						tmpSmallAsteroid.vY = (2 * Math.random() - 1);
						tmpSmallAsteroid.isColliding = true;
						tmpAstArray.push(tmpSmallAsteroid);
						Asteroids.miniMap.addItemToMiniMap(tmpSmallAsteroid);
					}
				this.hasSpawned = true;
				return tmpAstArray;
			} else {
				return [];
			}
		}
		
	}
	
}
