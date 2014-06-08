package 
{

	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.*;

	public class Weapon extends MovieClip
	{
		private var wepClip,bullet:MovieClip;
		private var dam,delay,delayEnd,projectileX,projectileY,i:int = 0;

		// Constructor
		public function Weapon(clip:MovieClip, newBullet:MovieClip, damage:int, newDelay:int, projX:int, projY:int):void
		{
			this.wepClip = clip;
			this.bullet = newBullet;
			this.dam = damage;
			this.delay = newDelay;
			this.delayEnd = this.delay;
			this.projectileX = projX;
			this.projectileY = projY;
		}

		// Accessors
		public function getWepClip():MovieClip
		{
			return this.wepClip;
		}

		public function getBullet():MovieClip
		{
			return this.bullet;
		}

		public function getDamage():int
		{
			return this.dam;
		}

		public function getDelay():int
		{
			return this.delay;
		}

		// Methods
		public function shoot():void
		{
			if (this.getBullet() != null)
			{
				if (delayEnd >= delay)
				{
					var parX:int = this.parent.x + (this.projectileX * xScaleCheck());
					var parY:int = this.parent.y + this.projectileY;


					var tempProjectile:prj_One = new prj_One(parX,parY,this.parent.scaleX);
					tempProjectile.name = "proj" + i;
					i++;


					stage.addChild(tempProjectile);
					this.getWepClip().gotoAndPlay(2);

					this.delayEnd = 0;
				}
				else
				{
					this.delayEnd++;
				}
			}
		}

		private function xScaleCheck():int
		{
			if (this.parent.scaleX < 0)
			{
				return -1;
			}

			return 1;
		}

	}

}