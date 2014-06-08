package 
{
	import flash.display.MovieClip;
	import flash.filters.*;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Jonathan Henly
	 */
	public class MotherShipTurret extends MovieClip 
	{
		public var initX:int;
		public var initY:int;
		
		public var endX:int;
		public var endY:int;
		
		public var hasInitialized:Boolean;
		
		public var initStage:uint;
		
		public var blurFilter:BlurFilter = new BlurFilter();
		
		public function MotherShipTurret(initX:int = 0, initY:int = 0, endX:int = 0, endY:int = 0):void
		{
			this.initX = initX;
			this.initY = initY;
			
			this.endX = endX;
			this.endY = endY;
			
			this.hasInitialized = false;
			
			this.initStage = 0;
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function onAddedToStage(event:Event):void
		{
			this.x = initX;
			this.y = initY;
			this.drawTurret();
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function drawTurret():void
		{
			this.graphics.lineStyle(0.1, 0xFFFFFF);
			this.graphics.drawCircle(-8, -8, 16);
		}
		
		public function update():void
		{
			if(this.hasInitialized) { 
				this.graphics.clear();
				
				// blurFilter.blurX = Main.plusMinusCount / 1.2;
				// blurFilter.blurY = Main.plusMinusCount / 1.2;
				
				this.graphics.lineStyle(0.1, 0xFFFFFF);
					
				this.graphics.drawCircle(Main.plusMinusCount, Main.plusMinusCount, 10);
				
				// this.filters = [blurFilter];
			} else {
				this.initializeTurret();
			}
		}
		
		public function initializeTurret():void
		{
			this.hasInitialized = true;
		}
	}
	
}