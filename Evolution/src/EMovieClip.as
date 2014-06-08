package  
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.*;
	
	/**
	 * ...
	 * @author Jonathan Henly
	 */
	public class EMovieClip extends MovieClip 
	{
		
		public function EMovieClip() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		protected function onAddedToStage(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function addChildCentered(displayObject:DisplayObject, offsetX:Number = 0, offsetY:Number = 0):void
		{
			displayObject.x = (this.x + (this.width - displayObject.width) / 2) + offsetX;
			displayObject.y = (this.y + (this.height - displayObject.height) / 2) + offsetY;
			super.addChild(displayObject);
		}
		
		public function stageAddChildCentered(displayObject:DisplayObject, offsetX:Number = 0, offsetY:Number = 0):void
		{
			displayObject.x = ((800 - displayObject.width) / 2) + offsetX;
			displayObject.y = ((600 - displayObject.height) / 2) + offsetY;
			stage.addChild(displayObject);
		}
		
	}

}