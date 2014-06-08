package {
	
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.*;
	import flash.geom.Point;

	/**
	 * @author Jonathan Henly
	 */
	public class Spaceship extends MovieClip {
		public var thrusterSpawn:Shape = new Shape();
		public var secondThrusterSpawn:Shape = new Shape();
		public var thirdThrusterSpawn:Shape = new Shape();
		public var thrusterSpawnPoint:Point = null;
		
		public var rotationSpeed:uint = 3;
		private const PROJECTILE_SPEED:int = 4;
		private const X_SIZE:int = 3;
		private const Y_SIZE:int = 10;
		private const X_HITBOX:int = 1;
		private const Y_HITBOX:int = 2;
		
		public var spaceshipModels:SpaceshipModels = null;
		public var modelNumber:uint = 3;
		private var spaceshipModelNumber:uint = 3;
		private var vX:Number = 0;
		private var vY:Number = 0;
		
		public var hitBox:Shape = new Shape();
		
		public var globalPoint:Point = null;
		public var globalX:Number = 0;
		public var globalY:Number = 0;
		
		public function Spaceship() {
			this.hitBox.visible = false;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function onAddedToStage(event:Event):void
		{
			this.x = Constants.STAGE_WIDTH / 2;
			this.y = Constants.STAGE_HEIGHT / 2;
			
			this.globalPoint = Asteroids.mainStage.globalToLocal(new Point(this.x, this.y));
			this.globalX = globalPoint.x;
			this.globalY = globalPoint.y;
			
			spaceshipModels = new SpaceshipModels();
			spaceshipModels.initialize();
			this.determineModel();
			
			hitBox.graphics.beginFill(0x3354df, 1.0);
			hitBox.graphics.moveTo(-X_HITBOX, Y_HITBOX);
			hitBox.graphics.lineTo(X_HITBOX, Y_HITBOX);
			hitBox.graphics.lineTo(X_HITBOX, -Y_HITBOX);
			hitBox.graphics.lineTo(-X_HITBOX, -Y_HITBOX);
			hitBox.graphics.lineTo(-X_HITBOX, Y_HITBOX);
			hitBox.graphics.endFill();
			this.addChild(hitBox);
			
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function update():void
		{
			this.globalPoint = Asteroids.mainStage.globalToLocal(new Point(this.x, this.y));
			this.globalX = globalPoint.x;
			this.globalY = globalPoint.y;
			Asteroids.mainStage.setVX(this.vX);
			Asteroids.mainStage.setVY(this.vY);
		}
		
		public function rotateLeft():void
		{
			this.rotation -= rotationSpeed;
		}
		
		public function rotateRight():void
		{
			this.rotation += rotationSpeed;
		}
		
		public function increaseVelocity():void
		{
			if (Math.sqrt((this.vX * this.vX) + (this.vY * this.vY)) < 10) {
				var radians:Number = this.rotation * Math.PI/180;
				this.vX += 0.1 * Math.sin(radians);
				this.vY += 0.1 * -Math.cos(radians);
			}
		}
		
		public function decreaseVelocity():void
		{
			if (Math.abs(this.vX) > 0.01 || Math.abs(this.vY) > 0.01) {
				this.vX = this.vX / 1.1;
				this.vY = this.vY / 1.1;
			} else {
				this.vX = 0;
				this.vY = 0;
			}
		}
		
		public function fireProjectile():Projectile
		{
			var radians:Number = this.rotation * Math.PI / 180;
			var vx:Number = PROJECTILE_SPEED * Math.sin(radians);
			var vy:Number = PROJECTILE_SPEED * -Math.cos(radians);
			
			return new Projectile(this.x, this.y, vx, vy);
		}
		
		public function determineModel():void
		{
			this.graphics.clear();
				
			this.graphics.copyFrom(spaceshipModels.getModel(spaceshipModelNumber));
				
			thrusterSpawn.graphics.beginFill(0xFFFFFF, 1);
			thrusterSpawn.graphics.drawRect(0, 0, 1, 1);
			thrusterSpawn.graphics.endFill();
			
			secondThrusterSpawn.graphics.beginFill(0xFFFFFF, 1);
			secondThrusterSpawn.graphics.drawRect(0, 0, 1, 1);
			secondThrusterSpawn.graphics.endFill();
			
			thrusterSpawn.x = -3;
			thrusterSpawn.y = 5;
			
			secondThrusterSpawn.x = 2;
			secondThrusterSpawn.y = 5;
			
			this.addChild(thrusterSpawn);
			this.addChild(secondThrusterSpawn);
		}
		
		public function refreshModel(newModelNumber:int):void
		{
			this.graphics.clear();
			this.graphics.copyFrom(spaceshipModels.getModel(newModelNumber));
		}
		
	}
	
}
