package  
{
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.filters.*;
	import flash.events.*;
	import flash.text.*;
	/**
	 * ...
	 * @author Jonathan
	 */
	public class BigButton extends MovieClip
	{
		private var id:int;
		private var text:String;
		private var effect:DropShadowFilter;
		private var buttonTextField:TextField;
		private var buttonBackground:Shape;
		
		public function BigButton(bigButtonID:int = 0, newText:String = "ToDo:Button Text"):void
		{
			this.id = bigButtonID;
			this.text = newText;
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			this.createEffect();
			this.createText();
			this.createButton();
			
			this.buttonTextField.x = buttonBackground.x + (buttonBackground.width - this.buttonTextField.width) / 2;
			this.buttonTextField.y = buttonBackground.y + (buttonBackground.height - this.buttonTextField.height) / 2;
			
			this.addChildren();
		}
		
		private function addChildren():void
		{
			this.addChild(this.buttonBackground);
			this.addChild(this.buttonTextField);
		}
		
		public function getButtonID():int
		{
			return this.id;
		}
		
		private function createButton():void
		{
			this.buttonBackground = new Shape();
			this.buttonBackground.graphics.lineStyle(0.2, 0x999999);
			this.buttonBackground.graphics.beginFill(0x555555, 1);
			this.buttonBackground.graphics.drawRoundRect(0, 0, 200, 200, 10, 10);
			this.buttonBackground.endFill();
		}
		
		private function createEffect():void
		{
			effect = new DropShadowFilter();
			effect.alpha = 1;
			effect.angle = 0;
			effect.blurX = 3;
			effect.blurY = 3;
			effect.color = 0x000000;
			effect.quality = 3;
			effect.strength = 0.5;
			effect.distance = 3;
			effect.knockout = false;
		}
		
		public function effectOnMouseOver():void
		{
			effect.inner = false;
			this.filters = [effect];
		}
		
		public function effectOnMouseDown():void
		{
			effect.inner = true;
			this.filters = [effect];
		}
		
		public function removeEffect():void
		{
			this.filters = [];
		}
		
		private function createText():void
		{
			buttonTextField = new TextField();
			buttonTextField.text = this.text;
			buttonTextField.textColor = 0xFFAAFF;
			buttonTextField.mouseEnabled = false;
			buttonTextField.multiline = false;
			buttonTextField.autoSize = TextFieldAutoSize.CENTER;
			buttonTextField.width = buttonTextField.textWidth;
			buttonTextField.height = buttonTextField.textHeight;
		}
		
	}

}