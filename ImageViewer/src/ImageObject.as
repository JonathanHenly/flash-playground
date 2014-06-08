package 
{
	import flash.display.MovieClip;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.ProgressEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.events.Event;
	import flash.display.Shape;
	import flash.display.Loader;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.display.LoaderInfo;
	import flash.filters.*;

	public class ImageObject extends MovieClip
	{
		public var next:ImageObject;
		public var prev:ImageObject;
		public var mouseIsOver:Boolean;

		private const TAG:String = "Percent Loaded: ";

		private var tf:TextField;
		private var num:TextField;
		private var bitmap:Bitmap;
		private var thumbnail:Bitmap;
		private var background:Shape;
		private var description:String;
		private var loaderReference:Loader;
		public function ImageObject(dscptn:String = "", LR:Loader = null, imageNum:int = 0)
		{
			if (LR != null)
			{
				mouseIsOver = false;
				loaderReference = LR;
				this.description = dscptn;
				this.background = new Shape();

				background.graphics.lineStyle(0.1, 0x000000);
				background.graphics.beginFill(0x222222, 1);
				background.graphics.drawRect(0,0,100,100);
				background.graphics.endFill();

				background.x = 0;
				background.y = 0;

				this.addChild(background);

				tf = new TextField();
				tf.text = this.TAG + "0%";
				tf.textColor = 0xFFFFFF;
				tf.multiline = false;
				tf.mouseEnabled = false;
				tf.autoSize = TextFieldAutoSize.CENTER;
				tf.width = tf.textWidth;
				tf.height = tf.textHeight;

				tf.x = background.x + (background.width - tf.width) / 2;
				tf.y = background.y + (background.height - tf.height) / 2;

				this.addChild(tf);
				
				num = new TextField();
				num.text = imageNum.toString();
				num.textColor = 0xFF00FF;
				num.multiline = false;
				num.mouseEnabled = false;
				num.autoSize = TextFieldAutoSize.CENTER;
				num.width = num.textWidth;
				num.height = num.textHeight;
				
				num.x = background.x + (background.width - num.width) / 2;
				num.y = background.y - num.height - 4;
				
				// this.addChild(num);

				this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
				this.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			}
		}
		
		public function getBigBitmap():Bitmap
		{
			return this.bitmap;
		}

		public function onLoaderProgress(e:ProgressEvent):void
		{
			var percentage:int = (e.bytesLoaded / e.bytesTotal) * 100;

			this.tf.text = TAG + percentage.toString() + "%";
		}

		public function onLoaderComplete(e:Event):void
		{
			this.bitmap = new Bitmap((loaderReference.content as Bitmap).bitmapData);
			this.thumbnail = new Bitmap(this.bitmap.bitmapData);
			while(this.thumbnail.width > 100) {
				this.thumbnail.width *= 0.99;
			}
			
			while(this.thumbnail.height > 100) {
				this.thumbnail.height *= 0.99;
			}
			this.thumbnail.x = (this.background.width - this.thumbnail.width)/2;
			this.thumbnail.y = (this.background.height - this.thumbnail.height)/2;
			this.addChild(thumbnail);
			
			this.tf.text = this.description;
			this.tf.textColor = 0xFFFFFF;
			this.tf.y = background.y + background.height + tf.height / 2;

			this.tf.alpha = 50;
			
			var LtoG:Point = this.localToGlobal(new Point(this.tf.x, this.tf.y));
			this.removeChild(this.tf);
			stage.addChild(this.tf);
			this.tf.x = LtoG.x;
			this.tf.y = LtoG.y;

			this.loaderReference.removeEventListener(ProgressEvent.PROGRESS, this.onLoaderProgress);
			this.loaderReference.removeEventListener(Event.COMPLETE, this.onLoaderComplete);
		}

		private function onMouseOver(e:MouseEvent):void
		{
			mouseIsOver = true;
			if (this.next != null)
			{
				this.next.x -=  20;
			}

			if (this.prev != null)
			{
				this.prev.x +=  20;
			}

			this.tf.alpha +=  0.1;
			
			this.applyMainShadow();
		}

		private function onMouseOut(e:MouseEvent):void
		{
			mouseIsOver = false;
			if (this.prev != null)
			{
				this.prev.x -=  20;
			}

			if (this.next != null)
			{
				this.next.x +=  20;
			}

			this.tf.alpha -=  0.1;
			
			this.prev.dropShadow();
			this.next.dropShadow();
			this.dropShadow();
		}
		
		public function applyMainShadow():void
		{
			var dropShadow1:DropShadowFilter = new DropShadowFilter();
			var dropShadow2:DropShadowFilter = new DropShadowFilter();
			
			dropShadow1.angle = 180;
			dropShadow1.blurX = 3;
			dropShadow1.blurY = 3;
			dropShadow1.strength = 0.8;
			dropShadow1.quality = 5;
			dropShadow1.distance = 3;
			
			dropShadow2.angle = 0;
			dropShadow2.blurX = 3;
			dropShadow2.blurY = 3;
			dropShadow2.strength = 0.8;
			dropShadow2.quality = 5;
			dropShadow2.distance = 3;
			
			this.filters = [dropShadow1, dropShadow2];
		}
		
		public function applyShadowLeft():void
		{
			var dropShadow:DropShadowFilter = new DropShadowFilter();
			dropShadow.angle = 0;
			dropShadow.blurX = 3;
			dropShadow.blurY = 3;
			dropShadow.strength = 0.8;
			dropShadow.quality = 5;
			dropShadow.distance = 5;
			
			this.filters = [dropShadow];
		}
		
		public function applyShadowRight():void
		{
			var dropShadow:DropShadowFilter = new DropShadowFilter();
			dropShadow.angle = 180;
			dropShadow.blurX = 3;
			dropShadow.blurY = 3;
			dropShadow.strength = 0.8;
			dropShadow.quality = 5;
			dropShadow.distance = 5;
			
			this.filters = [dropShadow];
		}
		
		public function dropShadow():void
		{
			this.filters = [];
		}

	}

}