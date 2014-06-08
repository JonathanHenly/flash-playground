package 
{

	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.utils.Timer;
	import flash.events.TimerEvent;

	public class Shooter extends MovieClip
	{
		public var levelBottomLeft:BOTTOM_LEFT;
		public var playerOne:InitPlayer;
		public var enemyArray:Array;
		public var waveArray:Array;

		private var myTimer:Timer = new Timer(1000);// 1 second
		private var enemyIt:int = 0;


		// Constructor
		public function Shooter()
		{
			this.myTimer.addEventListener(TimerEvent.TIMER, timer);
			
			levelBottomLeft = new BOTTOM_LEFT();
			levelBottomLeft.name = "LBL";
			playerOne = new InitPlayer();
			playerOne.name = "p1";
			
			addChild(levelBottomLeft);
			levelBottomLeft.x = 600;
			levelBottomLeft.y = 200;
			addChild(playerOne);
			playerOne.x = 30;
			playerOne.y = stage.height - playerOne.height + 30;
			
			this.startGame();
		}

		private function startGame()
		{
			var waveCount:int = 1;
			var gameOver:Boolean;

			while (!gameOver)
			{
				var playerDead:Boolean;

				this.populateEnemies(waveCount);
				this.createEnemies();
				this.addEnemies();
				
				this.checkForCollision();
				if (playerDead)
				{
					gameOver = true;
				}

				playerDead = true;
			}

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
				array = [0,0,0,0,0,0,0,0,0,0];
			}

			return array;
		}

		private function createEnemies()
		{
			this.enemyArray = new Array();
			var DK:Death_Knight;
			for (var i:int = 0; i<this.waveArray.length; i++)
			{
				if (this.waveArray[i] == 0)
				{
					DK = new Death_Knight();
					this.enemyArray.push(DK);
				}
			}

		}

		private function addEnemies()
		{
			myTimer.start();
		}

		private function timer(event:TimerEvent):void
		{
			if (this.enemyIt < this.enemyArray.length)
			{
				var random:int = Math.ceil(Math.random() * 2);
				
				this.addChild(this.enemyArray[this.enemyIt]);
				if (random > 1)
				{
					this.enemyArray[this.enemyIt].x = 550;
				}
				else
				{
					this.enemyArray[this.enemyIt].x = -10;
				}

				this.enemyArray[this.enemyIt].y = 363;
				this.enemyIt++;
			}
			else
			{
				this.myTimer.stop();
			}
		}

		private function checkForCollision()
		{
			if(playerOne.shoot()) {
				trace("HELLO!");
			}
		}

	}

}