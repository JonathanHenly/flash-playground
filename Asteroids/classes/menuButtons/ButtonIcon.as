package 
{
	import flash.display.MovieClip;
	import flash.display.GradientType;
	import flash.geom.Matrix;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ButtonIcon extends MovieClip
	{
		private var type:String = GradientType.RADIAL;
		private var colors:Array = [0x808080, 0xFFFFFF, 0xF0F0F0, 0xFFFFFF];
		private var alphas:Array = [1, 1, 1, 1];
		private var ratios:Array = [0, 180, 220, 255];
		private var focalPtRatio:Number = 0;
		
		private var gradientBoxMatrix:Matrix = new Matrix();
		private var boxWidth:Number = 40;
		private var boxHeight:Number = 40;
		private var boxRotation:Number = Math.PI/4.09; // 90°
		private var tx:Number = 0;
		private var ty:Number = -10;
		
		public function ButtonIcon()
		{
			this.createIconBox();
		}
		
		public function createIconBox():void
		{	
			gradientBoxMatrix.createGradientBox(boxWidth, boxHeight, boxRotation, tx, ty);
			
			this.graphics.lineStyle(5, 1);
			this.graphics.lineGradientStyle(GradientType.LINEAR, colors, alphas, ratios, gradientBoxMatrix);
			this.graphics.drawRoundRect(0, 0, 40, 40, 20, 20);
			this.graphics.endFill();
		}
	}
	
}