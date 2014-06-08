package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Jonathan Henly
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			var value:Number = 20000;
			var range:Number = 255;
			var xScaled:Number = 0;
			
			trace(scale255(2000, 255, 2));
			trace(scale255(2000, 255, 1000));
		}
		
		private function scale255(max:int, b:int, value:Number):Number
		{
			return (b) * (value) / (max);
		}
		
	}
	
}