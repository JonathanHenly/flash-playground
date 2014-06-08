package {
	import flash.display.MovieClip;
	import flash.filters.*;
	import flash.events.*;
	/**
	 * @author Rich
	 */
	public class ShopButton extends MovieClip {
		private const SQUARE_ONE_COLOR:uint = 0x1F0FAF;
		private const SQUARE_TWO_COLOR:uint = 0x1F0FAF;
		private const SQUARE_THREE_COLOR:uint = 0x1F0FAF;
		private const SQUARE_ONE_MAX:uint = 250;
		private const SQUARE_ONE_MIN:uint = 0;
		private const SQUARE_TWO_MAX:uint = 122;
		private const SQUARE_TWO_MIN:uint = 0;
		private const SQUARE_THREE_MAX:uint = 122;
		private const SQUARE_THREE_MIN:uint = 0;
		
		private var squareOne:MenuButton = new MenuButton();
		private var squareTwo:MenuButton = new MenuButton();
		private var squareThree:MenuButton = new MenuButton();
		
		public function ShopButton():void
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
	
		public function onAddedToStage(event:Event):void
		{
			this.graphics.beginFill(0xFFFFFF, 1);
			this.graphics.moveTo(-Constants.SHOPBUTTON_MAX, -Constants.SHOPBUTTON_MIN);
			this.graphics.lineTo(-Constants.SHOPBUTTON_MAX, Constants.SHOPBUTTON_MIN);
			this.graphics.lineTo(-Constants.SHOPBUTTON_MIN, Constants.SHOPBUTTON_MAX);
			this.graphics.lineTo(Constants.SHOPBUTTON_MIN, Constants.SHOPBUTTON_MAX);
			this.graphics.lineTo(Constants.SHOPBUTTON_MAX, Constants.SHOPBUTTON_MIN);
			this.graphics.lineTo(Constants.SHOPBUTTON_MAX, -Constants.SHOPBUTTON_MIN);
			this.graphics.lineTo(Constants.SHOPBUTTON_MIN, -Constants.SHOPBUTTON_MAX);
			this.graphics.lineTo(-Constants.SHOPBUTTON_MIN, -Constants.SHOPBUTTON_MAX);
			this.graphics.lineTo(-Constants.SHOPBUTTON_MAX, -Constants.SHOPBUTTON_MIN);
			this.graphics.lineTo(-Constants.SHOPBUTTON_MAX, Constants.SHOPBUTTON_MIN);
			this.graphics.endFill();
			
			this.createShopMenu();
			
			this.addEventListener(MouseEvent.CLICK, onClick);
			this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function onClick(event:MouseEvent):void
		{
			Asteroids.pauseGame();
			this.displayShopMenu();
		}
		
		public function onMouseOver(event:MouseEvent):void
		{
			Asteroids.unPauseGame();
			this.hideShopMenu();
		}
		
		public function createShopMenu():void
		{
			var tmpIcon:ButtonIcon = new ButtonIcon();
			tmpIcon.x = 300;
			tmpIcon.y = 300;
			
			var tmpPanel:UnlockPanel = new UnlockPanel();
			tmpPanel.x = 0; // (550 - tmpPanel.width) / 2;
			tmpPanel.y = 0; // (400 - tmpPanel.height) / 2;
			
			this.squareOne.graphics.beginFill(SQUARE_ONE_COLOR, 1);
			this.squareOne.graphics.moveTo(SQUARE_ONE_MIN, SQUARE_ONE_MIN);
			this.squareOne.graphics.lineTo(SQUARE_ONE_MAX, SQUARE_ONE_MIN);
			this.squareOne.graphics.lineTo(SQUARE_ONE_MAX, SQUARE_ONE_MAX);
			this.squareOne.graphics.lineTo(SQUARE_ONE_MIN, SQUARE_ONE_MAX);
			this.squareOne.graphics.lineTo(SQUARE_ONE_MIN, SQUARE_ONE_MIN);
			this.squareOne.graphics.endFill();
			
			this.squareTwo.graphics.beginFill(SQUARE_TWO_COLOR, 1);
			this.squareTwo.graphics.moveTo(SQUARE_TWO_MIN, SQUARE_TWO_MIN);
			this.squareTwo.graphics.lineTo(SQUARE_TWO_MAX, SQUARE_TWO_MIN);
			this.squareTwo.graphics.lineTo(SQUARE_TWO_MAX, SQUARE_TWO_MAX);
			this.squareTwo.graphics.lineTo(SQUARE_TWO_MIN, SQUARE_TWO_MAX);
			this.squareTwo.graphics.lineTo(SQUARE_TWO_MIN, SQUARE_TWO_MIN);
			this.squareTwo.graphics.endFill();
			
			this.squareThree.graphics.beginFill(SQUARE_THREE_COLOR, 1);
			this.squareThree.graphics.moveTo(SQUARE_THREE_MIN, SQUARE_THREE_MIN);
			this.squareThree.graphics.lineTo(SQUARE_THREE_MAX, SQUARE_THREE_MIN);
			this.squareThree.graphics.lineTo(SQUARE_THREE_MAX, SQUARE_THREE_MAX);
			this.squareThree.graphics.lineTo(SQUARE_THREE_MIN, SQUARE_THREE_MAX);
			this.squareThree.graphics.lineTo(SQUARE_THREE_MIN, SQUARE_THREE_MIN);
			this.squareThree.graphics.endFill();
			
			this.squareOne.x = 50;
			this.squareOne.y = 50;
			this.squareTwo.x = squareOne.x + squareOne.width + 5;
			this.squareTwo.y = squareOne.y;
			this.squareThree.x = squareOne.x + squareOne.width + 5;
			this.squareThree.y = squareTwo.y + squareTwo.height + 5;
			
			this.squareOne.setShadowAngle(0);
			this.squareTwo.setShadowAngle(135);
			this.squareThree.setShadowAngle(225);
			
			this.squareOne.setEndCoords(squareOne.x + 8, squareOne.y);
			this.squareTwo.setEndCoords(squareTwo.x - 8, squareTwo.y + 8);
			this.squareThree.setEndCoords(squareThree.x - 8, squareThree.y - 8);
			
			/*
			stage.addChild(this.squareOne);
			stage.addChild(this.squareTwo);
			stage.addChild(this.squareThree);
			*/
			
			// Asteroids.hideAll();
			
			// stage.addChild(tmpIcon);
			
			// stage.addChild(tmpPanel);
			

		}
		
		public function displayShopMenu():void
		{
			Asteroids.hideAll();
			this.visible = true;
			this.squareOne.visible = true;
			this.squareTwo.visible = true;
			this.squareThree.visible = true;

		}
		
		public function hideShopMenu():void
		{
			Asteroids.showAll();
			this.squareOne.visible = false;
			this.squareTwo.visible = false;
			this.squareThree.visible = false;
		}
		
	}
}
