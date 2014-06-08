package  {
	import flash.display.MovieClip;
	import flash.text.TextFormat;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	public class MarqueeComment extends MovieClip {
		public var next:MarqueeComment;
		
		public function MarqueeComment(newText:String = "", color:uint = 0xFFFFFF) {
			var format:TextFormat = new TextFormat();
			var tf:TextField = new TextField();
			
			format.size = 15;
			format.font = "Arial Bold";
			format.align = "left";
			
			tf.defaultTextFormat = format;
			tf.text = newText.toUpperCase();
			tf.textColor = color;
			tf.border = false;
			tf.wordWrap = false;
			tf.multiline = false;
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.width = tf.textWidth;
			tf.height = 30;
			tf.x = 0;
			tf.y = 0;
			
			this.addChild(tf);
			this.y = (1050 + (30 - tf.textHeight) / 2) - 2;
		}

	}
	
}
