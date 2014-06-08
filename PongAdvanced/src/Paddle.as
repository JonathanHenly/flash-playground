package 
{
	import flash.display.MovieClip;
	import flash.events.*;
	
	/**
	 * ...
	 * @author Jonathan Henly
	 */
	public class Paddle extends MovieClip
	{
		private var VY:Number = 9;
		
		public var momentum:Number = 0;
		
		public function Paddle():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			this.createPaddle();
		}
		
		private function createPaddle():void
		{
			this.graphics.beginFill(0x444444, 1);
			this.graphics.drawRect(0, 0, 5, 30);
			this.graphics.endFill();
		}
		
		public function moveUp():void
		{
			if(this.y > 50) {
				this.y -= VY;
				if(this.momentum < 3) {
					this.momentum += 0.3;
				}
			}
		}
		
		public function moveDown():void
		{
			if(this.y < 560) {
				this.y += VY;
				if(this.momentum > -3) {
					this.momentum -= 0.3;
				}
			}
		}
		
		public function update():void
		{
			if (momentum > 0) {
				momentum -= 0.1;
			} else if (momentum < 0) {
				momentum += 0.1;
			}
		}
	}
	
}