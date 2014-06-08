package {
	import flash.utils.Timer;
	import flash.display.MovieClip;
	import flash.filters.*;
	import flash.events.*;
	/**
	 * @author Rich
	 */
	public class MenuButton extends MovieClip {
		private var moveOverTimer:Timer = new Timer(1);
		private var moveOutTimer:Timer = new Timer(1);
		private var shadowAngle:int = 0;
		private var addNegate:int = 0;
		private var origX:int = 0;
		private var origY:int = 0;
		private var endX:int = 0;
		private var endY:int = 0;
		private var VX:int = 0;
		private var VY:int = 0;
		private var newX:int = 0;
		private var newY:int = 0;
		
		public function MenuButton():void
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function onAddedToStage(event:Event):void
		{
			this.moveOverTimer.addEventListener(TimerEvent.TIMER, timerMoveOver);
			this.moveOutTimer.addEventListener(TimerEvent.TIMER, timerMoveOut);
			this.addEventListener(MouseEvent.CLICK, onMouseClick);
			this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			
			origX = this.x;
			origY = this.y;
			this.removeEventListener(Event.ADDED, onAddedToStage);
		}
		
		public function onMouseClick(event:MouseEvent):void
		{
			
		}
		
		public function onMouseOver(event:MouseEvent):void
		{
			moveOutTimer.stop();
			moveOverTimer.start();
			this.parent.setChildIndex(this, parent.numChildren - 1);
			this.applyShadow();
		}
		
		public function onMouseOut(event:MouseEvent):void
		{
			moveOverTimer.stop();
			moveOutTimer.start();
			this.removeShadow();
		}
		
		public function setEndCoords(x:int, y:int):void
		{
			this.endX = x;
			this.endY = y;
		}
		
		public function timerMoveOver(event:TimerEvent):void
		{
			this.overMove();
		}
		
		public function timerMoveOut(event:TimerEvent):void
		{
			this.outMove();
		}
		
		public function overMove():void
		{
			var distX:int = this.endX - this.x;
			var distY:int = this.endY - this.y;
			
			if (Math.abs(distX) < 1) {
				distX = 0;
				this.x = this.endX;
			}
			
			if (Math.abs(distY) < 1) {
				distY = 0;
				this.y = this.endY;
			}
			
			this.x += distX / 4;
			this.y += distY / 4;
		}
		
		public function outMove():void
		{
			var distX:int = this.x - this.origX;
			var distY:int = this.y - this.origY;
			
			if (Math.abs(distX) < 1) {
				distX = 0;
				this.x = this.origX;
			}
			
			if (Math.abs(distY) < 1) {
				distY = 0;
				this.y = this.origY;
			}
			
			if (this.x == this.origX && this.y == this.origY) {
				this.moveOutTimer.stop();
			}
			
			this.x -= distX / 6;
			this.y -= distY / 6;
		}
		
		public function setShadowAngle(angle:int):void
		{
			this.shadowAngle = angle;
		}
		
		public function applyShadow():void
		{
			var dropShadow:DropShadowFilter = new DropShadowFilter(); 
			dropShadow.distance = 1; 
			dropShadow.angle = this.shadowAngle; 
			dropShadow.color = 0xFFFFFF; 
			dropShadow.alpha = 1; 
			dropShadow.blurX = 2; 
			dropShadow.blurY = 2; 
			dropShadow.strength = 0.3; 
			dropShadow.quality = 100; 
			dropShadow.inner = true; 
			dropShadow.knockout = false; 
			dropShadow.hideObject = false;
			
			this.filters = new Array(dropShadow);
		}
		
		public function removeShadow():void
		{
			this.filters = null;
		}
		
	}
}
