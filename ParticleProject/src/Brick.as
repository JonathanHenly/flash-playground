package 
{
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Jonathan Henly
	 */
	public class Brick extends MovieClip 
	{
		public var health:int = 1;
		public var brickWidth:int = 20;
		public var brickHeight:int = 20;
		public var brickHit:Boolean = false;
		public var brickDestroyed:Boolean = false;
		private var color:uint = 0;
		private var hitBox:Shape;
		
		public function Brick():void
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			hitBox = new Shape();
			createBrick();
		}
		
		private function createBrick():void
		{
			this.graphics.beginFill(0x11AADD, 1);
			this.color = 0x11AADD;
			this.graphics.drawRect(0, 0, brickWidth, brickHeight);
			this.graphics.endFill();
			
			this.hitBox.graphics.beginFill(0xFFFFFF, 1);
			this.hitBox.graphics.drawRect(0, 0, brickWidth - 2, brickHeight + 4);
			this.hitBox.graphics.endFill();
			stage.addChild(hitBox);
			hitBox.x = this.x + (this.width - hitBox.width) / 2;
			hitBox.y = this.y + (this.height - hitBox.height) / 2;
			hitBox.visible = false;
		}
		
		public function getColor():uint
		{
			return this.color;
		}
		
		public function getHitBox():Shape
		{
			return this.hitBox;
		}
		
		public function brickIsHit():void
		{
			brickHit = true;
			brickDestroyed = true;
			this.visible = false;
		}
		
		public function removeBrick():void
		{
			if(this != null) {
				this.visible = false;
				this.parent.removeChild(hitBox);
				this.parent.removeChild(this);
			}
		}
	}
	
}