package  
{
	import flash.display.Shape;
	import flash.events.Event;
	import flash.display.Stage;
	/**
	 * ...
	 * @author Jonathan
	 */
	public class PuzzleMode extends IEMovieClip 
	{
		public static const PUZZLE_DISPLAY_WIDTH:int = 450;
		public static const PUZZLE_DISPLAY_HEIGHT:int = 450;
		
		public var doneLoading:Boolean;
		
		private var newPuzzle:Boolean = true;
		
		private var puzzleInterface:IEMovieClip;
		
		private var puzzleDisplay:PuzzleObject;
		
		private var sideDisplayOne:Shape;
		private var sideDisplayTwo:Shape;
		
		public function PuzzleMode()
		{
			super();
			
			doneLoading = false;
			
			this.instantiatePuzzleInterface();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			// this.addChildCentered(Main.justPeachy, stage.stageWidth / 2, stage.stageHeight / 2);
		}
		
		public function endMode():void
		{
			stage.removeChild(this);
		}
		
		private function instantiatePuzzleInterface():void
		{
			puzzleInterface = new IEMovieClip();
			puzzleInterface.graphics.lineStyle(0.5, 0x888888, 1);
			puzzleInterface.graphics.drawRect(0, 0, PUZZLE_DISPLAY_WIDTH + 5, PUZZLE_DISPLAY_HEIGHT + 5);
			puzzleInterface.graphics.endFill();
			
			this.addChild(puzzleInterface);
			puzzleInterface.x = (1000 - puzzleInterface.width) / 2;
			puzzleInterface.y = ((600 - puzzleInterface.height) / 2) - 50;
			
			sideDisplayOne = new Shape();
			sideDisplayTwo = new Shape();
			
			sideDisplayOne.graphics.lineStyle(0.5, 0x888888, 1);
			sideDisplayOne.graphics.drawRect(0, 0, PUZZLE_DISPLAY_WIDTH / 2 + 5, PUZZLE_DISPLAY_HEIGHT + 5);
			sideDisplayOne.graphics.endFill();
			
			sideDisplayOne.x = puzzleInterface.x - 250;
			sideDisplayOne.y = puzzleInterface.y;
			
			sideDisplayTwo.graphics.lineStyle(0.5, 0x888888, 1);
			sideDisplayTwo.graphics.drawRect(0, 0, PUZZLE_DISPLAY_WIDTH / 2 + 5, PUZZLE_DISPLAY_HEIGHT + 5);
			sideDisplayTwo.graphics.endFill();
			
			sideDisplayTwo.x = puzzleInterface.x + puzzleInterface.width/2 + 250;
			sideDisplayTwo.y = puzzleInterface.y;
			
			this.addChild(sideDisplayOne);
			this.addChild(sideDisplayTwo);
			
			this.doneLoading = true;
		}
		
		public function getNewPuzzle():void
		{
			this.newPuzzle = true;
		}
		
		public function update():void
		{
			if (newPuzzle) {
				newPuzzle = false;
				this.puzzleDisplay = new PuzzleObject();
				this.addChildCentered(puzzleDisplay);	
			}
		}
		
		
		
	}

}