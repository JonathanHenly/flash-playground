package 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ...
	 */
	public class MainStage extends MovieClip 
	{
		public var vX:Number = 0;
		public var vY:Number = 0;
		
		public function MainStage():void
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function update():void
		{
			this.x += this.vX;
			this.y += this.vY;
		}
		
		public function setVX(newVX:Number):void
		{
			this.vX = -newVX;
		}
		
		public function setVY(newVY:Number):void
		{
			this.vY = -newVY;
		}
		
	}
	
}