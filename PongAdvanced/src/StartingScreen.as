package 
{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.AntiAliasType;
	import flash.text.TextFormat;
	import mx.core.FontAsset;
	
	/**
	 * ...
	 * @author Jonathan Henly
	 */
	public class StartingScreen extends MovieClip
	{	
		// [Embed(source = "../fonts/Capture_it.ttf", fontName = "Capture_it", fontWeight = "bold", advancedAntiAliasing = "true", mimeType = "application/x-font")]
		// private var capture_it:Class;
		
		private var mainText:TextField;
		private var mainFormat:TextFormat;
		
		public function StartingScreen():void 
		{
			FontAsset;
			mainText = new TextField();
			mainFormat = new TextFormat();
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			this.createTextField();
		}
		
		private function createTextField():void
		{		
			mainFormat.align = TextFieldAutoSize.CENTER;
			mainFormat.color = 0x8080FF;
			// mainFormat.letterSpacing = 2;
			mainFormat.size = 100;
			// Font.registerFont(capture_it);
			mainFormat.font = 'myFont';
			
			mainText.embedFonts = true;
			mainText.defaultTextFormat = mainFormat;
			mainText.text = "PONG";
			mainText.antiAliasType = AntiAliasType.ADVANCED;
			mainText.width = mainText.textWidth + 5;
			mainText.height = mainText.textHeight + 5;
			mainText.wordWrap = false;
			mainText.textColor = 0x8080FF;
			mainText.selectable = false;
			
			this.addChild(mainText);
		}
		
		public function update():void
		{
			
		}
		
		public function closeScreen():void
		{
			this.visible = false;
		}
	}
	
}