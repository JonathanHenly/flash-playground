package 
{
	import flash.display.Stage;
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.*;
	
	public class ProcessOne
	{
		// PUBLIC VARIABLES

		// PRIVATE VARIABLES
		private static var stageRef:Stage;
		
		private static var GRID:Array;
		private static var squareList:SquareList;

		private static var initializeTimer:Timer;
		
		private static var processLoader:loadBar;
		private static var createLoader:loadBar;
		private static var stageAddLoader:loadBar;
		private static var terrainAddLoader:loadBar;
		
		public static var rightLimit:int = 0;
		public static var leftLimit:int = 0;
		public static var bottomLimit:int = 0;
		public static var topLimit:int = 0;
		
		private static var setRows:int = 5;
		private static var setColumns:int = 5;
		
		
		public static function getSquareList():SquareList
		{
			return squareList;
		}
		
		public static function initialize(stageOne:Stage):void
		{
			initializeTimer = new Timer(1, setRows - 2);

			stageRef = stageOne;

			GRID = new Array();

			initializeTimer.addEventListener(TimerEvent.TIMER, doProcess);
			initializeTimer.addEventListener(TimerEvent.TIMER_COMPLETE, processComplete);

			squareList = new SquareList(stageRef);
			
			processLoader = new loadBar();
			processLoader.x = 100;
			processLoader.y = 130;
			processLoader.gotoAndPlay(79);
			stageRef.addChild(processLoader);
			
			createLoader = new loadBar();
			createLoader.x = 100;
			createLoader.y = 160;
			createLoader.gotoAndPlay(40);
			stageRef.addChild(createLoader);
			
			stageAddLoader= new loadBar();
			stageAddLoader.x = 100;
			stageAddLoader.y = 190;
			stageAddLoader.gotoAndPlay(1);
			stageRef.addChild(stageAddLoader);
			
			terrainAddLoader = new loadBar();
			terrainAddLoader.x = 100;
			terrainAddLoader.y = 220;
			terrainAddLoader.gotoAndPlay(1);
			stageRef.addChild(terrainAddLoader);
			ProcessOne.beginProcess();
		}
		
		private static function beginProcess():void
		{
			var tempArray:Array = new Array();
			
			tempArray.push(1);
			for (var x:int = 1; x < setColumns-1; x++) {
				tempArray.push(2);
			}
			tempArray.push(3);
			
			GRID.push(tempArray);
			
			initializeTimer.start();
		}
		
		
		
		private static function doProcess(event:TimerEvent):void
		{
			processLoader.width = ((initializeTimer.currentCount / setRows) * 4) * 100;
			var tempArray:Array = new Array();
			
			tempArray.push(8);
			for (var columns:int = 0; columns < setColumns-2; columns++) {
				tempArray.push(0);
			}
			tempArray.push(4);
			
			GRID.push(tempArray);
		}
		
		private static function endProcess():void
		{
			var tempArray:Array = new Array();
			
			tempArray.push(7);
			for (var y:int = 1; y < setColumns-1; y++) {
				tempArray.push(6);
			}
			tempArray.push(5);
			GRID.push(tempArray);
		}
		
		
		
		private static function processComplete(event:TimerEvent):void
		{
			endProcess();
			initializeTimer.removeEventListener(TimerEvent.TIMER, doProcess);
			initializeTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, processComplete);
			initializeTimer.reset();
			processLoader.width = 400;
			initializeTimer = new Timer(1, setRows);
			initializeTimer.addEventListener(TimerEvent.TIMER, createSquareList);
			initializeTimer.addEventListener(TimerEvent.TIMER_COMPLETE, createComplete);
			initializeTimer.start();
		}
		
		private static function createSquareList(event:TimerEvent):void {
			createLoader.width = ((initializeTimer.currentCount / setRows) * 4) * 100;
			var row:int = (initializeTimer.currentCount-1);
			for (var column:int = 0; column < GRID[row].length; column++)
			{
				switch(GRID[row][column])
				{
					case 0:
						squareList.addAfterHead(new SQR_Tile());
						break;
						
					case 1:
						squareList.addAfterHead(new SQR_SouthEastCorner());
						break;
						
					case 2:
						squareList.addAfterHead(new SQR_SouthEdge());
						break;
						
					case 3:
						squareList.addAfterHead(new SQR_SouthWestCorner());
						break;
						
					case 4:
						squareList.addAfterHead(new SQR_WestEdge());
						break;
						
					case 5:
						squareList.addAfterHead(new SQR_NorthWestCorner());
						break;
						
					case 6:
						squareList.addAfterHead(new SQR_NorthEdge());
						break;
						
					case 7:
						squareList.addAfterHead(new SQR_NorthEastCorner());
						break;
						
					case 8:
						squareList.addAfterHead(new SQR_EastEdge());
						break;
				}
				
			}
			squareList.newRow();
		}
		
		private static function createComplete(event:TimerEvent):void
		{
			squareList.finishedSquareList();
			initializeTimer.removeEventListener(TimerEvent.TIMER, createSquareList);
			initializeTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, createComplete);
			initializeTimer.reset();
			
			createLoader.width = 400;
			
			initializeTimer = new Timer(1, setColumns);
			initializeTimer.addEventListener(TimerEvent.TIMER, addListToStage);
			initializeTimer.addEventListener(TimerEvent.TIMER_COMPLETE, addListComplete);
			squareList.visible = false;
			initializeTimer.start();
		}
		
		private static function addListToStage(event:TimerEvent):void
		{
			stageAddLoader.width = ((initializeTimer.currentCount / setColumns) * 4)*100;
			squareList.addToStage();
		}
		
		private static function addListComplete(event:TimerEvent):void
		{
			squareList.visible = false;
			initializeTimer.removeEventListener(TimerEvent.TIMER, addListToStage);
			initializeTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, addListComplete);
			initializeTimer.reset();
			
			stageAddLoader.width = 400;
			
			initializeTimer = new Timer(1, setColumns);
			initializeTimer.addEventListener(TimerEvent.TIMER, addTerrainToTiles);
			initializeTimer.addEventListener(TimerEvent.TIMER_COMPLETE, addTerrainComplete);
			initializeTimer.start();
		}
		private static function addTerrainToTiles(event:TimerEvent):void
		{
			terrainAddLoader.width = ((initializeTimer.currentCount / setRows) * 4) * 100;
			squareList.addTerrainToTile();
		}
		
		private static function addTerrainComplete(event:TimerEvent):void
		{
			initializeTimer.removeEventListener(TimerEvent.TIMER, addTerrainToTiles);
			terrainAddLoader.width = 400;
			
			// stageRef.gotoAndStop(2);
			removeLoadBars();
			// addEventListener(Event.ENTER_FRAME, onEnterFrame);
			// trace(Math.ceil(squareList.width / setRows) * setColumns, (5 * setColumns));
			rightLimit =  -1000; // (Math.ceil(squareList.width/setRows) - (5*setColumns)) * -1;
			// rightLimit = (Math.ceil(70.926250 * (setColumns) + 6.1625) - (setColumns * 10)) * -1;
			bottomLimit = (Math.ceil(squareList.height/2) - (2*setRows)) * -1;
			topLimit = 50;
			
			squareList.visible = true;
			stageRef.dispatchEvent(new WumpAgeEvent(WumpAgeEvent.PROCESS_ONE_COMPLETE, true));
			initializeTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, addTerrainComplete);
		}
		
		private static function removeLoadBars():void
		{
			stageRef.removeChild(processLoader);
			stageRef.removeChild(createLoader);
			stageRef.removeChild(stageAddLoader);
			stageRef.removeChild(terrainAddLoader);
		}
		
	}
}