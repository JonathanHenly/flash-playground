package 
{

	import flash.display.MovieClip;
	import flash.utils.Timer;

	public class darkBloodParticle extends MovieClip implements IParticle
	{

		private var falling:Boolean = false;
		private var xVel,yVel:Number;
		private var fx:Number;
		private var run:Boolean = true;
		
		// Rising and Falling variables
		private var thisFalling, thisRising:Boolean;
		private var oldY:Number;
		
		// Constructor
		public function darkBloodParticle()
		{
			this.xVel = 0;
			this.yVel = -3 - (Math.random() * 3);
			this.fx = 0.001;
			this.x = 250 + (Math.floor(Math.random()*(5)));
			this.y = 200 + (Math.floor(Math.random()*(5)));
		}

		// Main method to update particles
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
		
		// Method to replicate gravity
		public function fall()
		{
			this.oldY = this.y; // Used with the method isRising
			
			// Conditional to test if the particle has reached the ground or not
			if (this.y < 380)
			{
				this.yVel +=  0.1;
				this.falling = true;
			}
			else if (this.y >= 395)
			{
				this.falling = false;
				this.yVel = this.yVel - this.yVel; // This equals zero
				this.y = 395;
			}
		}
		
		// Method to spread the particles out
		public function tooClose(particles:Array)
		{
			var distance:Number = 0; // Variable to measure distance between particles
			
			// Loop to run through the particles array for collision testing
			for (var i:int = 0; i < particles.length; i++)
			{
				// Conditional to exclude testing of the same particle
				if (this.x != particles[i].x && this.y != particles[i].y)
				{
					distance = this.x - particles[i].x;
					
					// Collision testing conditionals
					if (Math.abs(this.y - particles[i].y) <= 4)
					{
						if (distance < 0)
						{
							distance = Math.abs(distance);
							// If collision occurs on the left decrease the xVel
							if (distance < 4 && this.xVel >= -0.4)
							{
								this.xVel -=  0.01;
							}
						}
						else if (distance >= 0)
						{
							// If collision occurs on the right increase the xVel
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
							// If collision occurs above particle decrease yVel
							if (distance < 4 && this.yVel >= -0.2)
							{
								this.yVel -=  0.01;
							}
						}
						if (distance >= 0)
						{
							// If collision occurs below particle increase yVel
							if (distance < 4 && this.yVel <= 0.2)
							{
								this.y +=  0.01;
							}
						}
					}
				}
			}
		}
		
		// Method to move the particle by it's x and y velocities each frame
		public function move()
		{
			this.x +=  this.xVel;
			this.y +=  this.yVel;
		}
		
		// Method to handle friction in the x direction
		public function friction()
		{
			// Conditional to apply friction in the x direction when the particles reach
			// the ground
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
			
			// Conditional to set the xVelocity to 0 if it's between 0.01 and -0.01 to 
			// ensure that the velocity won't continue forever
			if (this.xVel < 0.01 && this.xVel > -0.01)
			{
				this.xVel = 0;
				if (!falling) {
					this.run = false;
				}
			}
		}
		
		// Method that returns true if the particle is rising and false if it is falling
		public function isRising():Boolean {
			if(this.oldY - this.y < 0) {
				return false;
			} else {
				return true;
			}
		}
	}

}