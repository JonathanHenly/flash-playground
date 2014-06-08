package 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Jonathan Henly
	 */
	public class Paddle extends MovieClip 
	{
		public var VX:int = 3;
		private var resistance:Number = 0.2;
		
		public function Paddle():void
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			this.graphics.beginFill(0xAAAAAA, 1);
			this.graphics.drawRect(0, 0, 40, 5);
			this.graphics.endFill();
		}
		
		public function update():void
		{
			this.x += VX;
			
			if (VX > 0) {
				VX -= resistance;
			} else if (VX < 0) {
				VX += resistance;
			}
			
			if (VX > -0.3 && VX < 0.3) {
				VX = 0;
			}
		}
		
		public function moveRight():void
		{
			if (VX <= 10) {
				VX += 2;
			}
		}
		
		public function moveLeft():void
		{
			if (VX >= -10) {
				VX -= 2;
			}
		}
		
	}
	
}