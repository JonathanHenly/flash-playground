package {
	
	/**
	 * @author Jonathan Henly
	 */
	public class SmallAsteroid extends Asteroid {
		private const ORIG_HEALTH:int = 1;
		private const X_HITBOX:int = 4;
		private const Y_HITBOX:int = 4;
		
		public function SmallAsteroid(x:int, y:int) {
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
			this.graphics.lineStyle(0.1, 0xFFFFFF);
			this.graphics.beginFill(0x000000, 1);
			this.graphics.moveTo(-5, -5);
			this.graphics.lineTo(-5, 5);
			this.graphics.lineTo(5, 5);
			this.graphics.lineTo(5, -5);
			this.graphics.lineTo(-5, -5);
			this.graphics.endFill();
		}
		
		override public function modifyHealth():void
		{
			this.isDestroyed = true;
		}
		
		override public function splitAsteroid():Array
		{
			
			return [];
		}
		
	}
	
}
