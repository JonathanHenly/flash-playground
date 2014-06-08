package 
{

	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.*;


	public class InitPlayer extends MovieClip
	{
		private var weapons:Array;
		private var health:int;
		private var weaponIndex:int;
		private var rightArrow,leftArrow,downArrow,upArrow,space,jumping,crouched:Boolean = false;

		//how quickly should the jump start off
		var jumpSpeedLimit:int = 15;
		//the current speed of the jump;
		var jumpSpeed:Number = jumpSpeedLimit;

		// Constructor
		public function InitPlayer()
		{
			weapons = this.generateWeapons();
			this.x = 100;
			this.y = 300;
			this.weaponIndex = 0;
			this.health = 1000;

			attachWeapon(1, 22, 0);

			addEventListener(Event.ADDED_TO_STAGE, stageAddHandler);
		}

		// Handlers
		private function stageAddHandler(e:Event):void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, stage_onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, stage_onKeyUp);
			stage.addEventListener(Event.ENTER_FRAME, stage_onEnterFrame);
			removeEventListener(Event.ADDED_TO_STAGE, stageAddHandler);
		}

		// Methods
		public function attachWeapon(index:int, xpos:int, ypos:int):void
		{
			this.weaponIndex = index;
			var tempWeap:Weapon = weapons[index];
			addChild(tempWeap.getWepClip());
			addChild(tempWeap);
			tempWeap.getWepClip().x = xpos;
			tempWeap.getWepClip().y = ypos;
		}

		public function generateWeapons():Array
		{
			var temp:Array = new Array();
			var tempWeap:Weapon;

			var AR:AR_One = new AR_One();
			var B1:prj_One = new prj_One(0,0,0);
			var WB:wep_Boxing = new wep_Boxing();

			// Format is as follows -
			// (clip:MovieClip, newBullet:MovieClip, damage:int, newDelay:int, projX:int, projY:int)
			tempWeap = new Weapon(null,null,0,0,0,0);
			tempWeap.name = "Unarmed";
			temp.push(tempWeap);

			tempWeap = new Weapon(AR,B1,10,10,50,-6);
			tempWeap.name = "AR_One";
			temp.push(tempWeap);

			tempWeap = new Weapon(WB,null,5,0,0,0);
			tempWeap.name = "wep_Boxing";
			temp.push(tempWeap);

			return temp;
		}

		private function stage_onKeyDown(event:KeyboardEvent):void
		{
			// trace(event.keyCode);
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

			/*if (event.keyCode == 32) {
			
			}*/
		}

		private function stage_onKeyUp(event:KeyboardEvent):void
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
		}

		private function stage_onEnterFrame(event:Event):void
		{
			if (rightArrow)
			{
				this.x +=  2.5;
				this.scaleX = 1;
				this.animatePlayer();
			}
			if (leftArrow)
			{
				this.x -=  2.5;
				this.scaleX = -1;
				this.animatePlayer();
			}
			if (downArrow)
			{
				this.crouch();
			}
			if (upArrow && !jumping && !downArrow)
			{
				jump();
			}
			if (jumping)
			{
				jump();
			}
			if (space)
			{
				this.shoot();
			}
		}

		private function animatePlayer():void
		{
			if (leftArrow || rightArrow)
			{
				if (this.currentFrame == 1)
				{
					this.gotoAndPlay(2);
				}
			}
		}

		private function crouch():void
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

		private function jump():void
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
					jumpSpeed *=  1 - jumpSpeedLimit / 75;
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

		public function shoot():Boolean
		{
			this.weapons[this.weaponIndex].shoot();
			return true;
		}

	}

}