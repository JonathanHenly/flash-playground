package  {
	
	import flash.display.MovieClip;
	
	
	public class TerrainTile extends MovieClip {
		
		public var tileId:int;
		
		public function TerrainTile(id:int = 1)
		{
			this.tileId = id
			this.gotoAndStop(id);
		}
		
		public function getTileId():int
		{
			return this.tileId;
		}
		
	}
	
}
