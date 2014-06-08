package 
{
	import flash.display.Bitmap;
	import flash.events.*;
	
	/**
	 * ...
	 * @author Jonathan Henly
	 */
	public class SquareGrid extends EMovieClip
	{
									   // 0  1  2  3  4  5  6  7  8  9  0  1  2  3  4  5  6  7  8  9  0  1  2      
		private const LVL_ARRAY:Array = [ 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, // 1
										  1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 2, 2, 2, 1, 1, 1, 1, 1, 1, // 2
										  1, 1, 1, 1, 1, 1, 1, 0, 3, 3, 3, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, // 3
										  1, 1, 1, 1, 1, 1, 1, 0, 2, 2, 1, 1, 1, 3, 3, 1, 0, 1, 1, 1, 2, 2, 2, // 4
										  1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 2, 2, 2, 1, 1, 0, 1, 1, 0, 0, 0, 0, // 5
										  2, 2, 2, 1, 2, 2, 1, 1, 1, 0, 4, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 3, 3, // 6
										  0, 0, 0, 4, 0, 0, 0, 1, 1, 0, 4, 0, 1, 1, 5, 0, 0, 1, 1, 0, 1, 1, 1, // 7
										  3, 1, 0, 4, 0, 1, 0, 1, 1, 0, 4, 0, 1, 1, 3, 3, 1, 1, 1, 0, 0, 1, 1, // 8
										  1, 1, 0, 4, 0, 4, 0, 1, 1, 0, 4, 5, 0, 0, 1, 1, 1, 2, 2, 1, 0, 1, 1, // 9
										  1, 1, 0, 1, 0, 4, 0, 2, 2, 0, 1, 3, 1, 0, 1, 1, 0, 0, 0, 0, 0, 1, 1, // 10
										  1, 1, 5, 0, 0, 4, 5, 0, 0, 0, 1, 1, 1, 5, 0, 0, 0, 1, 3, 3, 3, 1, 1, // 11
										  1, 1, 3, 3, 3, 1, 3, 3, 3, 3, 1, 1, 1, 3, 3, 3, 3, 1, 1, 1, 1, 1, 1,]// 12
		
		private var blockArray:Array;
		
		// 0
		[Embed(source = "../img/solidDirt.png")]
		private var dTile:Class;
		private var dirtTile:Bitmap;
		// 1
		[Embed(source="../img/solidGrass.png")]
		private var gTile:Class;
		private var grassTile:Bitmap;
		// 2
		[Embed(source = "../img/dirtBottom.png")]
		private var dBTile:Class;
		private var dirtBottomTile:Bitmap;
		// 3
		[Embed(source = "../img/dirtTop.png")]
		private var dTTile:Class;
		private var dirtTopTile:Bitmap;
		// 4
		[Embed(source = "../img/dirtLeftRight.png")]
		private var dLRTile:Class;
		private var dirtLeftRightTile:Bitmap;
		// 5
		[Embed(source = "../img/bLeft.png")]
		private var blTile:Class;
		private var dblTile:Bitmap;
		
		public function SquareGrid():void
		{
			super();
		}
		
		override protected function onAddedToStage(e:Event):void
		{
			super.onAddedToStage(e);
			blockArray = new Array();
			createGrid();
		}
		
		private function createGrid():void
		{
			var numCols:int = (800 / SquareBlock.BLOCK_SIZE);
			var numRows:int = (600 / SquareBlock.BLOCK_SIZE);
			
			var rowCount:int = 0;
			var colMultiplier:int = 0;
			for (var colCount:int = 0; colCount <= LVL_ARRAY.length; colCount++) {
				var tmpSB:SquareBlock = new SquareBlock();

				
				tmpSB.x = colMultiplier * SquareBlock.BLOCK_SIZE;
				tmpSB.y = rowCount * SquareBlock.BLOCK_SIZE;
				
				blockArray.push(tmpSB);
				
				this.addChild(tmpSB);
				
				switch(LVL_ARRAY[colCount]) {
					case 0:
						dirtTile = new dTile();
						dirtTile.width = SquareBlock.BLOCK_SIZE;
						dirtTile.height = SquareBlock.BLOCK_SIZE;
						dirtTile.x = tmpSB.x;
						dirtTile.y = tmpSB.y;
						this.addChild(dirtTile);
						
						tmpSB.setPathTile(true);
						tmpSB.alpha = 0.1;
						break;
						
					case 1:
						grassTile = new gTile();
						grassTile.width = SquareBlock.BLOCK_SIZE;
						grassTile.height = SquareBlock.BLOCK_SIZE;
						grassTile.x = tmpSB.x;
						grassTile.y = tmpSB.y;
						this.addChild(grassTile);
						break;
						
					case 2:
						dirtBottomTile = new dBTile();
						dirtBottomTile.width = SquareBlock.BLOCK_SIZE;
						dirtBottomTile.height = SquareBlock.BLOCK_SIZE;
						dirtBottomTile.x = tmpSB.x;
						dirtBottomTile.y = tmpSB.y;
						this.addChild(dirtBottomTile);
						break;
						
					case 3:
						dirtTopTile = new dTTile();
						dirtTopTile.width = SquareBlock.BLOCK_SIZE;
						dirtTopTile.height = SquareBlock.BLOCK_SIZE;
						dirtTopTile.x = tmpSB.x;
						dirtTopTile.y = tmpSB.y;
						this.addChild(dirtTopTile);
						break;
						
					case 4:
						dirtLeftRightTile = new dLRTile();
						dirtLeftRightTile.width = SquareBlock.BLOCK_SIZE;
						dirtLeftRightTile.height = SquareBlock.BLOCK_SIZE;
						dirtLeftRightTile.x = tmpSB.x;
						dirtLeftRightTile.y = tmpSB.y;
						this.addChild(dirtLeftRightTile);
						break;
						
					case 5:
						dblTile = new blTile();
						dblTile.width = SquareBlock.BLOCK_SIZE;
						dblTile.height = SquareBlock.BLOCK_SIZE;
						dblTile.x = tmpSB.x;
						dblTile.y = tmpSB.y;
						this.addChild(dblTile);
						break;
					case 6:
						
						break;
				}
				
				if (colMultiplier == 22) {
					colMultiplier = 0;
					rowCount++;
					
					if (rowCount > 11) {
						break;
					}
					
				} else {
					colMultiplier += 1;
				}
			}
			
			for (var index:int = 0; index < LVL_ARRAY.length; index++) {
				if (blockArray[index].getPathTile()) {
					blockArray[index].sendToBack();
				} else {
					blockArray[index].bringToFront();
				}
			}
		}
		
		public function updateGrid():void
		{
			for (var x:int = 0; x < blockArray.length; x++) {
				blockArray[x].update();
			}
		}
	}
	
}