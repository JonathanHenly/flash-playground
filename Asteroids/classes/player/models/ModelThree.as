package 
{
	import flash.display.Graphics;
	
	/**
	 * ...
	 * @author Jonathan Henly
	 */
	public class ModelThree extends SpaceshipModels 
	{
		public function ModelThree():void
		{
			this.numOfThrusters = 0;
			this.modelName = "Wide";
			this.cost = 100;
		}
		
		override public function getModelGraphics():Graphics
		{
			this.graphics.lineStyle(0.1, 0xFFFFFF);
			this.graphics.beginFill(0x000000, 1);
			this.graphics.moveTo(0, -3);
			this.graphics.lineTo(3, 3);
			this.graphics.lineTo( -3, 3);
			this.graphics.lineTo(0, -3);
			this.graphics.endFill();
			
			return this.graphics;
		}
	}
	
}