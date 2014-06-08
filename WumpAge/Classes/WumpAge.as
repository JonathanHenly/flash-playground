package  {
	
	// import com.demonsters.debugger.MonsterDebugger;
	import flash.display.Stage;
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.utils.Timer;
	
	public class WumpAge extends MovieClip {
		private var stageRef:Stage;
		private var squareList:SquareList;
		
		public function WumpAge() {
			// MonsterDebugger.initialize(this);
			this.stageRef = stage;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void {
			stageRef.addEventListener(WumpAgeEvent.PROCESS_ONE_COMPLETE, onProcessOneComplete);
			// this.addChild(ProcessOne);
			this.initializeVariables();
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function initializeVariables():void {
			this.processOne();
		}
		
		private function processOne():void
		{
			ProcessOne.initialize(stage);
		}
		
		private function onProcessOneComplete(event:WumpAgeEvent):void
		{
			this.squareList = ProcessOne.getSquareList();
			this.gotoAndStop(2);
			this.squareList.addEnviroments();
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener(MouseEvent.CLICK, onStageClick);
			this.removeEventListener(WumpAgeEvent.PROCESS_ONE_COMPLETE, onProcessOneComplete);
		}
		
		private function onEnterFrame(event:Event):void {
			this.moveScreen();
		}
		
		private function onStageClick(event:MouseEvent):void {
			// this.squareList.addToStage();
		}
		
		private function moveScreen()
		{
			// trace("SQX: " + this.squareList.x + " SQY: " + this.squareList.y + " PORL: " + ProcessOne.rightLimit + " POBL: " + ProcessOne.bottomLimit);
			if (this.mouseX > stageRef.stageWidth - Constants.MOVE_SCREEN_BOUNDARY)
			{
				if(this.squareList.x > ProcessOne.rightLimit) {
					this.squareList.moveHorizontal(Constants.HORIZONTAL_MOVE_RATE * -1);
				}
			} else if (this.mouseX < Constants.MOVE_SCREEN_BOUNDARY) {
				if(this.squareList.x < ProcessOne.leftLimit) {
					this.squareList.moveHorizontal(Constants.HORIZONTAL_MOVE_RATE);
				}
			}
			if (this.mouseY > stageRef.stageHeight - Constants.MOVE_SCREEN_BOUNDARY)
			{
				if(this.squareList.y > ProcessOne.bottomLimit) {
					this.squareList.moveVertical(Constants.VERTICAL_MOVE_RATE * -1);
					this.squareList.moveHorizontal(Constants.HORIZONTAL_MOVE_RATE * -1);
					ProcessOne.leftLimit -= 10;
				}
			} else if (this.mouseY < Constants.MOVE_SCREEN_BOUNDARY) {
				if(this.squareList.y < ProcessOne.topLimit) {
					this.squareList.moveVertical(Constants.VERTICAL_MOVE_RATE);
					this.squareList.moveHorizontal(Constants.HORIZONTAL_MOVE_RATE);
					ProcessOne.leftLimit += 10;
				}
			}
			
			if (this.squareList.x <= ProcessOne.rightLimit) {
				this.squareList.x = ProcessOne.rightLimit;
			}
			
			if (this.squareList.x >= ProcessOne.leftLimit) {
				this.squareList.x = ProcessOne.leftLimit;
			}
			
			if (this.squareList.y <= ProcessOne.bottomLimit) {
				this.squareList.y = ProcessOne.bottomLimit;
			}
		}
		
	}
	
}