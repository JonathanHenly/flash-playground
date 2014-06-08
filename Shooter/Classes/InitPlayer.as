package 
{

	import flash.display.MovieClip;
	import flash.display.Stage;

	public class InitPlayer extends MovieClip
	{
		var temp:Number = 0;
		private var weapons:Array;
		private var tempWeap:Weapon;
		private var health:int;
		private var weaponIndex:int;
		private var maxWeaps:int = 5;
		private var weaponIterator:int = 0;
		private var rotX,rotY,wepAngle:Number = 0;

		//how quickly should the jump start off
		private var jumpSpeedLimit:int = 15;
		//the current speed of the jump;
		private var jumpSpeed:Number = jumpSpeedLimit;

		public var downArrow,jumping,crouched,isOnPlatform,isRotational:Boolean = false;

		// Constructor
		public function InitPlayer()
		{
			weapons = this.generateWeapons();
			this.x = 100;
			this.y = 300;
			this.weaponIndex = 0;
			this.health = 1000;

			attachWeapon(0);
		}

		public function update()
		{
			if (this.weaponIterator > 2)
			{
				this.isRotational = true;
				this.gunRotation();
			} else {
				this.isRotational = false;
			}
		}

		public function gunRotation()
		{
			var rad:Number = Math.atan2(mouseY - this.weapons[this.weaponIterator].y,mouseX - this.weapons[this.weaponIterator].x); 
			var angle:Number = rad*(180/Math.PI);
						
			this.wepAngle = angle;
			
			if(stage.mouseX <= this.x) {
				this.scaleX = -1;
			} else {
				this.scaleX = 1;
			}

			this.weapons[weaponIterator].getWepClip().rotation = (angle) + 0;
			this.weapons[weaponIterator].getWepClip().y -=  0;
		}

		public function switchLeft():String
		{
			this.weaponIterator--;
			if (this.weaponIterator < 0)
			{
				this.weaponIterator = this.maxWeaps;
			}

			this.removeWeapon();
			return (this.attachWeapon(this.weaponIterator));
		}

		public function switchRight():String
		{
			this.weaponIterator++;
			if (this.weaponIterator >= this.maxWeaps + 1)
			{
				this.weaponIterator = 0;
			}

			this.removeWeapon();
			return (this.attachWeapon(this.weaponIterator));
		}

		// Methods
		public function attachWeapon(index:int):String
		{
			this.weaponIndex = index;
			this.tempWeap = weapons[index];
			addChild(tempWeap.getWepClip());
			addChild(tempWeap);
			tempWeap.getWepClip().x = tempWeap.getXPos();
			tempWeap.getWepClip().y = tempWeap.getYPos();

			return this.tempWeap.name;
		}

		public function removeWeapon():void
		{
			this.removeChild(this.tempWeap.getWepClip());
			this.removeChild(this.tempWeap);
		}

		public function generateWeapons():Array
		{
			var temp:Array = new Array();
			var tempWeap:Weapon;

			var AR:AR_One = new AR_One();
			var TG:TwoGauge = new TwoGauge();
			var TV:TwelveGauge = new TwelveGauge();
			var S:Stem = new Stem();
			var SR:Sniper = new Sniper();
			var MST:M16 = new M16();

			var B1:prj_One = new prj_One(0,0,0);
			var B2:prj_Two = new prj_Two(0,0,0);
			var B3:prj_Three = new prj_Three(0,0,0);

			// Format is as follows -
			// (clip:MovieClip, newBullet:MovieClip, damage:int, newDelay:int, projX:int, projY:int, weaponX:int, weaponY:int)

			tempWeap = new Weapon(AR,B1,10,10,50,-6,22,0);
			tempWeap.name = "AR_One";
			temp.push(tempWeap);

			tempWeap = new Weapon(TG,B1,10,10,50,-6,15,-2);
			tempWeap.name = "TwoGauge";
			temp.push(tempWeap);

			tempWeap = new Weapon(TV,B2,10,10,50,-6,15,2);
			tempWeap.name = "TwelveGauge";
			temp.push(tempWeap);

			tempWeap = new Weapon(S,B3,10,10,0,0,0,0);
			tempWeap.name = "Stem";
			temp.push(tempWeap);

			tempWeap = new Weapon(SR,B3,10,10,50,-6,0,0);
			tempWeap.name = "Sniper";
			temp.push(tempWeap);

			tempWeap = new Weapon(MST,B3,10,10,50,-6,0,0);
			tempWeap.name = "M16";
			temp.push(tempWeap);

			return temp;
		}

		public function moveRight()
		{
				this.x +=  2.5;
				this.animatePlayer();
			if (! this.isRotational)
			{
				this.scaleX = 1;
			}
		}

		public function moveLeft()
		{
				this.x -=  2.5;
				this.animatePlayer();
			if (! this.isRotational)
			{
				this.scaleX = -1;
			}
		}

		public function animatePlayer():void
		{
			if (this.currentFrame == 1)
			{
				this.gotoAndPlay(2);
			}
		}

		public function crouch():void
		{
			if (downArrow)
			{
				if (this.currentFrame == 1)
				{
					this.gotoAndPlay(17);
				}
			}
			if (! downArrow && this.currentFrame == 22)
			{
				this.gotoAndPlay(23);
			}
		}

		public function getJumpSpeed():Number
		{
			return this.jumpSpeed;
		}

		public function jump():void
		{
			//if main isn't already jumping
			if (! jumping)
			{
				//then start jumping
				jumping = true;
				jumpSpeed = jumpSpeedLimit * -1;
				this.y +=  jumpSpeed;
			}
			else
			{
				//then continue jumping if already in the air
				//crazy math that I won't explain
				if (jumpSpeed < 0)
				{
					jumpSpeed *=  1 - jumpSpeedLimit / 85;
					if (jumpSpeed > -jumpSpeedLimit/100)
					{
						jumpSpeed *=  -1;
					}
				}
				if (jumpSpeed > 0 && jumpSpeed <= jumpSpeedLimit)
				{
					jumpSpeed *=  1 + jumpSpeedLimit / 50;
				}
				this.y +=  jumpSpeed;
				//if this hits the floor, then stop jumping
				//of course, we'll change this once we create the level
				if (this.y >= stage.stageHeight - this.height + 30)
				{
					jumping = false;
					this.y = stage.stageHeight - this.height + 30;
				}
			}
		}

		public function shoot():IProjectile
		{
			if(! this.isRotational) {
				return this.weapons[this.weaponIndex].shoot();
			} else if(this.isRotational) {
				return this.weapons[this.weaponIndex].shoot(Math.cos(this.wepAngle*(Math.PI/180)), Math.sin(this.wepAngle*(Math.PI/180)));
			}
			return null;
		}

	}

}