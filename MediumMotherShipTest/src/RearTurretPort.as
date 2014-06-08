package 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Jonathan Henly
	 */
	public class RearTurretPort extends MovieClip
	{
		
		
		public function RearTurretPort():void
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
			this.graphics.lineStyle(0.1, 0xFFFFFF);
			this.graphics.moveTo(0, 0);
			this.graphics.lineTo( ( -30 * -3) - ( -20 * -3), ( -45 * -3) - ( -35 * -3));
			this.graphics.moveTo(0 + 4, 0);
			this.graphics.lineTo( ( -15 * -3) - ( -20 * -3) + 4, ( -22.5 * -3) - ( -35 * -3));
		}
	}
	
}