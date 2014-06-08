package 
{
	import flash.display.MovieClip
	import flash.text.Font;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Jonathan Henly
	 */
	public class Main extends MovieClip 
	{
		[Embed(source = "../fonts/Capture_it.ttf", fontName="Stencil")]
		public var StencilFont:Class;
		
		public static var startScreen:StartingScreen;
		public static var mainDisplay:MainDisplay;
		public static var ball:Ball;
		public static var paddleHum:Paddle;
		public static var paddleComp:Paddle;
		
		public static var startScreenUpdate:Boolean = false;
		public static var mainDisplayUpdate:Boolean = false;
		public static var ballUpdate:Boolean = false;
		public static var paddleHumUpdate:Boolean = false;
		public static var paddleCompUpdate:Boolean = false;
		
		public function Main():void 
		{
			startScreen = new StartingScreen();
			mainDisplay = new MainDisplay();
			ball = new Ball();
			paddleHum = new Paddle();
			paddleComp = new Paddle();
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			stage.addChild(startScreen);
		}
		
		private function onEnterFrame(event:Event):void
		{
			this.updateClasses();
			
			if (Font.enumerateFonts().length) {
				 for ( var i : int = 0; i < Font.enumerateFonts().length; i++ ) {
				 trace('Font ', Font.enumerateFonts()[i].fontName, ' Has Been Found!');
				 }
			} else {
				 trace('*********** Doh! No Fonts Found ***********')
			}
		}
		
		private function updateClasses():void
		{
			if (startScreenUpdate) {
				startScreen.update();
			} else if (mainDisplayUpdate) {
				mainDisplay.update();
			}
			
			if (ballUpdate) {
				ball.update();
			}
			
			if (paddleHumUpdate) {
				paddleHum.update();
			}
			
			if (paddleCompUpdate) {
				paddleComp.update();
			}
		}
		
	}
	
}