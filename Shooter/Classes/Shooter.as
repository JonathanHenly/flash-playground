package 
{

	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.utils.Timer;
	import flash.events.*;

	public class Shooter extends MovieClip
	{
		// PUBLIC VARIABLES
		public var fileUtils:FileUtils;
		public var levelBottomLeft:BOTTOM_LEFT;
		public var menuUpgrade:upgradeMenu;
		public var playerOne:InitPlayer;
		public var enemyArray,waveArray,bulletArray,enemyStageArray,platformArray:Array;
		public static var paused:Boolean = false;
		public static var spawnEnemies:Boolean = true;

		// PRIVATE VARIABLES
		private var waveText:WaveCountText;
		private var moneyText:MoneyText;
		private var rightArrow,leftArrow,downArrow,upArrow,space,jumping,crouched,firing,playerDead,newWave:Boolean = false;
		private var ePress,qPress:Boolean = false;
		private var menuUpgradeDisplayed:Boolean = false;
		private var ticker:Timer = new Timer(16);
		private var enemyTimer:Timer = new Timer(0);// 1 second
		private var shootTimer:Timer;
		private var enemyIt:int = 0;
		private var waveCount:int = 0;
		private var enemiesLeft:int = 0;
		private var weaponName:String = "AR_One";

		// Public Variables Main Menu
		public var playerName:String = "";
		// Private Variables Main Menu
		private var mainMenu:MainMenu;
		private var mainMenuDisplayed:Boolean = true;
		private var gameStart,gameRunning:Boolean = false;
		// Upgrade Variables
		private var currentUpgrades:String = "";
		private var upgradeLoader:Timer = new Timer(1);
		private var doneLoading:Boolean = false;
		// Constructor
		public function Shooter()
		{
			this.waveText = new WaveCountText();
			this.moneyText = new MoneyText();

			this.waveText.x = 90;
			this.waveText.y = 20;
			this.moneyText.x = 210;
			this.moneyText.y = 20;

			platformArray = new Array();
			enemyStageArray = new Array();
			bulletArray = new Array();

			levelBottomLeft = new BOTTOM_LEFT();
			levelBottomLeft.name = "LBL";
			playerOne = new InitPlayer();
			playerOne.name = "p1";

			levelBottomLeft.x = 600;
			levelBottomLeft.y = 200;

			playerOne.x = 30;
			playerOne.y = Constants.FLOOR;

			// File Utils
			this.fileUtils = new FileUtils();

			addEventListener(Event.ADDED_TO_STAGE, stageAddHandler);
			ticker.start();
		}

		private function startGame()
		{
			this.fileUtils.readFile(this.playerName);
			// this.fileUtils.writeFile(this.playerName);
			addChild(levelBottomLeft);
			addChild(playerOne);
			this.addPlatforms();
			// MAIN DISPLAY CHILDREN
			this.addChild(waveText);
			this.addChild(moneyText);
		}

		private function loadUpgrades(event:TimerEvent):void
		{
			if(this.fileUtils.isLoaded()) {
				this.doneLoading = true;
				this.currentUpgrades = this.fileUtils.getCurrentUpgrades();
				this.upgradeLoader.stop();
				this.removeEventListener(TimerEvent.TIMER, loadUpgrades);
			} else {
				this.doneLoading = false;
			}
		}

		private function mainGameLoop(event:TimerEvent):void
		{
			// trace("MAIN_GAME_LOOP");
			if (! mainMenuDisplayed)
			{
				if (this.doneLoading)
				{
					if (! paused)
					{
						if (! playerDead)
						{

							if (spawnEnemies)
							{
								newWave = true;
								this.waveCount++;
							}
							if (newWave)
							{
								this.populateEnemies(this.waveCount);
								this.createEnemies();
								this.addEnemies();
								newWave = false;
							}

							this.playerOne.update();
							this.checkForCollision();
							this.checkForPlatform();

							if (this.enemiesLeft <= 0)
							{
								this.menuUpgradeDisplayed = false;
								paused = true;
							}
						}
						else if (playerDead)
						{

						}
					}
					else if (paused)
					{
						if (! this.menuUpgradeDisplayed)
						{
							this.setFalse();
							this.menuUpgrade = new upgradeMenu();
							this.addChild(menuUpgrade);
							this.menuUpgradeDisplayed = true;
						}
						if (this.menuUpgradeDisplayed)
						{
							menuUpgrade.update();
						}
					}
				}
				else if (!doneLoading)
				{
					this.upgradeLoader.start();
				}
			}
			else if (mainMenuDisplayed)
			{
				if (! gameRunning)
				{
					this.mainMenu = new MainMenu();
					this.addChild(mainMenu);

					this.gameRunning = true;
				}
				else
				{
					if (this.mainMenu.isReady())
					{
						this.mainMenu.remove();
						this.mainMenuDisplayed = false;
						if (this.mainMenu.getName() == "" || this.mainMenu.getName().length > 13)
						{
							this.mainMenuDisplayed = true;
							this.mainMenu.add();
							this.mainMenu.setText("Invalid Username");
						}
						else
						{
							this.playerName = this.mainMenu.getName();
							this.startGame();
						}
					}
					else
					{

					}
				}
			}
		}

		// Handlers
		private function stageAddHandler(e:Event):void
		{
			this.upgradeLoader.addEventListener(TimerEvent.TIMER, loadUpgrades);
			this.enemyTimer.addEventListener(TimerEvent.TIMER, timer);
			this.ticker.addEventListener(TimerEvent.TIMER, mainGameLoop);
			// Mouse Events;
			stage.addEventListener(MouseEvent.MOUSE_DOWN, stage_mouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, stage_mouseUp);
			stage.addEventListener(MouseEvent.CLICK, stage_click);
			// Key Down Events
			stage.addEventListener(KeyboardEvent.KEY_DOWN, stage_onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, stage_onKeyUp);
			// Enter Frame
			stage.addEventListener(Event.ENTER_FRAME, stage_onEnterFrame);
			// Remove Added to Stage
			removeEventListener(Event.ADDED_TO_STAGE, stageAddHandler);
		}

		private function setFalse()
		{
			this.rightArrow = false;
			this.leftArrow = false;
			this.downArrow = false;
			this.upArrow = false;
			this.space = false;
			// this.jumping = false;
			this.crouched = false;
			this.firing = false;
			this.playerDead = false;
			this.newWave = false;

		}

		public static function nextWave()
		{
			paused = false;
			spawnEnemies = true;
		}

		private function populateEnemies(waveCount:int)
		{
			this.waveArray = generateWaveArray(waveCount);
		}

		private function generateWaveArray(waveCount:int):Array
		{
			var array:Array;

			if (waveCount == 1)
			{
				array = [0];
			}

			if (waveCount == 2)
			{
				array = [0,0,0];
			}

			return array;
		}

		private function createEnemies()
		{
			this.enemyArray = new Array();
			var DK:Death_Knight;
			for (var i:int = 0; i<=this.waveArray.length; i++)
			{
				this.enemiesLeft = i;
				if (this.waveArray[i] == 0)
				{
					DK = new Death_Knight();
					this.enemyArray.push(DK);
				}
			}
			spawnEnemies = false;

		}

		private function addEnemies()
		{
			enemyTimer.start();
		}

		private function timer(event:TimerEvent):void
		{
			if (this.enemyIt < this.enemyArray.length)
			{

				this.enemyStageArray.push(addChild(this.enemyArray[this.enemyIt]));

				var random:int = Math.ceil(Math.random() * 2);
				if (random > 1)
				{
					this.enemyArray[this.enemyIt].x = 1200;
				}
				else
				{
					this.enemyArray[this.enemyIt].x = -10;
				}

				enemyTimer.delay = 1000;

				this.enemyArray[this.enemyIt].y = 363;
				this.enemyIt++;
			}
			else
			{
				this.enemyIt = 0;
				this.enemyTimer.reset();
				this.enemyTimer.stop();
			}
		}

		private function checkForCollision()
		{
			for (var u:int = this.bulletArray.length-1; u >= 0; u--)
			{
				if (this.bulletArray[u].name == "prj_One" && (this.bulletArray[u].x >= 1200 || this.bulletArray[u].x <= 0))
				{
					this.spliceBulletArray(u);
				}
				else if (this.bulletArray[u].name == "prj_Two" && (this.bulletArray[u].x >= (this.playerOne.x + 300) || (this.bulletArray[u].x <= (this.playerOne.x - 300))))
				{
					this.spliceBulletArray(u);
				}
				else
				{
					for (var i:int = this.enemyStageArray.length-1; i >= 0; i--)
					{
						if (this.bulletArray[u].hitTestObject(this.enemyStageArray[i]))
						{
							this.enemiesLeft--;
							this.spliceEnemyStageArray(i);
							this.spliceBulletArray(u);
						}
					}
				}
			}
		}

		private function spliceBulletArray(u:int)
		{
			this.bulletArray[u].removeProj();
			this.bulletArray.splice(u,1);
		}

		private function spliceEnemyStageArray(i:int)
		{
			this.enemyStageArray[i].remove();
			this.enemyStageArray.splice(i,1);
		}

		// PLATFORMS;
		private function addPlatforms()
		{
			var platform:platformOne = new platformOne();
			var platform2:platformTwo = new platformTwo();
			var platform3:platformThree = new platformThree();
			var platform4:platformThree = new platformThree();
			var platform5:platformFour = new platformFour();

			this.platformArray.push(addChild(platform));
			platform.x = 245;
			platform.y = 330;
			platform.visible = false;

			this.platformArray.push(addChild(platform2));
			platform2.x = 320;
			platform2.y = 255;
			platform2.visible = false;

			platform2 = new platformTwo();
			this.platformArray.push(addChild(platform2));
			platform2.x = 700;
			platform2.y = 255;
			platform2.visible = false;

			this.platformArray.push(addChild(platform3));
			platform3.x = 1060;
			platform3.y = 320;
			platform3.visible = false;

			this.platformArray.push(addChild(platform4));
			platform4.x = 1095;
			platform4.y = 240;
			platform4.visible = false;

			this.platformArray.push(addChild(platform5));
			platform5.x = 980;
			platform5.y = 160;
			platform5.visible = false;

			platform5 = new platformFour();
			this.platformArray.push(addChild(platform5));
			platform5.width = 85;
			platform5.x = 875;
			platform5.y = 175;
			platform5.visible = false;

			platform3 = new platformThree();
			this.platformArray.push(addChild(platform3));
			platform3.width = 80;
			platform3.x = 490;
			platform3.y = 155;
			platform3.visible = false;
		}

		// Check For Platforms
		private function checkForPlatform()
		{
			var px:Number = playerOne.x;
			var py:Number = playerOne.y;

			for (var i:int = 0; i < this.platformArray.length; i++)
			{
				if (this.platformHitTest(this.platformArray[i],px,py))
				{
					playerOne.y = this.platformArray[i].y - 20;
					playerOne.isOnPlatform = true;
					playerOne.jumping = false;
					break;
				}
				else
				{
					playerOne.isOnPlatform = false;
				}

				if (playerOne.y < Constants.FLOOR)
				{
					if (! playerOne.isOnPlatform)
					{
						playerOne.jumping = true;
					}
				}
			}
		}

		// Platform Hit Test
		private function platformHitTest(platform:MovieClip, px:Number, py:Number):Boolean
		{
			if (px >= platform.x && px <= platform.x + platform.width)
			{
				if (py >= platform.y - playerOne.height/2 && py <= platform.y-10)
				{
					if (playerOne.getJumpSpeed() > 1)
					{
						return true;
					}
					return false;
				}
				return false;
			}
			return false;
		}

		// Event Listener Functions
		private function stage_onKeyDown(event:KeyboardEvent):void
		{
			if (event.keyCode == 39)
			{
				rightArrow = true;
			}
			if (event.keyCode == 37)
			{
				leftArrow = true;
			}
			if (event.keyCode == 38)
			{
				upArrow = true;
			}
			if (event.keyCode == 40)
			{
				downArrow = true;
			}
			if (event.keyCode == 32)
			{
				space = true;
			}
			if (event.keyCode == 81)
			{
				if (! qPress)
				{
					this.weaponName = playerOne.switchLeft();
				}

				this.qPress = true;
			}
			if (event.keyCode == 69)
			{
				if (! qPress)
				{
					this.weaponName = playerOne.switchRight();
				}

				this.qPress = true;
			}

			/*if (event.keyCode == 32) {
			
			}*/
		}

		private function stage_onKeyUp(event:KeyboardEvent):void
		{
			if (! paused)
			{
				if (event.keyCode == 39)
				{
					rightArrow = false;
				}
				if (event.keyCode == 37)
				{
					leftArrow = false;
				}
				if (event.keyCode == 38)
				{
					upArrow = false;
				}
				if (event.keyCode == 40)
				{
					downArrow = false;
				}
				if (event.keyCode == 32)
				{
					space = false;
				}
				if (event.keyCode == 81)
				{
					this.qPress = false;
				}
				if (event.keyCode == 69)
				{
					this.qPress = false;
				}
			}
		}

		private function stage_mouseDown(event:Event):void
		{
			if (this.menuUpgradeDisplayed)
			{
				this.menuUpgrade.mIsDown();
			}
		}

		private function stage_mouseUp(event:Event):void
		{
			if (this.menuUpgradeDisplayed)
			{
				this.menuUpgrade.mIsUp();
			}
		}

		private function stage_click(event:Event):void
		{
			if (this.menuUpgradeDisplayed)
			{
				this.menuUpgrade.mClick();
			}
		}

		private function stage_onEnterFrame(event:Event):void
		{
			if (! paused && ! mainMenuDisplayed)
			{
				if (rightArrow)
				{
					this.playerOne.moveRight();
				}
				if (leftArrow)
				{
					this.playerOne.moveLeft();
				}
				if (downArrow)
				{
					this.playerOne.crouch();
				}
				if (upArrow && !jumping)
				{
					this.playerOne.jump();
				}
				else if (this.playerOne.jumping)
				{
					this.playerOne.jump();
				}
				if (space)
				{
					if (! this.firing)
					{
						if (this.weaponName == "TwelveGauge")
						{
							for (var i:int = 0; i < 5; i++)
							{
								this.bulletArray.push(this.playerOne.shoot());
							}
						}
						else
						{
							this.bulletArray.push(this.playerOne.shoot());
						}
						this.isFiring();
					}
				}
			}
		}

		private function isFiring():void
		{
			if (! paused)
			{
				this.firing = true;

				this.shootTimer = new Timer(500);// 1/2 second
				this.shootTimer.addEventListener(TimerEvent.TIMER, fire);

				this.shootTimer.start();
				function fire()
				{
					firing = false;
					shootTimer.stop();
					removeEventListener(TimerEvent.TIMER, fire);
					shootTimer = null;
				}
			}

		}

	}

}