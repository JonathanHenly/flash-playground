package 
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.*;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.display.DisplayObject;
	
	/**
	 * ...
	 * @author Jonathan Henly
	 */
	public class MainDisplay extends MovieClip
	{
		private var displayBackground:MovieClip;
		private var startText:TextField;
		private var startFormat:TextFormat;
		private var humText:TextField;
		private var compText:TextField;
		
		private var doneStarting:Boolean = false;
		private var stageOne:Boolean = true;
		private var stageTwo:Boolean = false;
		private var count:int = 0;
		
		public static var humScore:int = 0;
		public static var compScore:int = 0;
		
		public function MainDisplay():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			displayBackground = new MovieClip();
			createMainDisplay();
			manageTextFields();
		}
		
		private function createMainDisplay():void
		{
			displayBackground.graphics.beginFill(0xE1E1FF, 1);
			displayBackground.graphics.drawRect(0, 0, (stage.stageWidth - 20), (stage.stageHeight - 20));
			displayBackground.graphics.endFill();
			
			this.addChild(displayBackground);
		}
		
		private function manageTextFields():void
		{
			startText = initTextField();
			humText = initTextField();
			compText = initTextField();
			
			humText.visible = false;
			compText.visible = false;
			
			readyTextField("Ready...", startText);
			readyTextField("C Score: ", compText);
			readyTextField("H Score: ", humText);
			
			
			positionTextFields();
		}
		
		private function positionTextFields():void
		{
			Utils.centerChild(stage, startText, Utils.CENTERED);
			
			compText.x = this.x + 40;
			compText.y = this.y + 20;
			
			humText.x = this.width - humText.width - 40;
			humText.y = this.y + 20;
			
			this.addChild(startText);
			stage.addChild(compText);
			stage.addChild(humText);
		}
		
		private function initTextField():TextField
		{
			var tmpTF:TextField = new TextField();
			var tmpF:TextFormat = new TextFormat();
			
			tmpF.font = 'myFont';
			tmpF.size = 20;
			tmpF.align = TextFieldAutoSize.CENTER;
			tmpF.letterSpacing = 1.5;
			tmpF.color = 0x5E5EFF;
			
			tmpTF.embedFonts = true;
			tmpTF.defaultTextFormat = tmpF;
			tmpTF.selectable = false;
			tmpTF.wordWrap = false;
			
			return tmpTF;
		}
		
		private function readyTextField(newText:String = "", tf:TextField = null):void
		{
			tf.text = newText;
			resizeTextField(tf);
		}
		
		private function resizeTextField(tf:TextField):void
		{
			tf.width = tf.textWidth + 5;
			tf.height = tf.textHeight + 5;
		}
		
		public function update():void
		{
			if (!doneStarting) {
				count++;
				
				if (count <= 30) {
					if ((count % 2) == 0) {
						startText.alpha -= 0.05;
						startText.text = "READY...";
					}
				} else if (count <= 50) {
					startText.text = "START";
					resizeTextField(startText);
					
					if (stageOne) {
						startText.alpha = 1;
						stageOne = false;
					} else if ((count % 3) == 0) {
						startText.alpha -= 0.05;
					}
				} else {
					startText.visible = false;
					compText.visible = true;
					humText.visible = true;
					
					Utils.fixIndex(compText, stage);
					Utils.fixIndex(humText, stage);
					
					compText.text = "C Score: " + compScore;
					humText.text = "H Score: " + humScore;
					
					resizeTextField(compText);
					resizeTextField(humText);
					
					doneStarting = true;
					
					Driver.readyToStart = true;
				}
			}
		}

		public function increaseComputerScore():void
		{
			compScore += 10;
			compText.text = "H Score: " + compScore;
			resizeTextField(compText);
		}
		
		public function increaseHumanScore():void
		{
			humScore += 10;
			humText.text = "H Score: " + humScore;
			resizeTextField(humText);
		}
	}
	
}