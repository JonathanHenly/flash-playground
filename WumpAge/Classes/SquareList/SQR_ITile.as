package  {
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Stage;
	
	
	public interface SQR_ITile {
		// private var northTile:SQR_ITile;
		// private var southTile:SQR_ITile;
		// private var eastTile:SQR_ITile;
		// private var westTile:SQR_ITile;
		
		
		/******************************************************************************************
		 * CONSTRUCTOR
		**/
		// function ITile(type:int);
			/**
			 * Type Classifications
			 * ---------------------
			 * |0 = Middle Tile
			 * |1,3,5,7 = Corner Tiles
			 * |2 = North Edge Tiles
			 * |4 = East Edge Tiles
			 * |6 = South Edge Tiles
			 * |8 = West Edge Tiles
			 * ---------------------
			**/	
			
		function getNorthTile():SQR_ITile;
		
		function getSouthTile():SQR_ITile;
		
		function getEastTile():SQR_ITile;
		
		function getWestTile():SQR_ITile;
		
		function getXPos():Number;
		
		function getYPos():Number;
		
		/******************************************************************************************
		 * MUTATORS
		**/
		function setNorthTile(tile:SQR_ITile):void;
		
		function setSouthTile(tile:SQR_ITile):void;
		
		function setEastTile(tile:SQR_ITile):void;
		
		function setWestTile(tile:SQR_ITile):void;
		
		function setXPos(newX:Number):void;
		
		function setYPos(newY:Number):void;
		
		/******************************************************************************************
		 * MAIN METHODS
		**/
		function calculatePosition():void;
		
		function addToStage():DisplayObject;
		
		function addTerrainToTile():void;
		
		function reset():void;
		
		function toString():String;
		
		function surroundingTilesToString():String;
		
	}
	
}

