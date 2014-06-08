package 
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.*;
	
	/**
	 * Class to create a SquareList.
	 * 
	 * @author Jonathan Henly
	 */
	public class SquareList extends MovieClip
	{
		private var head:SQR_ITile;
		private var tail:SQR_ITile;
		private static var size:int;
		private var rowCount:int;
		private var columnCount:int;
		
		public var stageRef:Stage;
		
		private var enviroment:enviroment_Sun;
		
		public function SquareList(stageReference:Stage) {
			this.head = new SQR_Tile();
			this.tail = new SQR_Tile();
			size = 0;
			this.rowCount = 0;
			this.columnCount = 0;
			
			this.head.setEastTile(this.tail);
			this.head.setNorthTile(null);
			this.head.setWestTile(null);
			this.head.setSouthTile(null);
			
			this.tail.setWestTile(this.head);
			this.tail.setNorthTile(null);
			this.tail.setSouthTile(null);
			this.tail.setEastTile(null);
			
			this.stageRef = stageReference;
			
			// stageRef.addEventListener(TileEvent.TILE_CHOSEN, tileChosen);
			// stageRef.addEventListener(TileEvent.TILE_UNCHOSEN, tileUnChosen);
			
			stageRef.addChild(this);
		}
		
		public function getRowCount():int
		{
			return this.rowCount;
		}
		
		public function getColumnCount():int
		{
			return (size / this.getRowCount());
		}
		
		public function addAfterHead(newTile:SQR_ITile):void
		{
			if (this.head.getSouthTile() != null) {
				this.head.getSouthTile().setNorthTile(newTile);
				this.head.getSouthTile().getNorthTile().setSouthTile(this.head.getSouthTile());
				this.head.setSouthTile(this.head.getSouthTile().getWestTile());
			}
			if (this.head.getEastTile() != null) {
				newTile.setEastTile(this.head.getEastTile());
				this.head.getEastTile().setWestTile(newTile);
			}
			this.head.setEastTile(newTile);
			size++;
		}
		
		public function newRow():void
		{
			this.rowCount++;
			
			this.head.getEastTile().setWestTile(null);
			
			this.head.setSouthTile(this.tail.getWestTile());
			this.tail.getWestTile().setNorthTile(this.head);
			
			this.tail.getWestTile().setEastTile(null);
			this.tail.setWestTile(this.head);
			this.head.setEastTile(this.tail);
		}
		
		public function finishedSquareList():void
		{
			this.head.getSouthTile().setNorthTile(null);
			// this.tail = null;
		}
		
		public function addToStage():void
		{
			var currentRowTile:SQR_ITile = this.head;
			var currentColumnTile:SQR_ITile = this.head;
			
			while (currentRowTile.getSouthTile() != null) {
				currentRowTile = currentRowTile.getSouthTile();
				this.addChild(currentRowTile.addToStage());
				currentColumnTile = currentRowTile;
				while (currentColumnTile.getWestTile() != null) {
					currentColumnTile = currentColumnTile.getWestTile();
					this.addChild(currentColumnTile.addToStage());
				}
			}
		}
		
		public function addTerrainToTile():void
		{
			var currentRowTile:SQR_ITile = this.head;
			var currentColumnTile:SQR_ITile = this.head;
			
			while(currentRowTile.getSouthTile() != null) {
				currentRowTile = currentRowTile.getSouthTile();
				currentRowTile.addTerrainToTile();
				currentColumnTile = currentRowTile;
				while (currentColumnTile.getWestTile() != null) {
					currentColumnTile = currentColumnTile.getWestTile();
					currentColumnTile.addTerrainToTile();
				}
			}
		}
		
		public function addEnviroments():void
		{

		}
		
		public function thisToString()
		{
			var s:String = "";
			var currentRowTile:SQR_ITile = this.head;
			var currentColumnTile:SQR_ITile = this.head;
			
			while (currentRowTile.getSouthTile() != null) {
				currentRowTile.toString();
				currentRowTile = currentRowTile.getSouthTile();
				currentColumnTile = currentRowTile;
				while (currentColumnTile.getWestTile() != null) {
					currentColumnTile = currentColumnTile.getWestTile();
				}
			}
		}
		
		public function moveHorizontal(rate:int)
		{
			this.x += rate;
		}
		
		public function moveVertical(rate:int)
		{
			this.y += rate;
		}
		
	}
	
}