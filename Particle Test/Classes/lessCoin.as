package 
{

	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.*;

	public class lessCoin extends MovieClip implements ICoin
	{
		// Player Reference
		private var playerRef:initPlayer;
		
		// One Time Boolean
		private var thisHasNotBeenDone:Boolean = true;

		// Motion Variables
		private var floor:int;
		private var falling:Boolean = false;
		private var xVel,yVel:Number;
		private var fx:Number;

		// Rising and Falling Variables
		private var thisRising:Boolean;
		private var oldY:Number;

		// Timer Variables
		private var removeTimer:Timer;
		private var removeThis:Boolean = false;

		// Remove Variables
		private var run:Boolean = true;

		// Platform Variables
		private var onPlatform:Boolean = false;

		// Constructor
		public function lessCoin(player:initPlayer)
		{
			this.playerRef = player;
			this.floor = 400 - this.height / 2;
			this.xVel = 0;
			this.yVel = -3 - (Math.random() * 2);
			this.fx = 0.001;
			this.x = 250 + (Math.floor(Math.random()*(5)));
			this.y = 200 + (Math.floor(Math.random()*(5)));

			addEventListener(Event.ADDED_TO_STAGE, stageAddHandler);
		}

		// Method to handle Event.ADDED_TO_STAGE
		public function stageAddHandler(e:Event)
		{
			this.removeTimer = new Timer(1000);
			removeEventListener(Event.ADDED_TO_STAGE, stageAddHandler);
		}

		// Setter for the coin's instance name
		public function setName(what:String)
		{
			this.name = what;
		}

		// Setter for the coin's yVel
		public function setYVel(newYV:Number)
		{
			this.yVel = newYV;
		}

		// Setter for the coin's xVel
		public function setXVel(newXV:Number)
		{
			this.xVel = newXV;
		}

		// Setter for the coin's onPlatform boolean
		public function setOnPlatform(isOn:Boolean)
		{
			this.onPlatform = isOn;
		}

		// Getter for the coin's onPlatform boolean
		public function getOnPlatform():Boolean
		{
			return this.onPlatform;
		}

		// Main method to update coins
		public function update(coins:Array):Boolean
		{
			if (this.run)
			{
				if (! this.getOnPlatform())
				{
					this.fall();
				}
				this.tooClose(coins);
				this.friction();
				return this.move();
			}
			else
			{
				return false;
			}
		}

		// Method to replicate gravity
		public function fall()
		{
			this.oldY = this.y;
			if (this.y < this.floor - 3)
			{
				this.yVel +=  0.1;
				this.falling = true;
			}
			else if (this.y >= this.floor)
			{
				this.falling = false;
				this.yVel = this.yVel - this.yVel;
				this.y = 395;
			}
		}

		// Method to spread the coins out
		public function tooClose(coins:Array)
		{
			var distance:Number = 0;
			for (var i:int = 0; i < coins.length; i++)
			{
				if (this.x != coins[i].x && this.y != coins[i].y)
				{
					distance = this.x - coins[i].x;
					if (Math.abs(this.y - coins[i].y) <= 3)
					{
						if (distance < 0)
						{
							distance = Math.abs(distance);
							if (distance < 3 && this.xVel >= -0.4)
							{
								this.xVel -=  0.01;
							}
						}
						else if (distance >= 0)
						{
							if (distance < 3 && this.xVel <= 0.4)
							{
								this.xVel +=  0.01;
							}
						}
					}
					distance = this.y - coins[i].y;
					if (Math.abs(this.x - coins[i].x) <= 3)
					{
						if (distance < 0 && !this.getOnPlatform())
						{
							distance = Math.abs(distance);
							if (distance < 3 && this.yVel >= -0.2)
							{
								this.yVel -=  0.01;
							}
						}
						else if (distance >= 0)
						{
							if (distance < 3 && this.yVel <= 0.2)
							{
								this.y +=  0.01;
							}
						}
					}
				}
			}
		}

		// Method to move the coin by it's x and y velocities each frame
		public function move():Boolean
		{
			if ((this.run && this.removeThis) && this.currentFrame >= this.totalFrames)
			{
				this.x +=  this.xVel;
				this.y +=  this.yVel;
				this.run = false;
				return true;
			}
			else
			{
				this.x +=  this.xVel;
				this.y +=  this.yVel;
				return false;
			}
		}

		// Method to handle friction in the x direction
		public function friction()
		{
			if (! falling || this.getOnPlatform())
			{
				if (this.xVel > 0)
				{
					this.xVel -=  this.fx;
				}
				else if (this.xVel < 0)
				{
					this.xVel +=  this.fx;
				}
			}

			if (this.xVel < 0.01 && this.xVel > -0.01)
			{
				this.xVel = 0;
				if (! falling || this.getOnPlatform())
				{
					this.removeTimer.addEventListener(TimerEvent.TIMER, remove);
					if (thisHasNotBeenDone)
					{
						this.removeTimer.start();
						thisHasNotBeenDone = false;
					}
				}
			}
		}

		// Method that returns true if this coin is rising and false if it is falling
		public function isRising():Boolean
		{
			if (this.oldY - this.y <= 0)
			{
				return false;
			}
			else if (this.oldY - this.y > 0 && Math.abs(this.y-this.floor) > 10)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

		// Method to return a coin's amount
		public function amount():int
		{
			return 1;
		}

		// Method to remove a coin
		public function remove(e:Event)
		{
			this.gotoAndPlay(42);
			this.removeThis = true;
			this.removeTimer.stop();
		}

		// Method to remove everything;
		public function removeEverything()
		{
			this.removeTimer.removeEventListener(TimerEvent.TIMER, remove);
			parent.removeChild(this);
			this.removeTimer = null;
		}
	}
}