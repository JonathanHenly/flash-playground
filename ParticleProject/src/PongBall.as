package 
{
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	
	/**
	 * ...
	 * @author Jonathan Henly
	 */
	public class PongBall extends MovieClip 
	{
		public var id:Number = 0;
		public var VX:Number = 0;
		public var VY:Number = 0;
		
		public var touchingBrick:Boolean = false;
		
		private var blurFilter:BlurFilter;
		
		public function PongBall():void
		{
			this.graphics.beginFill(0xFF0000, 1);
			this.graphics.drawCircle(0, 0, 4);
			this.graphics.endFill();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			this.blurFilter = new BlurFilter(3, 3, 2);
			
			this.filters = [blurFilter];
			
			// VX = 3 + (Math.random() * (5 - 1));
			// VY = 3 + (Math.random() * (5 - 1));
		}
		
		public function update():void
		{
			this.x += VX;
			this.y += VY;
			
			if (((this.x < 0 + this.width) || (this.x > 800 - this.width)) || ((this.x + this.VX < 0) || (this.x + this.VX > 800))) {
				this.VX *= -1;
			}
			
			if (((this.y < 0 + this.height) || (this.y > 600 - this.height / 2)) || ((this.y + this.VY < 0) || (this.y + this.VY > 600))) {
				this.VY *= -1;
			}
		}
		
		public function reverseVY():void
		{
			VY *= -1;
		}
		
		public function reverseVX():void
		{
			VX *= -1;
		}
		
		public function getBallAngle():Number
		{
			return Math.atan2(VY, VX);
		}
		
		public function launchBall(newVX:Number = 0, newVY:Number = -3):void
		{
			this.VY = newVY;
			this.VX = newVX;
		}
	}
	
}