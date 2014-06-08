package {
	
	import flash.events.*;
	import flash.display.MovieClip;

	/**
	 * @author Jonathan Henly
	 */
	public class Projectile extends MovieClip {
		public var isActive:Boolean = true;
		public var time:int = 0;
		public var vX:Number = 0;
		public var vY:Number = 0;
		
		public function Projectile(x:Number, y:Number, vx:Number, vy:Number) {
			this.x = x;
			this.y = y;
			
			this.vX = vx;
			this.vY = vy;
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function onAddedToStage(event:Event):void
		{
			this.createProjectile();
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function update():void
		{
			if(this.isActive) {
				this.x += vX;
				this.y += vY;
				time++;
			}
		}
		
		public function createProjectile():void
		{
			this.graphics.beginFill(0xFFFFFF);
			this.graphics.drawCircle(0, 0, 1);
			this.graphics.endFill();
		}
		
		public function removeProjectile():void
		{
			if(parent != null) {
				parent.removeChild(this);
			}
		}
		
	}
	
}
