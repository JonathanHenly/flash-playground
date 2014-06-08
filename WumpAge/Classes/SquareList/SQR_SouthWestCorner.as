package 
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author ...
	 */
	public class SQR_SouthWestCorner extends SQR_Tile 
	{
		private var northTile:SQR_ITile;
		private var southTile:SQR_ITile;
		private var eastTile:SQR_ITile;
		private var westTile:SQR_ITile;
		private var isSelected:Boolean;
		private var originalFrame:int;

		public function SQR_SouthWestCorner() {
			super();
			this.originalFrame = 8;
			this.gotoAndStop(8);
		}
		
		override public function calculatePosition():void
		{
			this.setXPos(this.getNorthTile().getXPos() + Constants.HORIZONTAL_SPACING_WEST);
			this.setYPos(this.getNorthTile().getYPos() + Constants.VERTICAL_SPACING_WEST);
		}
		
		override public function reset():void
		{
			super.reset();
			this.setXPos(this.getNorthTile().getXPos() + Constants.HORIZONTAL_SPACING_WEST);
			this.setYPos(this.getNorthTile().getYPos() + Constants.VERTICAL_SPACING_WEST);
		}
		
	}
	
}