package 
{
	import flash.automation.KeyboardAutomationAction;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.events.*;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Jonathan Henly
	 */
	public class Driver extends MovieClip
	{
		private var timer:Timer;
		
		private var pGrid:ParticleGrid;
		
		public static var ballArray:Array;
		public static var paddle:Paddle;
		public static var brickArray:Array;
		
		private var removeBrickArray:Array;
		private var destroyedBrick:Brick;
		private var rmIndex:int = 0;
		
		private var explosionArray:Array;
		
		private var UP:Boolean = false;
		private var DOWN:Boolean = false;
		private var LEFT:Boolean = false;
		private var RIGHT:Boolean = false;
		private var SPACE:Boolean = false;
		
		private var ballLaunched:Boolean = false;
		
		public function Driver():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			timer = new Timer(1);
			pGrid = new ParticleGrid();
			stage.addChild(pGrid);
			paddle = new Paddle();
			stage.addChild(paddle);
			paddle.x = (stage.stageWidth - paddle.width) / 2;
			paddle.y = 580;
			
			ballArray = new Array();
			brickArray = new Array();
			removeBrickArray = new Array();
			explosionArray = new Array();
			
			for (var i:int = 0; i < 1; i++) {
				var tmpBall:PongBall = new PongBall();
				ballArray.push(tmpBall);
				stage.addChild(tmpBall);
				// tmpBall.x = 10 + (Math.random() * (790 - 10));
				// tmpBall.y = 10 + (Math.random() * (590 - 10));
				tmpBall.id = i;
			}
			
			createBricks()
			
			timer.addEventListener(TimerEvent.TIMER, onTimer);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(event:Event):void
		{
			var ballVelocity:Number = Math.sqrt((ballArray[0].VX * ballArray[0].VX) + (ballArray[0].VY * ballArray[0].VY));
			
			pGrid.update();
			
			if(ballLaunched) {
				for (var i:int = 0; i < ballArray.length; i++) {
					ballArray[i].update();
					
					if (ballArray[i].hitTestObject(paddle)) {
						if (ballArray[i].y > (paddle.y)) {
							ballArray[i].VX += paddle.VX/10;
							ballArray[i].reverseVY();
						}
					}
				}
			} else {
				this.startBall();
			}
			
			this.movePaddle();
			paddle.update();
			
			checkBricks();
			
			// trace(ballArray[0].touchingBrick);
			
			removeDestroyedBricks();
			
			for (var x:int = 0; x < explosionArray.length; x++) {
				if(!explosionArray[x].recycle) {
					explosionArray[x].update();
				} else {
					stage.removeChild(explosionArray[x]);
					explosionArray.splice(x, 1);
					x -= 1;
				}
			}
		}
		
		private function startBall():void
		{
			ballArray[0].x = paddle.x + paddle.width / 2;
			ballArray[0].y = paddle.y - paddle.height / 2;
		}
		
		private function launchBall():void
		{
			ballArray[0].launchBall(paddle.VX/3);
		}
		
		private function addContrailToBall():void
		{
			var tmpContrail:Contrail;
			
		}
		
		private function checkBricks():void
		{
			for (var brickCount:int = 0; brickCount < brickArray.length; brickCount++) {
				for (var ballCount:int = 0; ballCount < ballArray.length; ballCount++) {
					checkCollision(brickArray[brickCount], ballArray[ballCount], brickCount);
				}
			}
		}
		
		private function checkCollision(bk:Brick, bl:PongBall, brickIndex:int):void
		{	
			if ((!bk.brickDestroyed) && (calculateDistance(bk.getHitBox(), bl) <= calculateMinDistance(bk.getHitBox(), bl)) && !bl.touchingBrick) {
				var angle:Number = checkAngle(bl, bk);
				if (angle <= 50 && angle >= 0) {
					bl.reverseVX();
					bl.touchingBrick = true;
				} else {
					bl.reverseVY();
					bl.touchingBrick = true;
				}
				
				destroyedBrick = bk;
				rmIndex = brickIndex;
				bk.brickIsHit();
				var bExplode:BrickExplosion = new BrickExplosion(bk.getColor());
				stage.addChild(bExplode);
				var tmpPoint:Point = new Point(bk.x, bk.y);
				bExplode.x = stage.globalToLocal(tmpPoint).x - 91.25;
				bExplode.y = stage.globalToLocal(tmpPoint).y - 90.25;
				explosionArray.push(bExplode);
				stage.setChildIndex(bExplode, 3);
				removeBrickArray.push(brickIndex);
				// removeBrickArray.push(brickIndex);
			} else if ((destroyedBrick != null) && bl.touchingBrick) {
				if (calculateDistance(destroyedBrick.getHitBox(), bl) >= calculateMinDistance(destroyedBrick.getHitBox(), bl)) {
					bl.touchingBrick = false;
					// trace("mDist: " + calculateMinDistance(destroyedBrick, bl));
					// trace("dist: " + calculateDistance(destroyedBrick, bl));
					destroyedBrick = null;
				}
			}
		}
		
		private function calculateMinDistance(bk:DisplayObject, bl:PongBall):Number
		{
			var sD:Number = Math.sqrt((bk.height / 2) * (bk.height / 2) + (bk.width / 2) * (bk.width / 2));
			var bD:Number = (bl.height - 4) / 2;
			
			return sD + bD;
		}
		
		private function calculateDistance(bk:DisplayObject, bl:PongBall):Number
		{
			var dX:Number = ((bk.x + bk.width / 2) - bl.x) * ((bk.x + bk.width / 2) - bl.x);
			var dY:Number = ((bk.y + bk.height / 2) - bl.y) * ((bk.y + bk.height / 2) - bl.y);
			
			return Math.sqrt(dX + dY);
		}
		
		private function removeDestroyedBricks():void
		{
			for (var removeCount:int = 0; removeCount < removeBrickArray.length; removeCount++) {
				brickArray[removeBrickArray[removeCount]].removeBrick();
				brickArray.splice(removeBrickArray[removeCount], 1);
			}
			removeBrickArray = new Array();
		}
		
		private function checkAngle(b:MovieClip, s:MovieClip):Number
		{
			var dX:Number = ((s.x + s.width/2) - b.x) * ((s.x + s.width/2) - b.x);
			var dY:Number = ((s.y + s.height / 2) - b.y) * ((s.y + s.height / 2) - b.y);
			
			return Math.atan2(dY, dX) * (180 / Math.PI);
		}
		
		private function createBricks():void
		{
			var brickCount:int = 0;
			var tmpBrick:Brick;
			var bCol:int = 0;
			var bRow:int = 0;
			var bColMax:int = 20;
			var bRowMax:int = 10;
			var offset:int = 2;
			var stageOffset:int;
			
			stageOffset = (800 - ((bColMax * 20) + (bColMax * offset)))/2;
			
			while (bRow < bRowMax) {
				while (bCol < bColMax) {
					brickCount++;
					tmpBrick = new Brick();
					tmpBrick.x = (bCol * tmpBrick.brickWidth) + (bCol*offset) + stageOffset;
					tmpBrick.y = (bRow * tmpBrick.brickHeight) + (bRow*offset) + 50;
					brickArray.push(tmpBrick);
					stage.addChild(tmpBrick);
					bCol++;
				}
				bCol = 0;
				bRow += 1;
			}
		}
		
		private function movePaddle():void
		{
			if (DOWN) {
				
			}
			if (UP) {
				
			}
			if (RIGHT) {
				paddle.moveLeft();
			}
			if (LEFT) {
				paddle.moveRight();
			}
			if (SPACE && !ballLaunched) {
				ballLaunched = true;
				this.launchBall();
			}
		}
		
		public function onTimer(event:TimerEvent):void
		{
			
		}
		
		public function onKeyUp(event:KeyboardEvent):void
		{
			if (event.keyCode == 87 || event.keyCode == 38) {
				UP = false;
			}
			if (event.keyCode == 83 || event.keyCode == 40) {
				DOWN = false;
			}
			if (event.keyCode == 37 || event.keyCode == 65) {
				RIGHT = false;
			}
			if (event.keyCode == 39 || event.keyCode == 68) {
				LEFT = false;
			}
			if (event.keyCode == 32) {
				SPACE = false;
			}
		}
		
		public function onKeyDown(event:KeyboardEvent):void
		{
			if (event.keyCode == 87 || event.keyCode == 38) {
				UP = true;
			}
			if (event.keyCode == 83 || event.keyCode == 40) {
				DOWN = true;
			}
			if (event.keyCode == 37 || event.keyCode == 65) {
				RIGHT = true;
			}
			if (event.keyCode == 39 || event.keyCode == 68) {
				LEFT = true;
			}
			if (event.keyCode == 32) {
				SPACE = true;
			}
		}
		
	}
	
}