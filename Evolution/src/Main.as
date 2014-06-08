package 
{
	import flash.display.SimpleButton;
	import flash.display.MovieClip;
	import flash.events.*;
	import mx.core.ButtonAsset;
	
	/**
	 * ...
	 * @author Jonathan Henly
	 */
	public class Main extends EMovieClip 
	{
		private var b:SimpleButton = new SimpleButton();
		private var layout:Layout;
		
		
		public function Main():void 
		{
			b.x = 0;
			b.y = 0;
			stage.addChild(b);
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			layout = new Layout();
			stage.addChild(layout);
		}
		
		private function onEnterFrame(e:Event):void
		{
			layout.update();
		}
		
	}
	
}