package  {
	
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.utils.Timer;
	import flash.events.*;
	
	public class Muskeet extends MovieClip {
		
		private static var aimTimer:Timer;
		
		private static var weaponArray:Array;
		private static var weaponNumber:int = 0;
		// Begin Keyboard Variables
		private static var rightArrow:Boolean = false;
		private static var leftArrow:Boolean = false;
		private static var space:Boolean = false
		// Shooting Variables
		private static var thisHasNotHappened = true;
		private static var cancelShot = false;
		
		private static var trueFalse = false;
		
		public function Muskeet() {
			weaponArray = new Array();
			
			weaponArray.push(new Musket());
			
			aimTimer = new Timer(weaponArray[getWeaponNumber()].getDelay());
			addEventListener(Event.ADDED_TO_STAGE, stageAddHandler);
		}
		
		public function stageAddHandler(event:Event):void
		{
			aimTimer.addEventListener(TimerEvent.TIMER, readyToFire);
			stage.addEventListener(Event.ENTER_FRAME, update);
			setWeaponXY(100, 100);
			stage.addChild(weaponArray[getWeaponNumber()]);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, down);
			stage.addEventListener(KeyboardEvent.KEY_UP, up);
			removeEventListener(Event.ADDED_TO_STAGE, stageAddHandler);
		}
		
		public static function setWeaponArray(array:Array):void
		{
			weaponArray = array;
		}
		
		private static function getWeaponArray():Array
		{
			return weaponArray;
		}
		
		private static function getWeaponNumber():int
		{
			return weaponNumber;
		}
		
		public static function setWeaponNumber(number:int):void
		{
			weaponNumber = number;
		}
		
		private static  function setWeaponXY(newX:int, newY:int) {
			weaponArray[getWeaponNumber()].x = newX;
			weaponArray[getWeaponNumber()].y = newY;
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
		
		public static function update(event:Event):void
		{
			ableToShoot();
			trace(trueFalse);
			if (rightArrow)
			{
				if(weaponArray[getWeaponNumber()].currentFrame < 10) {
					weaponArray[getWeaponNumber()].moveRight();
				}
			}
			if (leftArrow)
			{
				if(weaponArray[getWeaponNumber()].currentFrame < 10) {
					weaponArray[getWeaponNumber()].moveLeft();
				}
			}
			if (!space || cancelShot) {
				if (weaponArray[getWeaponNumber()].currentFrame < 6 && weaponArray[getWeaponNumber()].currentFrame != 1) {
					weaponArray[getWeaponNumber()].gotoAndPlay(10 - weaponArray[getWeaponNumber()].currentFrame);
				}
				aimTimer.stop();
				aimTimer.reset();
				thisHasNotHappened = true;
			} else if (space) {
				if (thisHasNotHappened) 
				{
					if(weaponArray[getWeaponNumber()].currentFrame == 1) {
						weaponArray[getWeaponNumber()].gotoAndPlay(2);
						aimTimer.start();
						thisHasNotHappened = false;
					}
				}
			}
		}
		
		private static function ableToShoot() {
			trueFalse = (trueFalse == true) ? false : true;
		}
		
		private function readyToFire(event:TimerEvent) {
			if (aimTimer.currentCount == 1) {
				weaponArray[getWeaponNumber()].gotoAndPlay(11);
			} else if (aimTimer.currentCount > 1) {
				aimTimer.reset();
				thisHasNotHappened = true;
			}
		}

	}
	
}
