package 
{
	
	/**
	 * ...
	 * @author ...
	 */
	public class Constants 
	{
		// Tile Width and Height
		public static var TILE_WIDTH:Number = 64.70;
		public static var TILE_HEIGHT:Number = 38.20;
		
		// Used when adding tiles to the square list
		public static var HORIZONTAL_SPACING:Number = 41.650000;
		public static var HORIZONTAL_SPACING_WEST:Number = 29.300000;
		public static var VERTICAL_SPACING_WEST:Number = 29.300000;
		
		// Used when adding terrain tiles to terrain
		public static var TERRAIN_GRID_LENGTH:int = 10;
		
		// Screen Mouse Boundary
		public static var MOVE_SCREEN_BOUNDARY:int = 20;
		// Moving the screen
		public static var HORIZONTAL_MOVE_RATE:int = 20;
		public static var VERTICAL_MOVE_RATE:int = 20;
		
		// Terrain Constants
		public static var WATER_TILE:int = 6;
		
		public static function randomNumber(high:int = 1, low:int = 0):int
		{
			return (Math.floor(Math.random()*(1+high-low))+low);
		}
		
	}
	
}