package 
{
	import flash.display.Graphics;
	
	/**
	 * ...
	 * @author Jonathan Henly
	 */
	public class ModelTwo extends SpaceshipModels 
	{
		public function ModelTwo():void
		{
			this.numOfThrusters = 1;
			this.modelName = "Star Ship";
			this.cost = 500;
		}
		
		override public function getModelGraphics():Graphics
		{
			var X_SIZE:int = 3;
			var Y_SIZE:int = 10;
			
			this.graphics.lineStyle(0.1, 0xFFFFFF);
			
			this.graphics.moveTo(-X_SIZE, Y_SIZE/2);
			this.graphics.lineTo(0, -Y_SIZE/2);
			this.graphics.lineTo(X_SIZE, Y_SIZE/2);
			this.graphics.lineTo(-X_SIZE, Y_SIZE/2);
			this.graphics.endFill();
			
			return this.graphics;
		}
	}
	
}