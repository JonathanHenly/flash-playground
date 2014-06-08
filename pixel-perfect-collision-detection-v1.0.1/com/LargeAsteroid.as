package {
	
	/**
	 * @author Jonathan Henly
	 */
	public class LargeAsteroid extends Asteroid {
		private const X_HITBOX:int = 6;
		private const Y_HITBOX:int = 6;
		
		public function LargeAsteroid() {
			super();
			this.createHitBox();
			this.createAsteroid();
		}
		
		override public function createAsteroid():void
		{
			this.graphics.lineStyle(0.1, 0xFFFFFF);
			this.graphics.moveTo(-10, -3);
			this.graphics.lineTo(-10, 5);
			this.graphics.moveTo(-10, 5);
			this.graphics.lineTo(-5, 10);
			this.graphics.moveTo(-5, 10);
			this.graphics.lineTo(5, 10);
			this.graphics.moveTo(5, 10);
			this.graphics.lineTo(5, 5);
			this.graphics.moveTo(5, 5);
			this.graphics.lineTo(10, 5);
			this.graphics.moveTo(10, 5);
			this.graphics.lineTo(10, -3);
			this.graphics.moveTo(10, -3);
			this.graphics.lineTo(5, -3);
			this.graphics.moveTo(5, -3);
			this.graphics.lineTo(7, -6);
			this.graphics.moveTo(7, -6);
			this.graphics.lineTo(3, -10);
			this.graphics.moveTo(4, -10);
			this.graphics.lineTo(-5, -10);
			this.graphics.moveTo(-5, -10);
			this.graphics.lineTo(-5, -3);
			this.graphics.moveTo(-5, -3);
			this.graphics.lineTo(-10, -3);
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
		
		override public function splitAsteroid():Array
		{
			
			return new Array();
		}
		
	}
	
}
