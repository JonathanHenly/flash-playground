package  
{
	import flash.display.Bitmap;
	import flash.display.Stage;
	import flash.events.Event;
	
	import flash.filters.*;
	
	/**
	 * ...
	 * @author Jonathan
	 */
	public class PuzzlePiece extends IEMovieClip 
	{
		private var pieceIndex:int = 0;
		private var pieceInPlace:Boolean = false;
		
		private var blurFilter:BlurFilter;
		private var blurCount:int = 0;
		private var plusMinus:int = 0;
		
		private var shadowFilter:DropShadowFilter;
		private var shadowCount:int = 0;
		
		public var originalX:Number = 0;
		public var originalY:Number = 0;
		public var newX:Number = 0;
		public var newY:Number = 0;
		
		public var mouseDown:Boolean = false;
		public var ableToDrag:Boolean = true;
		public var firstRun:Boolean = true;
		
		public var blur:Boolean = false;
		
		public function PuzzlePiece(image:Bitmap, index:int) 
		{
			super();
			
			this.pieceIndex = index;
			this.addChild(image);
			
			blurFilter = new BlurFilter();
			blurCount = 20;
			plusMinus = -5;
			
			shadowFilter = new DropShadowFilter();
			shadowCount = 100;
		}
		
		public function getPieceID():int
		{
			return this.pieceIndex;
		}
		
		public function setOriginalPoint(origX:Number, origY:Number):void
		{
			originalX = origX;
			originalY = origY;
		}
		
		public function setNewPoint(newerX:Number, newerY:Number):void
		{
			newX = newerX;
			newY = newerY;
		}
		
		public function onEnterFrame(event:Event):void
		{
			if (mouseDown && firstRun) {
				firstRun = false;
				
				newX = this.x;
				newY = this.y;
			}
			
			if (mouseDown && ableToDrag) {
				
				this.x = parent.mouseX - this.width / 2;
				this.y = parent.mouseY - this.height / 2;
			}
			
			if (!mouseDown) {
				this.inPlace();
			}
			
			if (pieceInPlace) {
				if(blur) {
					this.updateBlur();
				} else {
					this.updateShadow();
				}
			}
		}
		
		public function placePiece():void
		{
			blurFilter.blurX = blurCount;
			blurFilter.blurY = blurCount;
			
			this.filters = [blurFilter];
				
			this.x = this.originalX;
			this.y = this.originalY;
			this.ableToDrag = false;
			this.pieceInPlace = true;
			
			this.ascendIndex();
			
			this.blur = true;
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function inPlace():void
		{
			if (this.x <= this.originalX + 20 && this.x >= this.originalX - 20) {
					if (this.y <= this.originalY + 20 && this.y >= this.originalY - 20) {
						this.x = this.originalX;
						this.y = this.originalY;
						
						this.ableToDrag = false;
						this.pieceInPlace = true;
						
					} else {
						this.x = this.newX;
						this.y = this.newY;
					}
				} else {
					this.x = this.newX;
					this.y = this.newY;
				}
		}
		
		private function updateBlur():void
		{
			if (blurCount > 0) {
				blurFilter.blurX = blurCount;
				blurFilter.blurY = blurCount;
				
				this.filters = [blurFilter];
				
				blurCount--;
			} else {
				this.filters = [];
				
				if (this.hasEventListener(Event.ENTER_FRAME)) {
					this.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				}
			}
		}
		
		private function updateShadow():void
		{
			if (shadowCount > 0) {
				shadowFilter.alpha = 1;
				shadowFilter.blurX = shadowCount;
				shadowFilter.blurY = shadowCount;
				shadowFilter.color = 0xFFFFFF;
				shadowFilter.distance = 0.1;
				shadowFilter.inner = true;
				shadowFilter.quality = 4;
				shadowFilter.strength = 1;
				
				this.filters = [shadowFilter]
				
				shadowCount -= 1.5;
			} else {
				this.filters = [];
			}
		}
		
		public function ascendIndex():void
		{
			parent.setChildIndex(this, parent.numChildren - 1);
		}
		
		public function descendIndex():void
		{
			parent.setChildIndex(this, 1);
		}
		
	}

}