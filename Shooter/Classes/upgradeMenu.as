package 
{

	import flash.display.MovieClip;
	import flash.filters.*;
	import flash.text.*;


	public class upgradeMenu extends MovieClip
	{
		private var menuUpgradeBackground:upgradeBackground;
		private var wL:weaponList;
		private var wMask:WLMask;
		private var wText:TextField;
		private var wFilter:DropShadowFilter;

		private var buttonArray,weaponArray:Array;
		private var mouseIsDown:Boolean = false;
		private var mouseIsUp:Boolean = true;

		private var maxWeaps:int = 5;
		private var weapIterator:int = 0;
		private var weaponName:Array = ["Musket", "2 Gauge", "12 Gauge", "Stem", "Sniper", "M16", "null"];

		public function upgradeMenu()
		{
			this.buttonArray = new Array();

			this.menuUpgradeBackground = new upgradeBackground();
			this.addChild(menuUpgradeBackground);
			menuUpgradeBackground.x = 250;
			menuUpgradeBackground.y = 10;
			
			this.wText = new TextField();
			this.wText.filters = createFilter();
			this.wText.textColor = 0x000000;
			this.wText.x = 284;
			this.wText.y = 70;
			this.setText("Musket");
			addChild(wText);
			
			this.wL = new weaponList();
			this.wMask = new WLMask();


			this.addPlayer();
			this.addWeaponList();
			this.addButtons();
		}
		
		private function createFilter():Array {
			var dropShadow:DropShadowFilter = new DropShadowFilter();
			
			dropShadow.distance = 5;
			dropShadow.angle = 45;
			dropShadow.color = 0xFFFFFF;
			dropShadow.alpha = 1;
			dropShadow.blurX = 1; // + this.scaleX;
			dropShadow.blurY = 1; // + this.scaleY;
			dropShadow.strength = 1;
			dropShadow.quality = 15;
			dropShadow.inner = false;
			dropShadow.knockout = false;
			dropShadow.hideObject = false;
			return [dropShadow];
		}

		private function addButtons()
		{

			var weaponButton:Button = new Button();
			weaponButton.setPosition(312, 182);
			weaponButton.setWidthHeight(63, 18);
			weaponButton.setScale(1, 1);
			// weaponButton.setText("HELLO!");
			this.buttonArray.push(this.addChild(weaponButton));

			weaponButton = new Button();
			weaponButton.setPosition(379, 182);
			weaponButton.setWidthHeight(63, 18);
			weaponButton.setScale(-1, 1);
			this.buttonArray.push(this.addChild(weaponButton));

			weaponButton = new Button();
			weaponButton.gotoAndStop(2);
			weaponButton.setPosition(690, 310);
			weaponButton.setWidthHeight(295, 109);
			weaponButton.name = "Continue";
			this.buttonArray.push(this.addChild(weaponButton));
			
			weaponButton = new Button();
			weaponButton.gotoAndStop(3);
			weaponButton.setPosition(280, 256);
			weaponButton.setWidthHeight(54, 28);
			weaponButton.name = "Buy";
			this.buttonArray.push(this.addChild(weaponButton));
		}

		private function addWeaponList()
		{


			wL.x = 345;
			wL.y = 130;

			wL.mask = wMask;
			addChild(wL);

			wMask.x = 345;
			wMask.y = 130;
			addChild(wMask);

			// wL.moveListDown();

		}

		public function update()
		{
			
		}
		
		public function mIsDown()
		{
			this.mouseIsDown = true;
			this.mouseIsUp = false;
		}

		public function mIsUp()
		{
			this.mouseIsUp = true;
			this.mouseIsDown = false;
		}

		// MOUSE CLICK
		public function mClick()
		{
			var mX:Number = mouseX;
			var mY:Number = mouseY;

			for (var i:int = 0; i < this.buttonArray.length; i++)
			{
				if (this.buttonArray[i].hitTestPoint(mX,mY))
				{
					if (this.buttonArray[i].name == "Continue")
					{
						Shooter.nextWave();
						this.parent.removeChild(this);
					}
					else if (i == 1)
					{
						if (this.weapIterator < this.maxWeaps)
						{
							this.wL.gotoAndPlay(2);
							this.wMask.gotoAndPlay(2);
							this.wL.moveListUp();
							this.wL.gotoAndPlay(11);
							this.wMask.gotoAndPlay(11);
							this.weapIterator++;
							this.setText(this.weaponName[weapIterator]);
						}
						else if (this.weapIterator >= this.maxWeaps)
						{
							this.weapIterator = 0;
							this.setText(this.weaponName[weapIterator]);
							this.wL.gotoAndPlay(2);
							this.wMask.gotoAndPlay(2);
							this.wL.resetListTop();
							this.wL.gotoAndPlay(11);
							this.wMask.gotoAndPlay(11);
						}
					}
					else if (i == 0)
					{
						if (this.weapIterator > 0)
						{
							this.wL.gotoAndPlay(2);
							this.wMask.gotoAndPlay(2);
							this.wL.moveListDown();
							this.wL.gotoAndPlay(11);
							this.wMask.gotoAndPlay(11);
							this.weapIterator--;
							this.setText(this.weaponName[weapIterator]);
						}
						else if (this.weapIterator <= 0)
						{
							this.weapIterator = this.maxWeaps;
							this.setText(this.weaponName[weapIterator]);
							this.wL.gotoAndPlay(2);
							this.wMask.gotoAndPlay(2);
							this.wL.resetListBottom();
							this.wL.gotoAndPlay(11);
							this.wMask.gotoAndPlay(11);
						}
					}
				}
			}
		}

		public function setText(which:String)
		{
			var format:TextFormat = new TextFormat();
			format.font = "FFF Reaction Trial";
			format.color = 0x000000;
			format.size = 14;
			format.bold = true;
			
			this.wText.text = which;
			this.wText.autoSize = TextFieldAutoSize.LEFT; 
			this.wText.border = false;
			this.wText.setTextFormat(format);
		}

		private function checkButtonPress()
		{

		}

		private function addPlayer()
		{
			var upgradePlayer:InitPlayer = new InitPlayer();
			this.weaponArray = upgradePlayer.generateWeapons();
			this.addChild(upgradePlayer);
			upgradePlayer.removeWeapon();
			upgradePlayer.gotoAndStop(28);
			upgradePlayer.x = 570;
			upgradePlayer.y = 200;
		}
	}

}