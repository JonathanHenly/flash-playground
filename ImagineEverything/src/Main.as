package 
{
	import flash.display.MovieClip;
	import flash.display.Bitmap;
	import flash.events.*;
	
	/**
	 * ...
	 * @author Jonathan
	 */
	public class Main extends IEMovieClip 
	{
		[Embed(source = "../img/JustPeachy.png")]
		private static var JustPeachy:Class;
		public static var justPeachy:Bitmap = new JustPeachy();
		
		private var buttonArray:Array;
		
		private static var flowMode:Boolean;
		private static var puzzleMode:Boolean;
		
		private var newPuzzleMode:PuzzleMode;
		
		public static function buttonPressed(buttonID:int):void
		{
			flowMode = false;
			puzzleMode = true;
			
			if (buttonID == 1) {
				puzzleMode = true;
			}
		}
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			puzzleMode = true;
			// this.addChildCentered(Main.justPeachy, stage.stageWidth/2, stage.stageHeight/2);
			
			buttonArray = new Array();
			
			var tmpButton:BigButton;
			tmpButton = new BigButton(0, "Flow Mode");
			tmpButton.x = 100;
			tmpButton.y = 100;
			// buttonArray.push(tmpButton);
			
			tmpButton = new BigButton(1, "Picture Puzzle");
			tmpButton.x = 330;
			tmpButton.y = 100;
			// buttonArray.push(tmpButton);
			
			for (var x:int = 0; x < buttonArray.length; x++) {
				buttonArray[x].addEventListener(MouseEvent.MOUSE_OVER, buttonArray[x].onMouseOver);
				buttonArray[x].addEventListener(MouseEvent.MOUSE_OUT, buttonArray[x].onMouseOut);
				buttonArray[x].addEventListener(MouseEvent.MOUSE_DOWN, buttonArray[x].onMouseDown);
				buttonArray[x].addEventListener(MouseEvent.MOUSE_UP, buttonArray[x].onMouseUp);
				// buttonArray[x].addEventListener(MouseEvent.CLICK, buttonArray[x].onMouseClick);
				
				
				stage.addChild(buttonArray[x]);
			}
			
			newPuzzleMode = new PuzzleMode();
			
			stage.addChild(newPuzzleMode);
			
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(event:Event):void
		{
			if (puzzleMode) {
				if (newPuzzleMode.doneLoading) {
					newPuzzleMode.update();
				}
			} else if (flowMode) {
				
			}
		}
		
		public static function hideMainScreen():void
		{
			
		}
		
		private function hideScreen():void
		{
			this.visible = false;
		}
		
		public static function unhideMainScreen():void
		{
			
		}
		
	}
	
}