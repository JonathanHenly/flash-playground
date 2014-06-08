package  {
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.filters.*;
	import flash.text.*;
	
	public class Button extends MovieClip {
		// private var bText:TextField;
		
		public function Button() {
 
		}
		
		public function setPosition(xpos:int, ypos:int) {
			this.x = xpos;
			this.y = ypos;
		}
		
		public function setScale(xScale:Number, yScale:Number) {
			this.scaleX *= xScale;
			this.scaleY *= yScale;
		}
		
		public function setWidthHeight(newWidth:Number, newHeight:Number) {
			this.width = newWidth;
			this.height = newHeight;
		}
		
		public function addDropShadow():Array {
			var dropShadow:DropShadowFilter = new DropShadowFilter();
			dropShadow.distance = 2;
			if(this.scaleX > 0) {
				dropShadow.angle = 45;
			} else if(this.scaleX < 0) {
				dropShadow.angle = 105;
			}
			dropShadow.color = 0;
			dropShadow.alpha = 1;
			dropShadow.blurX = 1.2; // + this.scaleX;
			dropShadow.blurY = 1.2; // + this.scaleY;
			dropShadow.strength = 2;
			dropShadow.quality = 15;
			dropShadow.inner = true;
			dropShadow.knockout = false;
			dropShadow.hideObject = false;
			return [dropShadow];
		}
		
		public function removeDropShadow():Array {
			return null;
		}
		
		public function setText(caption:String):TextField {
						// FORMAT
			var format:TextFormat = new TextFormat();  
			format.font = "FFF Reaction Trial";
			format.color = 0x000000;
			format.size = 16;
			format.bold = false;
			
			var bText:TextField = new TextField();
			// this.addChild(bText);
			bText.selectable = false;
			// TEXT FIELD
			bText.text = caption;
			bText.autoSize = TextFieldAutoSize.LEFT; 
			bText.border = false;
			bText.x = Math.ceil(this.x -(this.width/2 + bText.width/2)/2);
			bText.y = Math.ceil(this.y -(this.height/2 + bText.height/2)/2); // + (bText.height/2));
			bText.setTextFormat(format);
			
			return bText;
		}
	}
	
}
