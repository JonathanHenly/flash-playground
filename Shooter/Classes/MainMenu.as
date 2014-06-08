package 
{
	
	import flash.text.*;
	import flash.display.MovieClip;
	import flash.events.*;

	public class MainMenu extends MovieClip
	{
		private var startButton:mainStartButton;
		private var readyToStart:Boolean = false;
		private var inputField:TextField;
		private var myFormat:TextFormat;

		public function MainMenu()
		{
			this.inputField = new TextField();
			this.myFormat = new TextFormat();
			this.startButton = new mainStartButton();
			this.startButton.x = 598.0;
			this.startButton.y = 224.0;
			// this.startButton.index = -1;
			this.addChild(startButton);
			addEventListener(Event.ADDED_TO_STAGE, stageAddHandler);
			this.inputBox();
		}

		private function stageAddHandler(e:Event):void
		{
			this.startButton.addEventListener(MouseEvent.MOUSE_DOWN, startPressed);
			removeEventListener(Event.ADDED_TO_STAGE, stageAddHandler);
		}

		private function startPressed(e:Event):void
		{
			this.readyToStart = true;
		}

		public function isReady():Boolean
		{
			return this.readyToStart;
		}

		private function inputBox()
		{
			this.myFormat.size = 22;
			this.myFormat.align = TextFormatAlign.LEFT;
			
			this.inputField.defaultTextFormat = myFormat;
			
			addChild(inputField);
			this.inputField.border = true;
			this.inputField.maxChars = 13;
			this.inputField.restrict = "A-Za-z";
			this.inputField.width = 136.00;
			this.inputField.height = 27.00;
			this.inputField.x = 576.00;
			this.inputField.y = 186.00;
			this.inputField.type = "input";
			// inputField.multiline = true;
			// stage.focus = inputField;
		}
		
		public function setText(msg:String) {
			this.inputField.text = msg;
		}
		
		public function getName():String {
			return this.inputField.text;
		}
		
		public function remove() {
			this.removeEventListener(MouseEvent.MOUSE_DOWN, startPressed);
		}
		
		public function add() {
			this.readyToStart = false;
			this.startButton.addEventListener(MouseEvent.MOUSE_DOWN, startPressed);
		}

	}

}