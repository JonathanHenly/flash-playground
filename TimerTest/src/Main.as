package 
{
	import flash.utils.Timer;
	import flash.events.*;
	
	public class Main extends Sprite 
	{
		private var timer:Timer = new Timer(10000, 1);
		private var newArray:Array = new Array();
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			newArray.unshift();
			
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
			timer.start();
		}
		
		private function onTimerComplete(evt:TimerEvent):void {
			trace("10 seconds");
			timer.reset(); // Reset the timer count back to 0
			timer.start(); // Start the timer again
		}
		
	}
	
}