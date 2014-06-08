package 
{
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.*;
	import flash.geom.*; // Used to create rectangle for buttons
	
	/**
	 * ...
	 * @author [Your Name Here]
	 */
	public class Main extends MovieClip
	{
		public var turret:MovieClip = new MovieClip();
		public var lowerTurret:MovieClip = new MovieClip();
		
		public var lowerTurretReticle:Shape = new Shape();
		
		public var target:MovieClip = new MovieClip();
		
		public var bulletA:MovieClip = new MovieClip();
		public var bulletB:MovieClip = new MovieClip();
		
		public var bulletSpawnA:Shape = new Shape();
		public var bulletSpawnB:Shape = new Shape();
		
		private var targetVX:Number = 4;
		private var targetVY:Number = 4;
		
		private var bulletVX:Number = 20;
		private var bulletVY:Number = 20;
		
		private var key_FIRE:Boolean = false;
		private var hasFired:Boolean = false;
		private var bulletMoving:Boolean = false;
		
		
		public function Main():void 
		{
			lowerTurret.graphics.lineStyle(0.1, 0xFFFFFF);
			lowerTurret.graphics.drawCircle(0, 0, 5);
			lowerTurret.x = 300;
			lowerTurret.y = 300;
			
			lowerTurretReticle.graphics.lineStyle(0.1, 0xFFFFFF);
			lowerTurretReticle.graphics.drawRect( -2, -1, 2, 2);
			lowerTurretReticle.graphics.beginFill(0xFF0000, 1);
			lowerTurretReticle.graphics.drawRect(0, -1, 2, 2);
			lowerTurretReticle.graphics.endFill();
			lowerTurretReticle.x = 0;
			lowerTurretReticle.y = 0;
			lowerTurret.addChild(lowerTurretReticle);
			
			turret.graphics.lineStyle(0.1, 0xFFFFFF);
			turret.graphics.drawCircle(0, 0, 5);
			turret.graphics.moveTo(4, 2);
			turret.graphics.lineTo(7, 2);
			turret.graphics.moveTo(4, -2);
			turret.graphics.lineTo(7, -2);
			turret.graphics.endFill();
			turret.x = 300;
			turret.y = 300;
			
			bulletA.graphics.beginFill(0xFFFFFF, 1);
			bulletA.graphics.drawCircle(0, 0, 2);
			bulletA.graphics.endFill();
			
			bulletB.graphics.beginFill(0xFFFFFF, 1);
			bulletB.graphics.drawCircle(0, 0, 2);
			bulletB.graphics.endFill();
			
			bulletSpawnA.graphics.lineStyle(0.1, 0xFFFFFF);
			bulletSpawnA.graphics.drawRect( -0.5, -0.5, 1, 1);
			bulletSpawnA.x = 7;
			bulletSpawnA.y = 2;
			turret.addChild(bulletSpawnA);
			
			bulletSpawnB.graphics.lineStyle(0.1, 0xFFFFFF);
			bulletSpawnB.graphics.drawRect( -0.5, -0.5, 1, 1);
			bulletSpawnB.x = 7;
			bulletSpawnB.y = -2;
			turret.addChild(bulletSpawnB);
			
			target.graphics.lineStyle(0.1, 0xFF8080);
			target.graphics.beginFill(0xFFFF80 , 1);
			target.graphics.drawCircle(0, 0, 3);
			target.graphics.endFill();
			target.x = 400;
			target.y = 300;
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage); // Listener for ADDED_TO_STAGE event
		}
		
		private function onAddedToStage(e:Event = null):void 
		{
			stage.addChild(lowerTurret);
			stage.addChild(turret);
			stage.addChild(target);
			stage.addChild(bulletA);
			stage.addChild(bulletB);
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onKeyDown(e:KeyboardEvent = null):void
		{
			if (e.keyCode == 32) {
				key_FIRE = true;
			}
		}
		
		private function onKeyUp(e:KeyboardEvent = null):void
		{
			if (e.keyCode == 32) {
				key_FIRE = false;
			}
		}
		
		private function onEnterFrame(e:Event = null):void
		{
			var tmpArray:Array = new Array();
			
			if (target.x > 600) {
				targetVX *= -1;
			} else if (target.x < 100) {
				targetVX *= -1;
			}
			
			if ( target.y > 500) {
				targetVY *= -1;
			} else if (target.y < 100) {
				targetVY *= -1;
			}
			
			target.x += targetVX;
			target.y += targetVY;
			
			tmpArray = this.intersection(turret.x, turret.y, target.x, target.y, targetVX, targetVY, 10);
			trace(bulletA.x, bulletB.x, bulletA.y, bulletB.y);
			
			var turTarDX:Number = tmpArray[0] - turret.x;
			var turTarDY:Number = tmpArray[1] - turret.y;
			var turTarAngle:Number = Math.atan2(turTarDY, turTarDX);
			
			var turRetTarDX:Number = target.x - lowerTurret.x;
			var turRetTarDY:Number = target.y - lowerTurret.y;
			var turRetTarAngle:Number = Math.atan2(turRetTarDY, turRetTarDX);
			
			turret.rotation = turTarAngle * (180 / Math.PI);
			lowerTurret.rotation = turRetTarAngle * (180 / Math.PI);
			
			if (key_FIRE && !hasFired) {
				hasFired = true;
				bulletMoving = true;
				
				bulletVX = 10 * Math.cos(turTarAngle);
				bulletVY = 10 * Math.sin(turTarAngle);
			} else if (hasFired) {
				if (bulletA.x > 800 || bulletA.x < 0) {
					hasFired = false;
					bulletMoving = false;
				}
				if (bulletA.y > 700 || bulletA.y < 0) {
					hasFired = false;
					bulletMoving = false;
				}
			}
			
			if (bulletMoving) {
				bulletA.x += bulletVX;
				bulletA.y += bulletVY;
				
				bulletB.x += bulletVX;
				bulletB.y += bulletVY;
			} else {
				var bulletASpawn:Point = turret.localToGlobal(new Point(bulletSpawnA.x, bulletSpawnA.y));
				bulletA.x = bulletASpawn.x;
				bulletA.y = bulletASpawn.y;
				
				var bulletBSpawn:Point = turret.localToGlobal(new Point(bulletSpawnB.x, bulletSpawnB.y));
				bulletB.x = bulletBSpawn.x;
				bulletB.y = bulletBSpawn.y;
			}
		}
		
		public function intersection(srcX:Number, srcY:Number, dstX:Number, dstY:Number, dstVX:Number, dstVY:Number, projSpeed:Number):Array
		{
			var tx:Number = dstX - srcX;
			var ty:Number = dstY - srcY;
			var tvx:Number = dstVX;
			var tvy:Number = dstVY;
			
			// Get quadratic equation components
			var a:Number = tvx*tvx + tvy*tvy - projSpeed * projSpeed;
			var b:Number = 2 * (tvx * tx + tvy * ty);
			var c:Number = tx * tx + ty * ty;
			
			// Solve quadratic
			var ts:Array = this.quad(a, b, c); // See quad(), below
			
			var sol:Array = [0, 0];
			if (ts != null) {
				var t0:Number = ts[0];
				var t1:Number = ts[1];
				var t:Number = Math.min(t0, t1);
				
				if (t < 0) {
					t = Math.max(t0, t1);    
				}
			
				if (t > 0) {
					sol = [dstX + dstVX * t, dstY + dstVY * t];
				}
			}
			
			return sol;

		}
		
		/**
		 * Return solutions for quadratic
		 */
		private function quad(a:Number, b:Number, c:Number):Array {
			var sol:Array = [0, 0];
			
			if (Math.abs(a) < 1e-6) {
				if (Math.abs(b) < 1e-6) {
					sol = Math.abs(c) < 1e-6 ? [0, 0] : [0, 0];
				} else {
					sol = [ -c / b, -c / b];
				}
			} else {
				var disc:Number = b*b - 4*a*c;
					
				if (disc >= 0) {
					disc = Math.sqrt(disc);
					a = 2*a;
					sol = [( -b - disc) / a, ( -b + disc) / a];
				}
			}
		
			return sol;
		}
		
	}
}