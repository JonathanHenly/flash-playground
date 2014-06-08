package 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ...
	 */
	public class  WumpAgeEvent extends Event
	{
		public static const PROCESS_ONE_COMPLETE:String = "PROCESS_COMPLETE";
		
		public function WumpAgeEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new WumpAgeEvent(type, bubbles, cancelable);
		}
		
	}
	
}