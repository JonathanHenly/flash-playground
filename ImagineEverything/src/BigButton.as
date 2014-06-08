package  
{
	import flash.display.GradientType;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.filters.*;
	import flash.events.*;
	import flash.text.*;
	/**
	 * ...
	 * @author Jonathan
	 */
	public class BigButton extends IEMovieClip
	{
		private var id:int;
		private var text:String;
		private var effect:DropShadowFilter;
		private var buttonTextField:TextField;
		private var buttonBackground:IEMovieClip;
		
		private var mouseDown:Boolean = false;
		
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
			
			this.addChildren();
		}
		
		private function addChildren():void
		{
			this.buttonBackground.addChildCentered(buttonTextField);
			this.addChildCentered(this.buttonBackground);
		}
		
		public function getButtonID():int
		{
			return this.id;
		}
		
		private function createButton():void
		{
			this.buttonBackground = new IEMovieClip();
			this.buttonBackground.graphics.lineStyle(2, 0x222222);
			this.buttonBackground.graphics.beginGradientFill(GradientType.RADIAL, [0x777777, 0x555555], [1, 1], [0, 255]);
			this.buttonBackground.graphics.drawRoundRect(0, 0, 150, 100, 32, 25);
			this.buttonBackground.graphics.endFill();
		}
		
		private function createEffect():void
		{
			effect = new DropShadowFilter();
			effect.alpha = 1;
			effect.angle = 45;
			effect.blurX = 1;
			effect.blurY = 1;
			effect.color = 0x000000;
			effect.quality = 3;
			effect.strength = 0.5;
			effect.distance = 3;
			effect.knockout = false;
			effect.inner = true;
		}
		
		public function effectOnMouseOver():void
		{
			effect.color = 0x888888;
			effect.strength = 1;
			effect.distance = 6;
			this.filters = [effect];
		}
		
		public function effectOnMouseDown():void
		{
			effect.color = 0x222222;
			effect.strength = 1;
			effect.distance = 6;
			effect.inner = true;
			this.filters = [effect];
		}
		
		public function effectOnMouseUp():void
		{
			effect.color = 0x888888;
			effect.strength = 1;
			effect.distance = 6;
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
		
		public function onMouseOver(event:MouseEvent):void
		{
			this.effectOnMouseOver();
		}
		
		public function onMouseOut(event:MouseEvent):void
		{
			this.removeEffect();
		}
		
		public function onMouseDown(event:MouseEvent):void
		{
			this.effectOnMouseDown();
		}
		
		public function onMouseUp(event:MouseEvent):void
		{
			this.effectOnMouseUp();
		}
		
	}

}