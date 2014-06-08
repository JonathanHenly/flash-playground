package 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ...
	 */
	public class TileEvent extends Event 
	{
		public static const TILE_CHOSEN:String = "TILE_CHOSEN";
		public static const TILE_UNCHOSEN:String = "TILE_UNCHOSE";
		public static const TILE_RESET_POSITION:String = "TILE_RESET_POSITION";
		public var tile:SQR_ITile = null;
		
		public function TileEvent(type:String, bubbles:Boolean = true, cancelable:Boolean = false, tileRef:SQR_ITile = null)
		{
			super(type, bubbles, cancelable);
			this.tile = tileRef;
		}
		
		override public function clone():Event
		{
			return new TileEvent(type, bubbles, cancelable, tile);
		}
		
	}
	
}