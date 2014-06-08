package 
{
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Jonathan Henly
	 */
	public class Main extends Sprite 
	{
		private const IDLE:Array = [ 0, 0, 64, 0, 0];
		private const SQUAT:Array = [ 64, 64, 74, 128, 0];
		private const KICK:Array = [ 215, 74, 74, 289, 0];
		private const PUNCH:Array = [ 358, 74, 74, 432, 0];
		private const FAR_KICK:Array = [ 332, 70, 70, 472, 101];
		
		private var pTimer:Timer;
		private var pOne:Player;
		private var pMask:Shape;
		private var pContainer:MovieClip;
		
		private var LEFT:Boolean = false;
		private var RIGHT:Boolean = false;
		private var A:Boolean = false;
		private var S:Boolean = false;
		private var D:Boolean = false;
		private var F:Boolean = false;
		
		private var playerAction:Boolean = false;
		private var newMove:Boolean = false;
		
		private var startIndex:int = 0;
		private var endIndex:int = 0;
		private var addAmount:int = 0;
		private var newWidth:int = 64;
		private var newY:int = 0;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			pTimer = new Timer(100);
			pTimer.addEventListener(TimerEvent.TIMER, onTimerTick);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			pOne = new Player();
			pMask = new Shape();
			pContainer = new MovieClip();
			stage.addChild(pContainer);
			
			pOne.x = 0;
			pOne.y = 0;
			pContainer.addChild(pOne);
			
			this.createMask();
			pContainer.addChild(pMask);
			pMask.x = 0;
			pOne.mask = pMask;
			
			setMoveList(IDLE);
			
			pTimer.start();
		}
		
		private function createMask():void
		{
			pMask.graphics.beginFill(0x000000, 1);
			pMask.graphics.drawRect(0, 0, 64, 96);
			pMask.graphics.endFill();
		}
		
		private function onTimerTick(event:TimerEvent):void
		{
			if (newMove) {
				pOne.x = -startIndex;
				pOne.y = -newY;
				newMove = false;
				this.pMask.width = newWidth;
			} else if(pOne.x > -endIndex && !newMove) {
					pOne.x -= addAmount;
					if (pOne.y < 0) {
						pContainer.x += 40;
					}
			}
			
			if (pOne.x <= -endIndex) {
				setMoveList(IDLE);
			}
			
			if (pTimer.currentCount > 3) {
				playerAction = false;
				pTimer.reset();
			}
		}
		
		private function setMoveList(move:Array):void
		{
			newMove = true;
			
			this.startIndex = move[0];
			this.addAmount = move[1];
			this.newWidth = move[2];
			this.endIndex = move[3];
			this.newY = move[4];
			
			this.pTimer.stop();
			this.pTimer.start();
		}
		
		private function onKeyDown(e:KeyboardEvent):void
		{
			if (e.keyCode == 37) {
				LEFT = true;
			}
			if (e.keyCode == 39) {
				RIGHT = true;
			}
			if (e.keyCode == 65) {
				A = true;
			}
			if (e.keyCode == 83) {
				S = true;
			}
			if (e.keyCode == 68) {
				D = true;
			}
			if (e.keyCode == 70) {
				F = true;
			}
		}
		
		private function onKeyUp(e:KeyboardEvent):void
		{
			if (e.keyCode == 37) {
				LEFT = false;
			}
			if (e.keyCode == 39) {
				RIGHT = false;
			}
			if (e.keyCode == 65) {
				A = false;
			}
			if (e.keyCode == 83) {
				S = false;
			}
			if (e.keyCode == 68) {
				D = false;
			}
			if (e.keyCode == 70) {
				F = false;
			}
		}
		
		private function onEnterFrame(e:Event):void
		{
			if (!playerAction) {
				if (LEFT) {
					pContainer.x -= 3;
				}
				if (RIGHT) {
					pContainer.x += 3;
				}
				if (A) {
					playerAction = true;
					setMoveList(SQUAT);
				}
				if (S) {
					playerAction = true;
					setMoveList(KICK);
				}
				if (D) {
					playerAction = true;
					setMoveList(PUNCH);
				}
				if (F) {
					playerAction = true;
					setMoveList(FAR_KICK);
				}
			}
		}
		
	}
	
}