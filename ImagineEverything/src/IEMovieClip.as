package  
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Jonathan Henly
	 */
	public class IEMovieClip extends MovieClip 
	{
		
		public function IEMovieClip() 
		{
			super();	
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