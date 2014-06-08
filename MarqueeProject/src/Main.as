package  {
	import flash.display.MovieClip;
	import flash.utils.*;
	import flash.net.*;
	import flash.events.*;
	import flash.display.Shape;
	
	public class Main extends MovieClip {
		// BEGIN QUICK EDIT PROPERTIES --------------------------------------------------
		// Constants dealing with the alternating comment colors
		private const ALTERNATING_COLOR_ONE:uint = 0xFFFFFF; // White
		private const ALTERNATING_COLOR_TWO:uint = 0x208EA8; // Blue
		// Constant dealing with the amount of time till updating the comments
		private const UPDATE_TIME:int = 20000; // 1000 equals 1 second
		// Constants dealing with the marquee's background and size
		private const MARQUEE_BACKGROUND_COLOR:uint = 0x92d6e3;
		private const MARQUEE_BACKGROUND_BEGIN_X:int = 0;
		private const MARQUEE_BACKGROUND_BEGIN_Y:int = 1050;
		private const MARQUEE_BACKGROUND_WIDTH:int = 1980;
		private const MARQUEE_BACKGROUND_HEIGHT:int = 30;
		
		// A posotive COMMENT_SCROLL_RATE makes comments scroll from left to right 
		// while a negative COMMENT_SCROLL_RATE makes comments scroll from right to left
		private const COMMENT_SCROLL_RATE:int = 3; // Default value is 3
		// END QUICK EDIT PROPERTIES ----------------------------------------------------
		
		private var updateTimer:Timer;
		private var head:MarqueeComment = null;
		
		private var marquee:MovieClip = new MovieClip(); // MovieClip used to mask the marquee
		private var marqueeBackground:Shape = new Shape(); // Blue background for the marquee
		private var marqueeMask:Shape = new Shape(); // Mask applied to marquee
		
		// xml load
		private var myXML:XML; // new XML();
		private var XML_URL:String; // "http://do.latorante.name/ticker/actionscriptresult";
		private var myXMLURL:URLRequest; // new URLRequest(XML_URL);
		private var myLoader:URLLoader; // new URLLoader(myXMLURL);
		
		private var colorCount:int; // integer to keep track of color
		
		private var listConstructed:Boolean = false;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			myXML = new XML(); // initiate myXML at run time
			XML_URL = "http://do.latorante.name/ticker/actionscriptresult"; // initiate XML_URL
			
			this.drawTextBackground();
			
			stage.addChild(marqueeBackground);
			marquee.mask = marqueeMask;
			
			stage.addChild(marquee);
			stage.addChild(marqueeMask);
			
			this.head = new MarqueeComment(); // head is the beginning of the list
			
			this.updateTheList(); // update the list

			listConstructed = false; // don't start iterating over the list until it is populated
			colorCount = 1; // variable used in alternating the color of comments
			
			updateTimer = new Timer(UPDATE_TIME, 1);
			
			updateTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			updateTimer.start();
		}
		
		private function drawTextBackground():void {
			marqueeBackground.graphics.beginFill(MARQUEE_BACKGROUND_COLOR, 1);
			marqueeBackground.graphics.drawRect( 0, 0, MARQUEE_BACKGROUND_WIDTH, MARQUEE_BACKGROUND_HEIGHT);
			marqueeBackground.graphics.endFill();
			marqueeBackground.x = MARQUEE_BACKGROUND_BEGIN_X;
			marqueeBackground.y = MARQUEE_BACKGROUND_BEGIN_Y;
			
			marqueeMask.graphics.beginFill(0xFFFFFF, 1);
			marqueeMask.graphics.drawRect( 0, 0, MARQUEE_BACKGROUND_WIDTH, MARQUEE_BACKGROUND_HEIGHT);
			marqueeMask.graphics.endFill();
			marqueeMask.x = MARQUEE_BACKGROUND_BEGIN_X;
			marqueeMask.y = MARQUEE_BACKGROUND_BEGIN_Y;
		}
		
		private function xmlLoaded(event:Event):void
		{
			myXML = XML(myLoader.data);
			
			for each (var Comment:XML in myXML.Comment){
				var newColor:uint = ALTERNATING_COLOR_ONE;
				if(colorCount % 2 == 0) {
					newColor = ALTERNATING_COLOR_TWO;
				}				
				
				var removeLineBreaks:String = Comment.text.split("\r\n").join("");
				removeLineBreaks = removeLineBreaks.split("\n").join("");
				removeLineBreaks = removeLineBreaks.split("\r").join("");
				
				var newMC:MarqueeComment = new MarqueeComment(removeLineBreaks, newColor);
				
				marquee.addChild(newMC);
				
				this.addToList(newMC);
				colorCount += 1;
			}
			if(colorCount >= 101) {
				colorCount = 1;
			}
			
			listConstructed = true;
			myLoader.removeEventListener("complete", xmlLoaded);
		}
		
		private function updateTheList():void
		{
			myXMLURL = new URLRequest(XML_URL);
			myLoader = new URLLoader(myXMLURL);
			myLoader.addEventListener("complete", xmlLoaded);
		}
		
		private function addToList(newComment:MarqueeComment):void
		{
			if(head.next != null) {
				newComment.next = head.next;
			} else {
				newComment.next = null;
			}
			
			if(head.next == null) {
				newComment.x = MARQUEE_BACKGROUND_WIDTH;
			} else {
				newComment.x = head.next.x + head.next.width + 30;
			}
			
			head.next = newComment;
		}
		
		private function onEnterFrame(e:Event):void {
			if(listConstructed) {
				var currentComment:MarqueeComment = head;
				var deleteComment:Boolean = false;
				
				while(currentComment.next != null) {
					currentComment = currentComment.next;
					currentComment.x -= COMMENT_SCROLL_RATE;
					if(currentComment.x + currentComment.width < 0) {
						deleteComment = true;
					}
				}
				
				if(deleteComment) {
					currentComment = head.next;
					var commentToNull:MarqueeComment = head;
					while(currentComment != null) {
						if(currentComment.next == null) {
							marquee.removeChild(currentComment);
							commentToNull.next = null;
						}
						currentComment = currentComment.next;
						commentToNull = commentToNull.next;
					}
				}
				
			}
		}
		
		private function onTimerComplete(e:TimerEvent):void {
			// listConstructed = false;
			this.updateTheList();
			
			updateTimer.reset();
			updateTimer.start();
		}

	}
	
}
