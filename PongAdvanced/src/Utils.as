package 
{
	import flash.display.Stage;
	import flash.display.DisplayObject;
	
	/**
	 * ...
	 * @author Jonathan Henly
	 */
	public class Utils extends DisplayObject 
	{
		public static const CENTERED:int = 0;
		public static const HORIZONTAL:int = 1;
		public static const VERTICAL:int = 2;
		
		public static function fixIndex(obj:DisplayObject, stage:Stage):void
		{
			stage.setChildIndex(obj, stage.numChildren - 1);
		}
		
		public static function centerChild(mainObject:DisplayObject, childObject:DisplayObject, horzVert:int = 0, offsetX:int = 0, offsetY:int = 0):void
		{
			if (horzVert == CENTERED) {
				if (mainObject is Stage) {
					childObject.x = (((mainObject as Stage).stageWidth - childObject.width) / 2) - offsetX;
					childObject.y = (((mainObject as Stage).stageHeight - childObject.height) / 2) - offsetY;
				} else {
					childObject.x = ((mainObject.width - childObject.width) / 2) - offsetX;
					childObject.y = ((mainObject.height - childObject.height) / 2) - offsetY;
				}
			} else if (horzVert == HORIZONTAL) {
				if (mainObject is Stage) {
					childObject.x = (((mainObject as Stage).stageWidth - childObject.width) / 2) - offsetX;
				} else {
					childObject.x = ((mainObject.width - childObject.width) / 2) - offsetX;
				}
			} else {
				if (mainObject is Stage) {
					childObject.y = (((mainObject as Stage).stageHeight - childObject.height) / 2) - offsetY;
				} else {
					childObject.y = ((mainObject.height - childObject.height) / 2) - offsetY;
				}
			}
		}
	}
	
}