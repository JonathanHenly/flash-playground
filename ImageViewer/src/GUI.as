package  
{
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.filters.*;
	import flash.events.*;
	
	public class GUI extends MovieClip 
	{
		// BEGIN CONSTANTS
		private const SCROLL_BAR_X:int = 50;
		private const SCROLL_BAR_Y:int = 486;
		private const SCROLL_BAR_VERT_X:int = Main.THE_BIG_SCREEN_X + Main.THE_BIG_SCREEN_WIDTH + 4;
		private const SCROLL_BAR_VERT_Y:int = Main.THE_BIG_SCREEN_Y + 3;
		private const SCROLL_BAR_HORZ_X:int = Main.THE_BIG_SCREEN_X + 3;
		private const SCROLL_BAR_HORZ_Y:int = Main.THE_BIG_SCREEN_Y + Main.THE_BIG_SCREEN_HEIGHT + 4;
		// END CONSTANTS
		
		// BEGIN SCROLL CIRCLE AND SCROLL BAR INITIALIZATION
		public static var scrollCircle:MovieClip;
		public static var scrollBar:MovieClip;
		public static var scrollBarVert:MovieClip;
		public static var scrollBarHorz:MovieClip;
		public static var scrollVert:MovieClip;
		public static var scrollHorz:MovieClip;
		// END SCROLL CIRCLE AND SCROLL BAR INITIALIZATION
		
		// BEGIN SCROLL CIRCLE BOOLEANS
		public static var SCMDown:Boolean = false;
		public static var SCMUp:Boolean = true;
		private static var SCMOver:Boolean = false;
		private static var SCMOut:Boolean = true;
		
		public static var SVMDown:Boolean = false;
		public static var SVMUp:Boolean = true;
		private static var SVMOver:Boolean = false;
		private static var SVMOut:Boolean = true;
		
		public static var SHMDown:Boolean = false;
		public static var SHMUp:Boolean = true;
		private static var SHMOver:Boolean = false;
		private static var SHMOut:Boolean = true;
		// END SCROLL CIRCLE BOOLEANS
		
		// BEGIN SCROLL BAR BOOLEANS
		public static var SBMDown:Boolean = false;
		public static var SBMUp:Boolean = true;
		private static var SBMOver:Boolean = false;
		private static var SBMOut:Boolean = true;
		
		public static var SBVMDown:Boolean = false;
		public static var SBVMUp:Boolean = true;
		private static var SBVMOver:Boolean = false;
		private static var SBVMOut:Boolean = true;
		
		public static var SBHMDown:Boolean = false;
		public static var SBHMUp:Boolean = true;
		private static var SBHMOver:Boolean = false;
		private static var SBHMOut:Boolean = true;
		// END SCROLL BAR BOOLEANS
		
		public function GUI() 
		{
			this.x = 0;
			this.y = 0;
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function onAddedToStage(event:Event):void
		{
			scrollCircle = createScrollCircle();
			scrollBar = createScrollBar();
			scrollBarVert = createScrollBarVert();
			scrollBarHorz = createScrollBarHorz();
			scrollVert = createScrollBall();
			scrollHorz = createScrollBall();
			
			positionScrollBars();
			positionScrollCircles();
			
			addEventListeners();
			
			addChildren();
			
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function createScrollCircle():MovieClip
		{
			var tmpScrollCircle:MovieClip = new MovieClip();
			
			tmpScrollCircle.graphics.beginFill(0x333333, 1);
			tmpScrollCircle.graphics.drawCircle(0, 0, 5);
			tmpScrollCircle.graphics.endFill();
			
			return tmpScrollCircle;
		}
		
		public function createScrollBar():MovieClip
		{
			var tmpScrollBar:MovieClip = new MovieClip();
			
			tmpScrollBar.graphics.lineStyle(0.5, 0x111111, 1);
			tmpScrollBar.graphics.beginFill(0x111111, 1);
			tmpScrollBar.graphics.drawRect(0, 0, 700, 5);
			tmpScrollBar.graphics.endFill();
			
			return tmpScrollBar;
		}
		
		public function createScrollBarVert():MovieClip
		{
			var tmpScrollBar:MovieClip = new MovieClip();
			
			tmpScrollBar.graphics.lineStyle(0.5, 0x111111, 1);
			tmpScrollBar.graphics.beginFill(0x111111, 1);
			tmpScrollBar.graphics.drawRoundRect(0, 0, 7, Main.THE_BIG_SCREEN_HEIGHT - 6, 6, 6);
			tmpScrollBar.graphics.endFill();
			
			tmpScrollBar.alpha = 0.2;
			
			tmpScrollBar.mouseChildren = true;
			tmpScrollBar.mouseEnabled = true;
			
			return tmpScrollBar;
		}
		
		public function createScrollBarHorz():MovieClip
		{
			var tmpScrollBar:MovieClip = new MovieClip();
			
			tmpScrollBar.graphics.lineStyle(0.5, 0x111111, 1);
			tmpScrollBar.graphics.beginFill(0x111111, 1);
			tmpScrollBar.graphics.drawRoundRect(0, 0, Main.THE_BIG_SCREEN_WIDTH - 6, 6, 6, 6);
			tmpScrollBar.graphics.endFill();
			
			tmpScrollBar.alpha = 0.2;
			
			tmpScrollBar.mouseChildren = true;
			tmpScrollBar.mouseEnabled = true;
			
			return tmpScrollBar;
		}
		
		public function createScrollBall():MovieClip
		{
			var tmpScrollCircle:MovieClip = new MovieClip();
			tmpScrollCircle.graphics.beginFill(0xEEEEEE, 1);
			tmpScrollCircle.graphics.lineStyle(0.5, 0x888888);
			tmpScrollCircle.graphics.drawCircle(0, 0, 3);
			tmpScrollCircle.graphics.endFill();
			
			tmpScrollCircle.mouseChildren = true;
			tmpScrollCircle.mouseEnabled = true;
			
			return tmpScrollCircle;
		}
		
		public function positionScrollBars():void
		{
			scrollBar.x = SCROLL_BAR_X;
			scrollBar.y = SCROLL_BAR_Y;
			
			scrollBarVert.x = SCROLL_BAR_VERT_X;
			scrollBarVert.y = SCROLL_BAR_VERT_Y;
			
			scrollBarHorz.x = SCROLL_BAR_HORZ_X;
			scrollBarHorz.y = SCROLL_BAR_HORZ_Y;
		}
		
		public function positionScrollCircles():void
		{
			scrollCircle.x = scrollBar.x;
			scrollCircle.y = scrollBar.y + scrollBar.height / 2;
			
			scrollVert.x = scrollBarVert.x + scrollBarVert.width / 2;
			scrollVert.y = scrollBarVert.y;
			
			scrollHorz.x = scrollBarHorz.x;
			scrollHorz.y = scrollBarHorz.y + scrollBarHorz.height / 2;
		}
		
		public function addEventListeners():void
		{
			scrollCircle.addEventListener(MouseEvent.MOUSE_OVER, scrollCircleMouseOver);
			scrollCircle.addEventListener(MouseEvent.MOUSE_OUT, scrollCircleMouseOut);
			scrollCircle.addEventListener(MouseEvent.MOUSE_DOWN, scrollCircleMouseDown);
			scrollCircle.addEventListener(MouseEvent.MOUSE_UP, scrollCircleMouseUp);
			
			scrollBar.addEventListener(MouseEvent.MOUSE_OVER, scrollBarMouseOver);
			scrollBar.addEventListener(MouseEvent.MOUSE_OUT, scrollBarMouseOut);
			scrollBar.addEventListener(MouseEvent.MOUSE_DOWN, scrollBarMouseDown);
			scrollBar.addEventListener(MouseEvent.MOUSE_UP, scrollBarMouseUp);
			
			scrollBarVert.addEventListener(MouseEvent.MOUSE_OVER, scrollBarVertMouseOver);
			scrollBarVert.addEventListener(MouseEvent.MOUSE_OUT, scrollBarVertMouseOut);
			scrollBarVert.addEventListener(MouseEvent.MOUSE_DOWN, scrollBarVertMouseDown);
			scrollBarVert.addEventListener(MouseEvent.MOUSE_UP, scrollBarVertMouseUp);
			
			scrollBarHorz.addEventListener(MouseEvent.MOUSE_OVER, scrollBarHorzMouseOver);
			scrollBarHorz.addEventListener(MouseEvent.MOUSE_OUT, scrollBarHorzMouseOut);
			scrollBarHorz.addEventListener(MouseEvent.MOUSE_DOWN, scrollBarHorzMouseDown);
			scrollBarHorz.addEventListener(MouseEvent.MOUSE_UP, scrollBarHorzMouseUp);
			
			scrollVert.addEventListener(MouseEvent.MOUSE_OVER, scrollVertMouseOver);
			scrollVert.addEventListener(MouseEvent.MOUSE_OUT, scrollVertMouseOut);
			scrollVert.addEventListener(MouseEvent.MOUSE_DOWN, scrollVertMouseDown);
			scrollVert.addEventListener(MouseEvent.MOUSE_UP, scrollVertMouseUp);
			
			scrollHorz.addEventListener(MouseEvent.MOUSE_OVER, scrollHorzMouseOver);
			scrollHorz.addEventListener(MouseEvent.MOUSE_OUT, scrollHorzMouseOut);
			scrollHorz.addEventListener(MouseEvent.MOUSE_DOWN, scrollHorzMouseDown);
			scrollHorz.addEventListener(MouseEvent.MOUSE_UP, scrollHorzMouseUp);
			
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		public function addChildren():void
		{
			this.addChild(scrollBar);
			this.addChild(scrollCircle);
			this.addChild(scrollBarVert);
			this.addChild(scrollBarHorz);
			this.addChild(scrollVert);
			this.addChild(scrollHorz);
		}
		
		// BEGIN SCROLL CIRCLE EVENT HANDLERS
		private function scrollCircleMouseOver(event:MouseEvent):void
		{
			SCMOver = true;
			SCMOut = false;
		}
		
		private function scrollCircleMouseOut(event:MouseEvent):void
		{
			SCMOut = true;
			SCMOver = false;
		}
		
		private function scrollCircleMouseDown(event:MouseEvent):void
		{
			SCMDown = true;
			SCMUp = false;
		}
		
		private function scrollCircleMouseUp(event:MouseEvent):void
		{
			SCMUp = true;
			SCMDown = false;
		}
		// END SCROLL CIRCLE EVENT HANDLERS
		
		// BEGIN SCROLL BAR EVENT HANDLERS
		private function scrollBarMouseOver(event:MouseEvent):void
		{
			SBMOver = true;
			SBMOut = false;
		}
		
		private function scrollBarMouseOut(event:MouseEvent):void
		{
			SBMOut = true;
			SBMOver = false;
		}
		
		private function scrollBarMouseDown(event:MouseEvent):void
		{
			SBMDown = true;
			SBMUp = false;
		}
		
		private function scrollBarMouseUp(event:MouseEvent):void
		{
			SBMUp = true;
			SBMDown = false;
			
			GUI.scrollCircle.x = mouseX;
		}
		// END SCROLL BAR EVENT HANDLERS
		
		// BEGIN SCROLL BAR VERTICAL EVENT HANDLERS
		private function scrollBarVertMouseOver(event:MouseEvent):void
		{
			SBVMOver = true;
			SBVMOut = false;
		}
		
		private function scrollBarVertMouseOut(event:MouseEvent):void
		{
			SBVMOut = true;
			SBVMOver = false;
		}
		
		private function scrollBarVertMouseDown(event:MouseEvent):void
		{
			SBVMDown = true;
			SBVMUp = false;
		}
		
		private function scrollBarVertMouseUp(event:MouseEvent):void
		{
			SBVMUp = true;
			SBVMDown = false;
			
			GUI.scrollVert.y = mouseY;
		}
		// END SCROLL BAR VERTICAL EVENT HANDLERS
		
		// BEGIN SCROLL BAR HORIZONTAL EVENT HANDLERS
		private function scrollBarHorzMouseOver(event:MouseEvent):void
		{
			SBHMOver = true;
			SBHMOut = false;
		}
		
		private function scrollBarHorzMouseOut(event:MouseEvent):void
		{
			SBHMOut = true;
			SBHMOver = false;
		}
		
		private function scrollBarHorzMouseDown(event:MouseEvent):void
		{
			SBHMDown = true;
			SBHMUp = false;
		}
		
		private function scrollBarHorzMouseUp(event:MouseEvent):void
		{
			SBHMUp = true;
			SBHMDown = false;
			
			GUI.scrollHorz.x = mouseX;
		}
		// END SCROLL BAR HORIZONTAL EVENT HANDLERS
		
		// BEGIN SCROLL VERT EVENT HANDLERS
		private function scrollVertMouseOver(event:MouseEvent):void
		{
			SVMOver = true;
			SVMOut = false;
		}
		
		private function scrollVertMouseOut(event:MouseEvent):void
		{
			SVMOut = true;
			SVMOver = false;
		}
		
		private function scrollVertMouseDown(event:MouseEvent):void
		{
			SVMDown = true;
			SVMUp = false;
		}
		
		private function scrollVertMouseUp(event:MouseEvent):void
		{
			SVMUp = true;
			SVMDown = false;
			
			GUI.scrollVert.y = mouseY;
		}
		// END SCROLL VERTICAL EVENT HANDLERS
		
		// BEGIN SCROLL HORIZONTAL EVENT HANDLERS
		private function scrollHorzMouseOver(event:MouseEvent):void
		{
			SHMOver = true;
			SHMOut = false;
		}
		
		private function scrollHorzMouseOut(event:MouseEvent):void
		{
			SHMOut = true;
			SHMOver = false;
		}
		
		private function scrollHorzMouseDown(event:MouseEvent):void
		{
			SHMDown = true;
			SHMUp = false;
		}
		
		private function scrollHorzMouseUp(event:MouseEvent):void
		{
			SHMUp = true;
			SHMDown = false;
			
			GUI.scrollHorz.x = mouseX;
		}
		// END SCROLL HORIZONTAL EVENT HANDLERS
		
		private function onEnterFrame(event:Event):void
		{
			if (SBMOver && scrollBar.alpha < 0.5) {
				scrollBar.alpha += 0.05;
			} else if (SBMOut && scrollBar.alpha > 0.2) {
				scrollBar.alpha -= 0.05;
			}
			
			var showScrolls:Boolean = false;
			
			if (mouseX >= Main.THE_BIG_SCREEN_X && mouseX <= Main.THE_BIG_SCREEN_X + Main.THE_BIG_SCREEN_WIDTH + 15) {
				if (mouseY >= Main.THE_BIG_SCREEN_Y && mouseY <= Main.THE_BIG_SCREEN_Y + Main.THE_BIG_SCREEN_HEIGHT + 12) {
					showScrolls = true;
				}
			}
			
			if (showScrolls && (scrollBarVert.alpha <= 0.2 || scrollBarHorz.alpha <= 0.2)) {
				scrollBarVert.alpha += 0.05;
				scrollBarHorz.alpha += 0.05;
			} else if(!showScrolls && (scrollBarVert.alpha > 0.0 || scrollBarHorz.alpha > 0.0)) {
				scrollBarVert.alpha -= 0.05;
				scrollBarHorz.alpha -= 0.05;
			}
			
			if (showScrolls && (scrollVert.alpha <= 0.8 || scrollHorz.alpha <= 0.8)) {
				scrollHorz.alpha += 0.2;
				scrollVert.alpha += 0.2;
			} else if(!showScrolls && (scrollVert.alpha > 0.2 || scrollHorz.alpha > 0.2)) {
				scrollHorz.alpha -= 0.2;
				scrollVert.alpha -= 0.2;
			}
		}
		
	}

}