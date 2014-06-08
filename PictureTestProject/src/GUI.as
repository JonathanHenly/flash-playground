package {
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.filters.*;
	import flash.events.*;
	
	public class GUI {
		public static var scrollCircle:MovieClip;
		private var scrollBar:Shape;
		
		public function GUI() extends MovieClip {
			scrollCircle = new MovieClip();
			scrollBar = new Shape();
			
			this.createScrollCircle();
			this.createScrollBar();
		}
		
		private function createScrollCircle() {
			
		}
		
		private function createScrollBar() {
			
		}

	}
	
}
