package ships 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Jonathan Henly
	 */
	public class MediumMotherShip extends MovieClip 
	{
		
		public function MediumMotherShip() 
		{
			
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function onAddedToStage(event:Event):void
		{
			
			this.drawGraphics();
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function drawGraphics():void
		{
			var SCALE_AMOUNT:int = -3;
			
			this.graphics.lineStyle(0.1, 0xFFFFFF);
			this.graphics.beginFill(0x000000, 1);
			this.graphics.moveTo( -10 * SCALE_AMOUNT, 50 * SCALE_AMOUNT);
			this.graphics.lineTo( -20 * SCALE_AMOUNT, 40 * SCALE_AMOUNT);
			this.graphics.lineTo( -20 * SCALE_AMOUNT, 30 * SCALE_AMOUNT);
			this.graphics.lineTo(-15 * SCALE_AMOUNT, 30 * SCALE_AMOUNT);
			this.graphics.lineTo(-20 * SCALE_AMOUNT, 20 * SCALE_AMOUNT);
			this.graphics.lineTo(-15 * SCALE_AMOUNT, 15 * SCALE_AMOUNT);
			this.graphics.lineTo(-10 * SCALE_AMOUNT, 15 * SCALE_AMOUNT);
			this.graphics.lineTo(-10 * SCALE_AMOUNT, -15 * SCALE_AMOUNT)
			this.graphics.lineTo( -15 * SCALE_AMOUNT, -15 * SCALE_AMOUNT);
			this.graphics.lineTo( -20 * SCALE_AMOUNT, -20 * SCALE_AMOUNT);
			this.graphics.lineTo( -20 * SCALE_AMOUNT, -35 * SCALE_AMOUNT);
			this.graphics.lineTo( -30 * SCALE_AMOUNT, -45 * SCALE_AMOUNT);
			this.graphics.lineTo(-45 * SCALE_AMOUNT, -50 * SCALE_AMOUNT);
			this.graphics.lineTo( -50 * SCALE_AMOUNT, -60 * SCALE_AMOUNT);
			this.graphics.lineTo( -40 * SCALE_AMOUNT, -70 * SCALE_AMOUNT);
			this.graphics.lineTo( -40 * SCALE_AMOUNT, -80 * SCALE_AMOUNT);
			this.graphics.lineTo( -10 * SCALE_AMOUNT, -100 * SCALE_AMOUNT);
			this.graphics.lineTo( 10 * SCALE_AMOUNT, -100 * SCALE_AMOUNT);
			this.graphics.lineTo(40 * SCALE_AMOUNT, -80 * SCALE_AMOUNT);
			this.graphics.lineTo(40 * SCALE_AMOUNT, -70 * SCALE_AMOUNT);
			this.graphics.lineTo(50 * SCALE_AMOUNT, -60 * SCALE_AMOUNT);
			this.graphics.lineTo(45 * SCALE_AMOUNT, -50 * SCALE_AMOUNT);
			this.graphics.lineTo(30 * SCALE_AMOUNT, -45 * SCALE_AMOUNT);
			this.graphics.lineTo(20 * SCALE_AMOUNT, -35 * SCALE_AMOUNT);
			this.graphics.lineTo(20 * SCALE_AMOUNT, -20 * SCALE_AMOUNT);
			this.graphics.lineTo(15 * SCALE_AMOUNT, -15 * SCALE_AMOUNT);
			this.graphics.lineTo(10 * SCALE_AMOUNT, -15 * SCALE_AMOUNT);
			this.graphics.lineTo(10 * SCALE_AMOUNT, 15 * SCALE_AMOUNT);
			this.graphics.lineTo(15 * SCALE_AMOUNT, 15 * SCALE_AMOUNT);
			this.graphics.lineTo(20 * SCALE_AMOUNT, 20 * SCALE_AMOUNT);
			this.graphics.lineTo(15 * SCALE_AMOUNT, 30 * SCALE_AMOUNT);
			this.graphics.lineTo(20 * SCALE_AMOUNT, 30 * SCALE_AMOUNT);
			this.graphics.lineTo(20 * SCALE_AMOUNT, 40 * SCALE_AMOUNT);
			this.graphics.lineTo(10 * SCALE_AMOUNT, 50 * SCALE_AMOUNT);
			this.graphics.lineTo(-10 * SCALE_AMOUNT, 50 * SCALE_AMOUNT);
			
		}
		
	}

}