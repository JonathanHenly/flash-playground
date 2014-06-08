package
{
	import flash.geom.Matrix;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Terrain extends MovieClip 
	{
		private var TGRID:Array;
		private var terrainMask:TerrainMask;
		private var parentTile:SQR_ITile;
		
		public function Terrain() 
		{
			this.TGRID = new Array();
			this.parentTile = (this.parent as SQR_ITile);
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function createTerrainTiles(firstTile:Boolean = false):void
		{
			var tempArray:Array;
			for (var rows:int = 0; rows <= Constants.TERRAIN_GRID_LENGTH; rows++)
			{
				tempArray = new Array()
				
				for (var columns:int = 0; columns <= Constants.TERRAIN_GRID_LENGTH; columns++)
				{
					var tempTerrainTile:TerrainTile;
					var tempId:int = 1;
					var s:String = "";
					
					if (firstTile) {
						s = ("(" + rows + ", " + columns + ") - ");
						
						if (rows == 0 && columns == 0) {
							tempId = Constants.randomNumber(5, 1);
						} else if (rows == 0 && columns > 0) {
							if (tempArray[columns - 1].getTileId() < Constants.randomNumber(5, 1))
							{
								tempId = Constants.WATER_TILE;
							} else {
								tempId = 4;
							}
						} else if (rows > 0 && columns > 0) {
							trace("columns-1 id: " + tempArray[columns - 1].getTileId() + " TGRID id: " + TGRID[rows - 1][columns].getTileId());
							if (tempArray[columns - 1].getTileId() == Constants.WATER_TILE || TGRID[rows-1][columns].getTileId() == Constants.WATER_TILE)
							{
								if (Constants.randomNumber(20, 0) <= 15) {
									tempId = Constants.WATER_TILE;
								} else {
									tempId = 2;
								}
							}
						}
						
					} else {
						s = ("(" + rows + ", " + columns + ") - ");
						
						if (rows == 0 && columns == 0) {
							tempId = 2;
							s += ("TOP LEFT CORNER");
						} else if (rows >= Constants.TERRAIN_GRID_LENGTH && columns == 0) {
							tempId = 2;
							s += ("BOTTOM LEFT CORNER");
						} else if (rows == 0 && columns == Constants.TERRAIN_GRID_LENGTH) {
							tempId = 2;
							s += ("TOP RIGHT CORNER");
						} else if (rows == Constants.TERRAIN_GRID_LENGTH && columns == Constants.TERRAIN_GRID_LENGTH) {
							tempId = 2;
							s += ("BOTTOM RIGHT CORNER");
						} else if (rows > 0 && columns < 1) { // West Edge Tiles
							tempId = 4;
							s += ("WEST EDGE");
						} else if (rows >= Constants.TERRAIN_GRID_LENGTH && columns < Constants.TERRAIN_GRID_LENGTH) {
							tempId = 4;
							s += ("SOUTH EDGE");
						} else if (rows == 0 && columns > 0) {
							tempId = 4;
							s += ("NORTH EDGE");
						} else if (rows > 0 && columns >= Constants.TERRAIN_GRID_LENGTH) {
							tempId = 4;
							s += ("EAST EDGE");
						} else if (rows > 0 && columns > 0) {
							tempId = Constants.randomNumber(6, 6);
							s += ("MIDDLE TILE");
						}
					}
					
					tempTerrainTile = new TerrainTile(tempId);
					
					tempTerrainTile.x = (columns * 3.9) -1.5;
					tempTerrainTile.y = (rows * 3.9) -1.5;
					tempTerrainTile.mouseChildren = false;
					tempTerrainTile.mouseEnabled = false;
					
					tempArray.push(tempTerrainTile);
				}
				
				this.TGRID.push(tempArray);
			}
			
			this.addTilesToTerrain();
		}
		
		public function addTilesToTerrain():void
		{
			for (var rows:int = 0; rows <= Constants.TERRAIN_GRID_LENGTH; rows++)
			{
				for (var columns:int = 0; columns <= Constants.TERRAIN_GRID_LENGTH; columns++)
				{
					this.addChild(this.TGRID[rows][columns]);
				}
			}
			
			this.terrainMask = new TerrainMask();
			this.mask = this.terrainMask;
			this.addChild(this.terrainMask);
			terrainMask.x = this.x;
			terrainMask.y = this.y;
		}
		
	}

}