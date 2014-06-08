package 
{

	import flash.events.*;
	import flash.display.MovieClip;

	public class ParticleTest extends MovieClip
	{
		private var coinArray:Array;
		private var platformArray:Array = new Array();
		private var p1:platform;

		public function ParticleTest()
		{
			this.p1 = new platform();
			this.p1.x = 200;
			this.p1.y = 300;
			this.platformArray.push(p1);
			this.addChild(p1);
			this.p1 = new platform();
			this.p1.x = 300;
			this.p1.y = 200;
			this.platformArray.push(p1);
			this.addChild(p1);
			addEventListener(Event.ADDED_TO_STAGE, stageAddHandler);
		}

		public function stageAddHandler(e:Event)
		{
			this.coinArray = this.createCoins();
			this.addCoins(coinArray);
			stage.addEventListener(Event.ENTER_FRAME, update);
			removeEventListener(Event.ADDED_TO_STAGE, stageAddHandler);
		}

		public function createCoins():Array
		{
			var coins:Array = new Array();

			for (var i:int = 0; i < 20; i++)
			{
				var coin:ICoin;
				if (i%5 == 0)
				{
					coin = new Coin();
					coin.setName("c" + i);
					coins.push(coin);
				}
				else if (i%3 == 0)
				{
					coin = new moreCoin();
					coin.setName("c" + i);
					coins.push(coin);
				}
				else
				{
					coin = new lessCoin();
					coin.setName("c" + i);
					coins.push(coin);
				}
			}

			return coins;
		}

		public function addCoins(coins:Array)
		{
			for (var i:int = 0; i < coins.length; i++)
			{
				stage.addChild(coins[i]);
			}
		}

		public function update(e:Event)
		{
			var removeArray:Array = new Array();
			var canRemove:Boolean = false;
			for (var i:int = 0; i < this.coinArray.length; i++)
			{
				if (this.coinArray[i].update(this.coinArray))
				{
					this.coinArray[i].removeEverything();
					removeArray.push(coinArray[i].name);
					canRemove = true;
				}
				// trace(this.coinArray[i].name);
			}

			if (canRemove)
			{
				for (var j:int = 0; j < removeArray.length; j++)
				{
					for (var k:int = 0; k < this.coinArray.length; k++)
					{
						if (removeArray[j] == this.coinArray[k].name)
						{
							this.coinArray.splice(k, 1);
						}
					}
				}
			}

			this.checkForPlatform();
		}

		public function checkForPlatform()
		{
			var isOn:Boolean = false;
			for (var j:int = 0; j < this.platformArray.length; j++)
			{
				for (var i:int = 0; i < this.coinArray.length; i++)
				{
					if (this.coinArray[i].isRising())
					{

					}
					else
					{
						if (this.coinArray[i].hitTestObject(this.platformArray[j]))
						{
							this.coinArray[i].setYVel(0.00);
							this.coinArray[i].setOnPlatform(true);
							isOn = true;
						}
						else
						{
							if(!isOn) {
								this.coinArray[i].setOnPlatform(false);
							}
						}
					}
				}
			}
		}
	}

}