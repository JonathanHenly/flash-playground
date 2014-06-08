package  
{
	import flash.display.MovieClip;
	import flash.events.*;
	
	public class BottomContainer extends MovieClip 
	{
		
		public function BottomContainer() 
		{
			this.x = 0;
			this.y = 0;
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function onAddedToStage(event:Event):void
		{
			// setUpGraphics();
			
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function setUpGraphics():void
		{
			this.graphics.lineStyle(1, 0x555555);
			this.graphics.moveTo(50, 490);
			this.graphics.lineTo(750, 490);
			this.graphics.moveTo(50, 580);
			this.graphics.lineTo(750, 580);
		}
		
	}

}