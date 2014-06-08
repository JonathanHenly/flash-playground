package 
{
	import flash.display.*;
	import flash.net.*;
	import flash.events.*;
	import flash.events.ErrorEvent;
	import flash.events.IOErrorEvent;
	import flash.events.UncaughtErrorEvent;
	import flash.events.UncaughtErrorEvents;
	import flash.utils.*;

	public class Main extends MovieClip
	{
		[Embed(source="../img/JustPeachy.png")]
		private var JustPeachyClass:Class;
		private var justPeachy:Bitmap = new JustPeachyClass();
		
		public const NUMBER_OF_IMAGES:int = 1415;
		public static const THE_BIG_SCREEN_WIDTH:int = 680;
		public static const THE_BIG_SCREEN_HEIGHT:int = 460;
		public static const THE_BIG_SCREEN_X:int = (800 - THE_BIG_SCREEN_WIDTH) / 2;
		public static const THE_BIG_SCREEN_Y:int = 5;
		
		private var URL_ADDRESS:String = "http://www.buzzreport.net/wp-content/uploads/2012/06/";

		private var gui:GUI;
		private var bottomContainer:BottomContainer;
		
		private var head:ImageObject;
		private var tail:ImageObject;

		// xml load
		private var myXML:XML;// new XML();
		private var XML_URL:String;// "./src/PictureProject.xml";
		private var myXML_URL:URLRequest;// new URLRequest(XML_URL);
		private var myLoader:URLLoader;// new URLLoader(myXMLURL);

		private var currentNode:ImageObject;

		private var listFinished:Boolean = false;
		private var moveListRight:Boolean = false;
		private var moveListLeft:Boolean = false;

		private var hasHappened:Boolean = false;
		
		private var theBigScreen:MovieClip;
		private var theBigScreenMask:MovieClip;
		public static var bigScreenMouseOver:Boolean = false;
		
		private var mainImageOnScreen:Bitmap;
		private var previousImageOnScreen:Bitmap;
		private var nextImageOnScreen:Bitmap;
		private var imageOnScreen:Boolean = false;
		private var theImageCounter:int = 0;
		
		public function Main():void
		{
			if (stage)
			{
				init();
			}
			else
			{
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}

		private function init(e:Event = null):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			
			justPeachy.width = 637;
			justPeachy.height = 227;
			
			gui = new GUI();
			bottomContainer = new BottomContainer();
			bottomContainer.mouseChildren = true;
			bottomContainer.mouseEnabled = false;
			stage.addChild(bottomContainer);
			stage.addChild(gui);
			
			
			this.head = new ImageObject();
			this.tail = new ImageObject();

			this.head.next = this.tail;
			this.tail.prev = this.head;
			this.head.prev = null;
			this.tail.next = null;

			myXML = new XML();
			XML_URL = "http://127.0.0.1/xml/randomImageList.xml";
			myXML_URL = new URLRequest(XML_URL);
			myLoader = new URLLoader(myXML_URL);

			myLoader.addEventListener(ProgressEvent.PROGRESS, onProgress);
			myLoader.addEventListener(Event.COMPLETE, onMyLoaderComplete);
			myLoader.load(myXML_URL);
			
			this.setUpScreens();
			
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		private function onProgress(e:ProgressEvent):void
		{
			// trace("Bytes Loaded: " + e.bytesLoaded + " : Out Of : " + e.bytesTotal);
		}

		private function onMyLoaderComplete(e:Event):void
		{
			myLoader.removeEventListener(ProgressEvent.PROGRESS, onProgress);
			myLoader.removeEventListener(Event.COMPLETE, onMyLoaderComplete);

			this.evaluateXMLImages();
		}

		private function evaluateXMLImages():void
		{
			var imageCount:int = 1;
			myXML = XML(myLoader.data);
			
			for each (var element:XML in myXML.image)
			{
				var imageLoader:Loader = new Loader();


				var newIO:ImageObject = new ImageObject(element.description, imageLoader, imageCount);

				imageLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, newIO.onLoaderProgress);
				imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, newIO.onLoaderComplete);

				imageLoader.load(new URLRequest(element.link));
				imageLoader.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, onLoaderError);
				imageLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onLoaderIOError);
				
				this.addAtHead(newIO);


				bottomContainer.addChild(newIO);
				
				imageCount++;
			}

			this.listFinished = true;
		}
		
		public function onLoaderError(event:UncaughtErrorEvent):void
		{
			if (event.error is Error)
            {
                var error:Error = event.error as Error;
                trace("error was an Error: " + error.message);
            }
            else if (event.error is ErrorEvent)
            {
                var errorEvent:ErrorEvent = event.error as ErrorEvent;
                trace("error was an ErrorEvent: " + errorEvent.toString);
            }
            else
            {
                trace("error was something else: " + event.error);
            }
		}
		
		public function onLoaderIOError(event:IOErrorEvent):void
		{
			trace(event.toString());
		}

		private function addAtHead(node:ImageObject):void
		{
			if (head.next == tail)
			{
				node.x = 0;
			}
			else
			{
				node.x = head.next.x + head.next.width + 20;
			}

			node.y = 520;
			node.next = head.next;
			head.next.prev = node;

			head.next = node;
			node.prev = head;
			
			node.addEventListener(MouseEvent.CLICK, onNodeClick);
		}
		
		private function setUpScreens():void
		{
			theBigScreen = new MovieClip();
			theBigScreenMask = new MovieClip();
			
			theBigScreen.graphics.beginFill(0xFFFFFF,1);
			theBigScreen.graphics.lineStyle(0.4, 0x444444, 0.2);
			theBigScreen.graphics.drawRect(0,0,THE_BIG_SCREEN_WIDTH,THE_BIG_SCREEN_HEIGHT);
			theBigScreen.graphics.endFill();
			theBigScreen.x = THE_BIG_SCREEN_X;
			theBigScreen.y = THE_BIG_SCREEN_Y;
			
			theBigScreenMask.graphics.beginFill(0x000000,1);
			theBigScreenMask.graphics.lineStyle(0.2, 0x444444, 0.2);
			theBigScreenMask.graphics.drawRect(0,0,THE_BIG_SCREEN_WIDTH + 1, THE_BIG_SCREEN_HEIGHT + 1);
			theBigScreenMask.graphics.endFill();
			theBigScreenMask.x = (800 - THE_BIG_SCREEN_WIDTH) / 2;
			theBigScreenMask.y = 5;
			
			stage.addChild(theBigScreenMask);
			stage.addChild(theBigScreen);
			theBigScreen.mask = theBigScreenMask;
			
			justPeachy.x = (theBigScreen.width - justPeachy.width) / 2;
			justPeachy.y = (theBigScreen.height - justPeachy.height) / 2;
			theBigScreen.addChild(justPeachy);
			
			theBigScreen.addEventListener(MouseEvent.MOUSE_OVER, onBigScreenMouseOver);
			theBigScreen.addEventListener(MouseEvent.MOUSE_OUT, onBigScreenMouseOut);
		}
		
		private function onBigScreenMouseOver(event:MouseEvent):void
		{
			bigScreenMouseOver = true;
		}
		
		private function onBigScreenMouseOut(event:MouseEvent):void
		{
			bigScreenMouseOver = false;
		}
		
		private function onNodeClick(e:MouseEvent):void
		{
			if (previousImageOnScreen != e.target.getBigBitmap() && nextImageOnScreen != e.target.getBigBitmap()) {
				
				imageOnScreen = true;
				
				if (theImageCounter % 2 == 0) {
					previousImageOnScreen = e.target.getBigBitmap();
					
					/*
					var scaleOne:Number =  THE_BIG_SCREEN_WIDTH / previousImageOnScreen.width;
					if(previousImageOnScreen.height * scaleOne >  THE_BIG_SCREEN_HEIGHT){
						scaleOne = THE_BIG_SCREEN_HEIGHT / previousImageOnScreen.height;
					}   
					previousImageOnScreen.scaleX = previousImageOnScreen.scaleY = scaleOne;
					*/
					
					theBigScreen.addChild(previousImageOnScreen);
					mainImageOnScreen = previousImageOnScreen;
				} else {
					nextImageOnScreen = e.target.getBigBitmap();
					
					/*
					var scaleTwo:Number =  THE_BIG_SCREEN_WIDTH / nextImageOnScreen.width;
					if(nextImageOnScreen.height * scaleTwo >  THE_BIG_SCREEN_HEIGHT){
						scaleTwo = THE_BIG_SCREEN_HEIGHT / nextImageOnScreen.height;
					}   
					nextImageOnScreen.scaleX = nextImageOnScreen.scaleY = scaleTwo;
					*/
					
					theBigScreen.addChild(nextImageOnScreen);
					mainImageOnScreen = nextImageOnScreen;
				}
			
				theImageCounter++;
				
				if(theBigScreen.numChildren > 1) {
					if (theImageCounter % 2 == 1) {
						theBigScreen.removeChild(nextImageOnScreen);
					} else {
						theBigScreen.removeChild(previousImageOnScreen);
					}
				}
			}
		}

		private function onEnterFrame(e:Event):void
		{	
			var moveSpeed:int = 0;

			if (listFinished)
			{
				if (stage.getChildIndex(gui) != stage.numChildren - 2) {
					stage.setChildIndex(gui, stage.numChildren - 2);
				}
				
				if (stage.getChildIndex(bottomContainer) != stage.numChildren - 1) {
					stage.setChildIndex(bottomContainer, stage.numChildren - 1);
				}
				
				currentNode = head.next;

				this.moveListRight = (mouseX > 400) ? true:false;
				this.moveListLeft = (mouseX < 300) ? true:false;
				
					if (mouseY > 520)
					{
						if(bottomContainer.x >  100 - bottomContainer.width) {
							if (mouseX > 680)
							{
								moveSpeed = -50;
							}
							else if (mouseX > 650)
							{
								moveSpeed = -30;
							}
							else if (mouseX > 600)
							{
								moveSpeed = -25;
							}
							else if (mouseX > 550)
							{
								moveSpeed = -20;
							}
							else if (mouseX > 500)
							{
								moveSpeed = -15;
							}
							else if (mouseX > 450)
							{
								moveSpeed = -10;
							}
							else if (mouseX > 400)
							{
								moveSpeed = -5;
							}
						}
						
						if (bottomContainer.x < 1) {
							if (mouseX < 20)
							{
								moveSpeed = 50;
							}
							else if (mouseX < 50)
							{
								moveSpeed = 30;
							}
							else if (mouseX < 100)
							{
								moveSpeed = 25;
							}
							else if (mouseX < 150)
							{
								moveSpeed = 20;
							}
							else if (mouseX < 200)
							{
								moveSpeed = 15;
							}
							else if (mouseX < 250)
							{
								moveSpeed = 10;
							}
							else if (mouseX < 300)
							{
								moveSpeed = 5;
							}
						}
					}
					else
					{
						moveSpeed = 0;
					}

				if (mouseX <= 400 && mouseX >= 300)
				{
					moveSpeed = 0;
				}
				
				bottomContainer.x += moveSpeed;
				
				while (currentNode != tail)
				{
					if (currentNode.mouseIsOver)
					{
						currentNode.visible = true;
						if (currentNode.next != head) {
							currentNode.next.applyShadowRight();
							currentNode.next.parent.setChildIndex(currentNode.next, parent.numChildren - 1);
						}
						if (currentNode.prev != tail) {
							currentNode.prev.applyShadowLeft();
							currentNode.prev.parent.setChildIndex(currentNode.prev, parent.numChildren - 1);
						}
						currentNode.parent.setChildIndex(currentNode, parent.numChildren-1);
					}
					else
					{
						currentNode.visible = true;
						// currentNode.parent.setChildIndex(currentNode, -1);
					}

					currentNode = currentNode.next;
				}
				
				this.monitorScrollCircleAndBar(moveSpeed);
				
				if(imageOnScreen) {
					this.monitorImageScrollingVertical();
					this.monitorImageScrollingHorizontal();
				}
				
			}
		}
		
		private function monitorScrollCircleAndBar(moveSpeed:int = 0):void
		{
			var BC_SB_Ratio:Number = bottomContainer.width / GUI.scrollBar.width;
			
			if (GUI.SBMDown) {
				var mX_SB_Diff:Number = mouseX - GUI.scrollBar.x;
				
				bottomContainer.x = -(mX_SB_Diff * BC_SB_Ratio);
			}
			
			GUI.scrollCircle.x -= moveSpeed/BC_SB_Ratio;
		}
		
		private function monitorImageScrollingVertical():void
		{
			var Image_SBV_Ratio:Number = (mainImageOnScreen.height / 2) / GUI.scrollBarVert.height;
			
			if (GUI.SBVMDown) {
				var mY_SBV_Diff:Number = mouseY - GUI.scrollBarVert.y;
				
				mainImageOnScreen.y = -(mY_SBV_Diff * Image_SBV_Ratio);
			}
		}
		
		private function monitorImageScrollingHorizontal():void
		{
			var Image_SBH_Ratio:Number = (mainImageOnScreen.width / 2) / GUI.scrollBarHorz.width;
			
			if (GUI.SBHMDown) {
				var mX_SBH_Diff:Number = mouseX - GUI.scrollBarHorz.x;
				
				mainImageOnScreen.x = -(mX_SBH_Diff * Image_SBH_Ratio);
			}
		}

	}

}