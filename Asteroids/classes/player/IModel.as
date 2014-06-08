package 
{
	import flash.display.Graphics;
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Jonathan Henly
	 */
	public interface IModel
	{	
		function getModelGraphics():Graphics;
		
		function getNumThrusters():uint;
		
		function getSpaceshipModelName():String;
		
		function getModelCost():uint;
		
		function getDescription():String;
	}
	
}