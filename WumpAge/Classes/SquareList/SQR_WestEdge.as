package 
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author ...
	 */
	public class SQR_WestEdge extends SQR_Tile 
	{
		private var northTile:SQR_ITile;
		private var southTile:SQR_ITile;
		private var eastTile:SQR_ITile;
		private var westTile:SQR_ITile;
		private var isSelected:Boolean;
		private var originalFrame:int;
		
		public function SQR_WestEdge()
		{
			super();
			this.originalFrame = 3;
			this.gotoAndStop(3);
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