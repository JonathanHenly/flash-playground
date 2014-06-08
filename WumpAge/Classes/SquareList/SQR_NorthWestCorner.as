package 
{
	import flash.geom.Matrix;
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author ...
	 */
	public class SQR_NorthWestCorner extends SQR_Tile
	{
		private var northTile:SQR_ITile;
		private var southTile:SQR_ITile;
		private var eastTile:SQR_ITile;
		private var westTile:SQR_ITile;
		private var isSelected:Boolean;
		private var originalFrame:int;
		
		private var terrain:Terrain;
		
		public function SQR_NorthWestCorner() {
			super();
			this.originalFrame = 2;
			this.gotoAndStop(2);
		}
		
		override public function calculatePosition():void
		{
			this.setXPos(50);
			this.setYPos(50);
		}
		
		override public function addTerrainToTile():void
		{
			this.terrain = new Terrain();
			terrain.createTerrainTiles(true);
			
			var mtx:Matrix = new Matrix();
			mtx.b = Math.tan(0 * Math.PI / 180);
			mtx.c = Math.tan(45 * Math.PI / 180);
			mtx.concat(this.terrain.transform.matrix);
			this.terrain.transform.matrix = mtx;
			
			this.terrain.scaleY = 1.00;
			
			this.addChild(this.terrain);
		}	
		
		override public function reset():void
		{
			super.reset();
			this.setXPos(50);
			this.setYPos(50);
		}
		
	}
	
}