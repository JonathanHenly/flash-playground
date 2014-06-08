package 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Jonathan Henly
	 */
	public class Main extends MovieClip
	{
		private var square:MovieClip = new MovieClip();
		private var ball:MovieClip = new MovieClip();
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			this.createSquareAndBall();
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function createSquareAndBall():void
		{
			this.square.graphics.beginFill(0x000000, 1);
			this.square.graphics.drawRect(0, 0, 20, 20);
			this.square.graphics.endFill();
			
			this.ball.graphics.beginFill(0x555555, 1);
			this.ball.graphics.drawCircle(0, 0, 10);
			this.ball.graphics.endFill();
			
			stage.addChild(square);
			stage.addChild(ball);
			
			square.x = 580;
			square.y = (stage.stageHeight - square.height) / 2;
			
			ball.x = 20;
			ball.y = (stage.stageHeight) / 2;
		}
		
		private function onEnterFrame(event:Event):void
		{
			ball.x = mouseX;
			ball.y = mouseY;
			
			this.detectCollision(ball, square);
		}
		
		private function detectCollision(b:MovieClip, s:MovieClip):void
		{
			var sD:Number = Math.sqrt((s.height/2)*(s.height/2) + (s.width / 2)*(s.width / 2));
			var bD:Number = ball.height / 2;
			
			var minDist:Number = sD + bD;
			
			var dX:Number = ((s.x + s.width/2) - b.x) * ((s.x + s.width/2) - b.x);
			var dY:Number = ((s.y + s.height/2) - b.y) * ((s.y + s.height/2) - b.y);
			
			var dist:Number = Math.sqrt(dX + dY);
			
			if (dist <= minDist) {
				// trace("COLLISION!");
			}
			
			if (b.hitTestObject(s)) {
				// trace("HITTESTOBJECT!");
			}
			
			checkAngle(b, s);
		}
		
		private function checkAngle(b:MovieClip, s:MovieClip):Number
		{
			var dX:Number = ((s.x + s.width/2) - b.x) * ((s.x + s.width/2) - b.x);
			var dY:Number = ((s.y + s.height / 2) - b.y) * ((s.y + s.height / 2) - b.y);
			
			trace(Math.atan2(dY, dX) * (180 / Math.PI));
			
			return Math.atan2(dY, dX) * (180 / Math.PI);
		}
		
	}
	
}