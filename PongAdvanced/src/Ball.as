package 
{
	import flash.display.MovieClip;
	import flash.events.*;
	
	/**
	 * ...
	 * @author Jonathan Henly
	 */
	public class Ball extends MovieClip
	{
		public var VX:Number = 10;
		public var VY:Number = 0;
		
		public function Ball():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			this.createBall();
		}
		
		private function createBall():void
		{
			this.graphics.beginFill(0x444444, 1);
			this.graphics.drawCircle(0, 0, 4);
			this.graphics.endFill();
		}
		
		public function update():void
		{
			this.x += VX;
			this.y += VY;
		}
		
		public function invertVX():void
		{
			this.VX *= -1;
		}
		
		public function invertVY():void
		{
			this.VY *= -1;
		}
		
		public function updateVelocity(momentum:int):void
		{
			this.VY += momentum;
		}
		
		public function moveBall():void
		{
			this.x += 3;
		}
	}
	
}