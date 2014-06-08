package 
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author ...
	 */
	public class SQR_EastEdge extends SQR_Tile
	{
		private var northTile:SQR_ITile;
		private var southTile:SQR_ITile;
		private var eastTile:SQR_ITile;
		private var westTile:SQR_ITile;
		private var originalFrame:int;
		
		public function SQR_EastEdge() {
			super();
			this.originalFrame = 5;
			this.gotoAndStop(5);
		}
		
		override public function reset():void
		{
			super.reset();
			// this.setYPos(this.getNorthTile().getYPos() + Constants.VERTICAL_SPACING_WEST);
			// this.setXPos(this.getNorthTile().getXPos() + Constants.HORIZONTAL_SPACING_WEST);
		}
	}
	
}