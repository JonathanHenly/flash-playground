package 
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author ...
	 */
	public class SQR_NorthEastCorner extends SQR_Tile
	{
		
		private var northTile:SQR_ITile;
		private var southTile:SQR_ITile;
		private var eastTile:SQR_ITile;
		private var westTile:SQR_ITile;
		private var isSelected:Boolean;
		private var originalFrame:int;
		
		public function SQR_NorthEastCorner()
		{
			super();
			this.originalFrame = 6;
			this.gotoAndStop(6);
		}
		
		override public function calculatePosition():void
		{
				this.setXPos(this.getWestTile().getXPos() + Constants.HORIZONTAL_SPACING);
				this.setYPos(this.getWestTile().getYPos());
		}
		
		override public function reset():void
		{
			super.reset();
			this.setXPos(this.getWestTile().getXPos() + Constants.HORIZONTAL_SPACING);
			this.setYPos(this.getWestTile().getYPos());
		}
		
	}
	
}