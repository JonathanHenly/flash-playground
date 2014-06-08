package 
{

	import flash.display.MovieClip;
	import flash.utils.Timer;
	
	public class lessCoin extends MovieClip implements ICoin
	{
		private var falling:Boolean = false;
		private var xVel,yVel:Number;
		private var fx:Number;
		private var run:Boolean = true;
		
		// Rising and Falling variables
		private var thisRising:Boolean;
		private var oldY:Number;
		
		public function lessCoin()
		{
			this.xVel = 0;
			this.yVel = -3 - (Math.random() * 2);
			trace(this.yVel);
			this.fx = 0.001;
			this.x = 250 + (Math.floor(Math.random()*(5)));
			this.y = 200 + (Math.floor(Math.random()*(5)));
		}

		public function update(particles:Array):Boolean
		{
			if (this.run)
			{
				this.fall();
				this.tooClose(particles);
				this.move();
				this.friction();
				return true;
			}
			else
			{
				return false;
			}
		}

		public function fall()
		{
			this.oldY = this.y;
			if (this.y < 380)
			{
				this.yVel +=  0.1;
				this.falling = true;
			}
			else if (this.y >= 395)
			{
				this.falling = false;
				this.yVel = this.yVel - this.yVel;
				this.y = 395;
			}
		}

		public function tooClose(particles:Array)
		{
			var distance:Number = 0;
			for (var i:int = 0; i < particles.length; i++)
			{
				if (this.x != particles[i].x && this.y != particles[i].y)
				{
					distance = this.x - particles[i].x;
					if (Math.abs(this.y - particles[i].y) <= 4)
					{
						if (distance < 0)
						{
							distance = Math.abs(distance);
							if (distance < 4 && this.xVel >= -0.4)
							{
								this.xVel -=  0.01;
							}
						}
						else if (distance >= 0)
						{
							if (distance < 4 && this.xVel <= 0.4)
							{
								this.xVel +=  0.01;
							}
						}
					}
					distance = this.y - particles[i].y;
					if (Math.abs(this.x - particles[i].x) <= 4)
					{
						if (distance < 0)
						{
							distance = Math.abs(distance);
							if (distance < 4 && this.yVel >= -0.2)
							{
								this.yVel -=  0.01;
							}
						}
						if (distance >= 0)
						{
							if (distance < 4 && this.yVel <= 0.2)
							{
								this.y +=  0.01;
							}
						}
					}
				}
			}
		}

		public function move()
		{
			this.x +=  this.xVel;
			this.y +=  this.yVel;
		}

		public function friction()
		{
			if (! falling)
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
				if (!falling) {
					this.run = false;
				}
			}
		}
		
		public function isRising():Boolean {
			if(this.oldY - this.y < 0) {
				return false;
			} else {
				return true;
			}
		}

	}

}