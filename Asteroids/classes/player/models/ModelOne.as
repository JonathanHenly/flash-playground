package 
{
	import flash.display.Graphics;
	
	/**
	 * ...
	 * @author Jonathan Henly
	 */
	public class ModelOne extends SpaceshipModels 
	{
		public function ModelOne():void
		{
			this.numOfThrusters = 1;
			this.modelName = "Construction Ship";
			this.cost = 200;
		}
		
		override public function getModelGraphics():Graphics
		{
			var mainLength:int = 6;
			var mainWidth:int = 4;
			
			this.graphics.lineStyle(0.1, 0xFFFFFF);
			// Main Body
			this.graphics.moveTo( -mainWidth, mainLength);
			this.graphics.lineTo(mainWidth, mainLength);
			this.graphics.lineTo(mainWidth, -mainLength);
			this.graphics.lineTo( -mainWidth, -mainLength);
			this.graphics.lineTo( -mainWidth, -4);
			this.graphics.moveTo( -mainWidth, 4);
			this.graphics.lineTo( -mainWidth, mainLength);
			// Sloppy Body
			this.graphics.moveTo( -6, 4);
			this.graphics.lineTo( -6, -4);
			this.graphics.lineTo( 0, -4);
			this.graphics.lineTo( 0, 4);
			this.graphics.lineTo( -6, 4);
			// Cockpit
			this.graphics.moveTo( -3, -mainLength);
			this.graphics.lineTo( -3, -mainLength - 1);
			this.graphics.lineTo( 0, -11);
			this.graphics.lineTo( 3, -mainLength - 1);
			this.graphics.lineTo( 3, -mainLength);
			// Wing Left
			
			// Wing Right
			
			//Thruster
			this.graphics.moveTo(1, 6);
			this.graphics.lineTo(3, 10);
			this.graphics.lineTo( -3, 10);
			this.graphics.lineTo( -1, 6);
			
			return this.graphics;
		}
	}
	
}