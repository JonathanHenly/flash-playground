package 
{
	import flash.display.Graphics;
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Jonathan Henly
	 */
	public class SpaceshipModels extends MovieClip implements IModel
	{
		private static var modelArray:Array = new Array();
		
		public var numOfThrusters:int;
		public var modelName:String;
		public var cost:int;
		public var modelDescription:String;
		
		public function SpaceshipModels():void
		{
			this.numOfThrusters = 0;
			this.modelName = "";
			this.cost = 0;
			this.modelDescription = "";
		}
		
		public function initialize():void
		{
			modelArray.push(new ModelOne());
			modelArray.push(new ModelTwo());
			modelArray.push(new ModelThree());
		}
		
		public function getModel(index:int):Graphics
		{
			return (modelArray[index - 1].getModelGraphics());
		}
		
		public function getModelGraphics():Graphics
		{
			return this.graphics;
		}
		
		public function getNumThrusters():uint
		{
			return this.numOfThrusters;
		}
		
		public function getNumThrusterParticles():uint
		{
			return 1;
		}
		
		public function getSpaceshipModelName():String
		{
			return this.modelName;
		}
		
		public function getModelCost():uint
		{
			return this.cost;
		}
		
		public function getDescription():String
		{
			return this.modelDescription;
		}
	}
	
}