package 
{
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	import flash.filters.DropShadowFilter;
	
	/**
	 * ...
	 * @author Jonathan Henly
	 */
	public class SquareBlock extends EMovieClip 
	{
		public static const BLOCK_SIZE:int = 32;
		
		private var pathTile:Boolean = false;
		
		public function SquareBlock():void
		{
			super();
			
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
		}
		
		override protected function onAddedToStage(e:Event):void
		{
			super.onAddedToStage(e);
			
			graphics.lineStyle(0.1, 0xFFFFFF, 1, true);
			graphics.beginFill(0x000000, 0);
			graphics.drawRect(0, 0, BLOCK_SIZE, BLOCK_SIZE);
			graphics.endFill();
			
			alpha = 0;
		}
		
		protected function onMouseOver(e:MouseEvent):void
		{
			
		}
		
		protected function onMouseOut(e:MouseEvent):void
		{
			
		}
		
		public function setAlpha(newAlpha:Number):void
		{
			if (!pathTile) {
				alpha = newAlpha;
			} else {
				this.alpha = 0.2;
			}
		}
		
		public function setPathTile(trueFalse:Boolean):void
		{
			pathTile = trueFalse;
		}
		
		public function getPathTile():Boolean
		{
			return pathTile;
		}
		
		public function sendToBack():void
		{
			parent.setChildIndex(this, 5);
		}
		
		public function bringToFront():void
		{
			parent.setChildIndex(this, parent.numChildren - 1);
		}
		
		public function update():void
		{
			
		}
		
	}
	
}