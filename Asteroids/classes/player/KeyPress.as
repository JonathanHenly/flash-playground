package {
	import flash.display.MovieClip;
	import flash.events.*;
	
	/**
	 * @author Jonathan Henly
	 */
	public class KeyPress extends MovieClip {
		// ARROWS
		public static var leftArrow:Boolean = false; // 37 
		public static var upArrow:Boolean = false; // 38
		public static var rightArrow:Boolean = false; // 39
		public static var downArrow:Boolean = false; // 40
		// SPACEBAR
		public static var spacebar:Boolean = false; // 32
		// AWDS
		public static var a:Boolean = false; // 65
		public static var w:Boolean = false; // 87
		public static var d:Boolean = false; // 68
		public static var s:Boolean = false; // 83
		
		public function KeyPress():void
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function onAddedToStage(event:Event):void
		{
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function onKeyUp(event:KeyboardEvent):void
		{
			if(event.keyCode == 37) {
				KeyPress.leftArrow = false;
			}
			
			if(event.keyCode == 38) {
				KeyPress.upArrow = false;
			}
			
			if(event.keyCode == 39) {
				KeyPress.rightArrow = false;
			}
			
			if(event.keyCode == 40) {
				KeyPress.downArrow = false;
			}
			
			if(event.keyCode == 32) {
				KeyPress.spacebar = false;
			}
			
			if(event.keyCode == 65) {
				KeyPress.a = false;
			}
			
			if(event.keyCode == 87) {
				KeyPress.w = false;
			}
			
			if(event.keyCode == 68) {
				KeyPress.d = false;
			}
			
			if(event.keyCode == 83) {
				KeyPress.s = false;
			}
			
		}
		
		public function onKeyDown(event:KeyboardEvent):void
		{
			if(event.keyCode == 37) {
				KeyPress.leftArrow = true;
			}
			
			if(event.keyCode == 38) {
				KeyPress.upArrow = true;
			}
			
			if(event.keyCode == 39) {
				KeyPress.rightArrow = true;
			}
			
			if(event.keyCode == 40) {
				KeyPress.downArrow = true;
			}
			
			if(event.keyCode == 32) {
				KeyPress.spacebar = true;
			}
			
			if(event.keyCode == 65) {
				KeyPress.a = true;
			}
			
			if(event.keyCode == 87) {
				KeyPress.w = true;
			}
			
			if(event.keyCode == 68) {
				KeyPress.d = true;
			}
			
			if(event.keyCode == 83) {
				KeyPress.s = true;
			}
			
		}
	}
	
}
