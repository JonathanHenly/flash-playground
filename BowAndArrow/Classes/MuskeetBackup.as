package  {
	
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.utils.Timer;
	import flash.events.*;
	
	public class Muskeet extends MovieClip {
		
		public var weaponArray[1]:Musket;
		
		private var aimTimer:Timer;
		
		private var weaponArray:Array;
		// Begin Keyboard Variables
		private var rightArrow:Boolean = false;
		private var leftArrow:Boolean = false;
		private var space:Boolean = false
		// Shooting Variables
		private var thisHasNotHappened = true;
		private var cancelShot = false;
		
		public function Muskeet() {
			weaponArray = new Array();
			
			weaponArray[1] = new Musket();
			weaponArray.push(weaponArray[1]);
			
			aimTimer = new Timer(500);
			addEventListener(Event.ADDED_TO_STAGE, stageAddHandler);
		}
		
		public function stageAddHandler(event:Event):void
		{
			aimTimer.addEventListener(TimerEvent.TIMER, readyToFire);
			stage.addEventListener(Event.ENTER_FRAME, update);
			weaponArray[1].x = 100;
			weaponArray[1].y = 100;
			stage.addChild(weaponArray[1]);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, down);
			stage.addEventListener(KeyboardEvent.KEY_UP, up);
			removeEventListener(Event.ADDED_TO_STAGE, stageAddHandler);
		}
		
		private function down(event:KeyboardEvent):void
		{
			if (event.keyCode == 39)
			{
				rightArrow = true;
				cancelShot = true;
			}
			if (event.keyCode == 37)
			{
				leftArrow = true;
				cancelShot = true;
			}
			if (event.keyCode == 32)
			{
				space = true;
			}
		} // private function stage_onKeyDown(event:KeyboardEvent):void
		
		/************************************************************************************************************************
		 * Method to handle key up events
		 * 
		 * @param event - Listens for key press and then release
		**/
		private function up(event:KeyboardEvent):void
		{
			if (event.keyCode == 39)
			{
				rightArrow = false;
				cancelShot = false;
			}
			if (event.keyCode == 37)
			{
				leftArrow = false;
				cancelShot = false;
			}
			if (event.keyCode == 32)
			{
				space = false;
			}
		} 
		
		public function update(event:Event):void
		{
			if (rightArrow)
			{
				if(weaponArray[1].currentFrame < 10) {
					weaponArray[1].moveRight();
				}
			}
			if (leftArrow)
			{
				if(weaponArray[1].currentFrame < 10) {
					weaponArray[1].moveLeft();
				}
			}
			if (!space || cancelShot) {
				if (weaponArray[1].currentFrame < 6 && weaponArray[1].currentFrame != 1) {
					weaponArray[1].gotoAndPlay(10 - weaponArray[1].currentFrame);
				}
				aimTimer.stop();
				aimTimer.reset();
				thisHasNotHappened = true;
			} else if (space) {
				if (thisHasNotHappened) 
				{
					if(weaponArray[1].currentFrame == 1) {
						weaponArray[1].gotoAndPlay(2);
						aimTimer.start();
						thisHasNotHappened = false;
					}
				}
			}
		}
		
		public function readyToFire(event:TimerEvent) {
			if (aimTimer.currentCount == 1) {
				weaponArray[1].gotoAndPlay(11);
			} else if (aimTimer.currentCount > 1) {
				aimTimer.reset();
				thisHasNotHappened = true;
			}
		}

	}
	
}
