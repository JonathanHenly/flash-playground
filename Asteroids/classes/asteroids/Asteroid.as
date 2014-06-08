package {
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.*;
	import flash.filters.GlowFilter;

	/**
	 * @author Jonathan Henly
	 */
	public class Asteroid extends MovieClip implements IAsteroid {
		private var rotationSpeed:Number = 0.0;
		public const WHITE:uint = 0xFFFFFF;
		public var isDestroyed:Boolean = false;
		public var isColliding:Boolean = false;
		public var collisionOccured:Boolean = false;
		public var hitBox:Shape = new Shape();
		public var vX:Number = 0.0;
		public var vY:Number = 0.0;
		public var destroyed:Boolean = false;
		public var ableToRemove:Boolean = false;
		public var health:int;
		public var hasSpawned:Boolean = false;
		
		public var closeToPlayer:Boolean = false;
		public var applyGlowOnce:Boolean = false;
		public var asteroidGlow:GlowFilter = null;
		
		/*
		 * BEGIN ORBIT VARIABLES
		 */
		public var hasEnteredOrbit:Boolean = false;
		public var attachedShipX:Number = 0.0;
		public var attachedShipY:Number = 0.0;
		
		private var distanceToAttachedShipX:Number = 0.0;
		private var distanceToAttachedShipY:Number = 0.0;
		private var angleBetweenAttachedShip:Number = 0.0;
		/*
		 * END ORBIT VARIABLES
		 */
		
		public function Asteroid(x:int, y:int) {
			this.hitBox.visible = false;
			this.rotationSpeed = Math.ceil(100 * (2 * Math.random() - 1))/100; 
			this.x = x; // Math.ceil(Math.random() * 550) + 10;
			this.y = y; // Math.ceil(Math.random() * 400) + 10;
			
			this.asteroidGlow = new GlowFilter(0x95BDFF, 1, 3, 3, 5, 3, true, false);
			
			if((Math.ceil(Math.random() * 3)) > 1) {
				vX = Math.ceil(Math.random() * 100)/100;
			} else {
				vX = (Math.ceil(Math.random() * 100)/100) * -1;
			}
			
			if((Math.ceil(Math.random() * 3)) > 1) {
				vY = Math.ceil(Math.random() * 100)/100;
			} else {
				vY = (Math.ceil(Math.random() * 100)/100) * -1;
			}
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		protected function onAddedToStage(event:Event):void
		{
			this.createAsteroid();
			this.createHitBox();
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function createAsteroid():void
		{
		
		}
		
		public function createHitBox():void
		{
			
		}
		
		public function updateAsteroid():void
		{
			if (hasEnteredOrbit) {
				
				Asteroids.mainStage.graphics.lineStyle(0.1, 0xFFFFFF);
				Asteroids.mainStage.graphics.moveTo(this.x, this.y);
				Asteroids.mainStage.graphics.lineTo(attachedShipX, attachedShipY);
				
				this.angleBetweenAttachedShip += 0.03 * Math.PI / 180.0; // one degree
				
				if (this.angleBetweenAttachedShip > Math.PI) {
					this.angleBetweenAttachedShip -= 2.0 * Math.PI;
				}
				
				var cosAngle:Number = Math.cos(this.angleBetweenAttachedShip);
				var sinAngle:Number = Math.sin(this.angleBetweenAttachedShip);
				
				this.x = (attachedShipX + cosAngle * this.distanceToAttachedShipX + sinAngle * this.distanceToAttachedShipY);
				this.y = (attachedShipY - sinAngle * this.distanceToAttachedShipX + cosAngle * this.distanceToAttachedShipY);
				
			} else {
				this.rotation += this.rotationSpeed;
				this.x += vX;
				this.y += vY;
			}
			
			if (closeToPlayer && !applyGlowOnce) {
				this.filters = [asteroidGlow];
				this.applyGlowOnce = true;
			} else if (!closeToPlayer && applyGlowOnce) {
				this.filters = [];
				
				this.applyGlowOnce = false;
			}
		}
		
		public function modifyHealth():void
		{
			
		}
		
		public function splitAsteroid():Array
		{
			
			return null;
		}
		
		public function removeAsteroid():void
		{
			// this.hitBox = null;
			
			if(this != null) {
				parent.removeChild(this);
			}
		}
		
		public function enterOrbit(shipX:Number = 0, shipY:Number = 0):void
		{
			if(!this.hasEnteredOrbit) {
				this.attachedShipX = shipX;
				this.attachedShipY = shipY;
				
				this.distanceToAttachedShipX = shipX - this.x;
				this.distanceToAttachedShipY = shipY - this.y;
				
				this.angleBetweenAttachedShip = Math.PI; // radians relative to fixed point
				
				this.hasEnteredOrbit = true;
			}
		}
		
		public function updateOrbit(newShipX:Number = 0, newShipY:Number = 0):void
		{
			if(!this.hasEnteredOrbit) {
				this.attachedShipX = newShipX;
				this.attachedShipY = newShipY;
				
				this.distanceToAttachedShipX = newShipX - this.x;
				this.distanceToAttachedShipY = newShipY - this.y;
				
				this.angleBetweenAttachedShip = Math.PI; // radians relative to fixed point
				
				this.hasEnteredOrbit = true;
			}
		}
		
		public function exitOrbit():void
		{
			this.hasEnteredOrbit = false;
		}
		
	}
	
}
