package 
{

	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.*;

	public class Coin extends MovieClip implements ICoin
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
		private var thisFalling,thisRising:Boolean;
		private var oldY:Number;

		// Timer Variables
		private var removeTimer:Timer;
		private var removeThis:Boolean = false;

		// Remove Variables
		private var run:Boolean = true;

		// Platform Variables
		private var onPlatform:Boolean = false;

		// Constructor
		public function Coin(player:InitPlayer)
		{
			this.playerRef = player;
			this.floor = 400 - this.height / 2;
			this.xVel = 0;
			this.yVel = -3 - (Math.random() * 3);
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
			this.oldY = this.y;// Used with the method isRising

			// Conditional to test if the coin has reached the ground or not
			if (this.y < this.floor - 3)
			{
				this.yVel +=  0.1;
				this.falling = true;
			}
			else if (this.y >= this.floor)
			{
				this.falling = false;
				this.yVel = this.yVel - this.yVel;// This equals zero
				this.y = 395;
			}
		}

		// Method to spread the coins out
		public function tooClose(coins:Array)
		{
			var distance:Number = 0;// Variable to measure distance between coins

			// Loop to run through the coins array for collision testing
			for (var i:int = 0; i < coins.length; i++)
			{
				// Conditional to exclude testing of the same coin
				if (this.x != coins[i].x && this.y != coins[i].y)
				{
					distance = this.x - coins[i].x;
					// Collision testing conditionals
					//
					// Conditional to test that the coins are in the same y domain
					// before altering the x velocity
					if (Math.abs(this.y - coins[i].y) <= 4)
					{
						if (distance < 0)
						{
							distance = Math.abs(distance);
							// If collision occurs on the right decrease the xVel
							if (distance < 4 && this.xVel >= -0.4)
							{
								this.xVel -=  0.01;
							}
						}
						else if (distance >= 0)
						{
							// If collision occurs on the left increase the xVel
							if (distance < 4 && this.xVel <= 0.4)
							{
								this.xVel +=  0.01;
							}
						}
					}

					distance = this.y - coins[i].y;

					// Conditional to test that the coins are in the same x domain
					// before altering the y velocity
					if (Math.abs(this.x - coins[i].x) <= 4)
					{
						if (distance < 0 && !this.getOnPlatform())
						{
							distance = Math.abs(distance);
							// If collision occurs above coin decrease yVel
							if (distance < 4 && this.yVel >= -0.2)
							{
								this.yVel -=  0.01;
							}
						}
						if (distance >= 0)
						{
							// If collision occurs below coin increase yVel
							if (distance < 4 && this.yVel <= 0.2)
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
			// Conditional to apply friction in the x direction when the coins reach
			// the ground
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

			// Conditional to set the xVelocity to 0 if it's between 0.01 and -0.01 to 
			// ensure that the velocity won't continue forever
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

		// Method that returns true if the coin is rising and false if it is falling
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
			return 10;
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