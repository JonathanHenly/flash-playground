package 
{
	import flash.display.*;
	import flash.net.*;
	import flash.events.*;
	import flash.utils.*;

	public class Main extends MovieClip
	{
		private var URL_ADDRESS:String = "127.0.0.1/xml/randomImageList.xml";

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
		
		private var bigScreen:MovieClip;
		private var previousImageOnScreen:Bitmap;
		private var nextImageOnScreen:Bitmap;
		private var imageCounter:int = 0;

		private var hasHappened:Boolean = false;
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
			
			bigScreen = new MovieClip();
			
			bigScreen.graphics.beginFill(0x333333,1);
			bigScreen.graphics.drawRect(0,0,680,388);
			bigScreen.graphics.endFill();
			bigScreen.x = 10;
			bigScreen.y = 5;
			stage.addChild(bigScreen);

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
			// trace(myLoader.data);
			for each (var element:XML in myXML.image)
			{
				// if(!hasHappened) {
				var imageLoader:Loader = new Loader();


				var newIO:ImageObject = new ImageObject(element.description, imageLoader, imageCount);

				imageLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, newIO.onLoaderProgress);
				imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, newIO.onLoaderComplete);

				imageLoader.load(new URLRequest(element.link));

				this.addAtHead(newIO);


				stage.addChild(newIO);
				
				imageCount++;
			}

			this.listFinished = true;
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

			node.y = 398;
			node.next = head.next;
			head.next.prev = node;

			head.next = node;
			node.prev = head;
			
			node.addEventListener(MouseEvent.CLICK, onNodeClick);
		}
		
		private function onNodeClick(e:MouseEvent):void
		{
			if(imageCounter % 2 == 0) {
				previousImageOnScreen = e.target.getBigBitmap();
				bigScreen.addChild(previousImageOnScreen);
			} else {
				nextImageOnScreen = e.target.getBigBitmap();
				bigScreen.addChild(nextImageOnScreen);
			}
			
			imageCounter++;
			
			if(bigScreen.numChildren > 1) {
				if(imageCounter % 2 == 1) {
					bigScreen.removeChild(nextImageOnScreen);
				} else {
					bigScreen.removeChild(previousImageOnScreen);
				}
			}
		}

		private function onEnterFrame(e:Event):void
		{
			var moveSpeed:int = 0;

			if (listFinished)
			{
				currentNode = head.next;

				this.moveListRight = (mouseX > 400) ? true:false;
				this.moveListLeft = (mouseX < 300) ? true:false;
				
				if (head.next.x >= 350 && tail.prev.x <= 350) {
					if (mouseY > 400)
					{
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
					else
					{
						moveSpeed = 0;
					}
				}

				if (mouseX <= 400 && mouseX >= 300)
				{
					moveSpeed = 0;
				}

				while (currentNode != tail)
				{
					currentNode.x +=  moveSpeed;

					if (currentNode.mouseIsOver)
					{
						currentNode.visible = true;
						currentNode.parent.setChildIndex(currentNode, parent.numChildren-1);
					}
					else
					{
						currentNode.visible = true;
						// currentNode.parent.setChildIndex(currentNode, -1);
					}

					currentNode = currentNode.next;
				}
			}
		}

	}

}