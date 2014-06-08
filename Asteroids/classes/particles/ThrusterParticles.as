package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.filters.BlurFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Point
	import flash.events.*;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ThrusterParticles extends MovieClip 
	{
		public var recyclingOn:Boolean = false;
		
		private const PARTICLE_LIST_SIZE:int = 500;
		
		private var readyToUpdate:Boolean = false;
		
		// Linking Particles
		private var head:Particle;
		private var iterator:Particle;

		/*
		The display objects that will be created programmatically: a Bitmap 'bitmap' and its bitmapData 'bmpData'.
		*/
		private var bmpData:BitmapData;
		private var bitmap:Bitmap;

		private var displayWidth:Number;
		private var displayHeight:Number;

		//Variables related to filters and transforms that we will apply to 'bmpData' every onParticleTimer
		//to create trailing and fading effects.

		private var origin:Point;
		private var blur:BlurFilter;
		private var colorTrans:ColorTransform;
		
		private const MIN_SPEED:Number = 0.09;
		public var MAX_SPEED:Number = 2;
		
		private const ANGLE_DIFFERENCE:Number = 15;
		
		public function ThrusterParticles(x:int = 0, y:int = 0):void
		{
			this.head = new Particle(0x00000000);
			this.iterator = new Particle(0x000000);
			
			this.x = x;
			this.y = y;
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function onAddedToStage(event:Event):void
		{
			//Size of the bitmap:
			this.displayWidth = 300; // parent.width;
			this.displayHeight = 300; // parent.height;
			
			//'bitmap' is the bitmap that we will see, 'bmpData' is its bitmapData into which we will draw particles.
			//'bmpData' supports transparent pixels (true) and intially contains completely transparent black pixels (0x00000000). 
			this.bmpData = new BitmapData(displayWidth,displayHeight,true,0x00000000);
			this.bitmap = new Bitmap(bmpData);
			
			this.addChild(bitmap);
			
			this.blur = new BlurFilter(3, 3, 1);
			this.blur.quality = 15;
			// this.colorTrans = new ColorTransform(1, 1, 1, 1, 0, 0, 0, -2);
			this.colorTrans = new ColorTransform(1, 1, 1, 1, 0, 0, 0, -2);
			
			this.origin = new Point(0, 0);
			
			this.startParticleList();
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function startParticleList():void
		{
			var c:uint;	
			var i:int;
			var r:uint;
			var g:uint;
			var b:uint;
			var a:uint = 0xFF;
			
			for (i=0; i<PARTICLE_LIST_SIZE; i++) {
				r = 0xFF; // Math.random()*0xFF;
				
				g = 0xFF; // Math.random() * 0xFF;
				
				b = 0xFF; // Math.random()*0x99;
				
				c=((a << 24) | (r << 16) | (g << 8) | b);
				
				var newP:Particle = new Particle(c);
				
				if (i < 1) {
					head.next = newP;
				} else {
					iterator.next = newP;
				}
				
				iterator = newP;
			}
			
			this.readyToUpdate = true;
		}
		
		/* ***********************************************************************
		public function addParticles(amount:int = 0):void
		
		Adds particles to 

		Last modified: August 18, 2010
		************************************************************************ */
		public function addParticles(amount:int = 0):void
		{
			var newCount:int = 0;
			var tmpParticle:Particle = head.next;
			
			while (newCount < amount) {
				if (tmpParticle.recycle) {
					var speed:Number = MIN_SPEED + Math.random() * (MAX_SPEED - MIN_SPEED);
					var spaceshipRotation = Asteroids.pOne.rotation;
					var MAX_ANGLE:Number = (spaceshipRotation + 90) + ANGLE_DIFFERENCE;
					var MIN_ANGLE:Number = (spaceshipRotation + 90) - ANGLE_DIFFERENCE;
					var angle:Number = (MIN_ANGLE + Math.random() * (MAX_ANGLE - MIN_ANGLE))*(Math.PI/180); // 36 * (Math.PI / 180);// (MIN_ANGLE + Math.random() * (MAX_ANGLE - MIN_ANGLE))*(Math.PI/180); // ((2 * Math.random() - 1) * 180) / Math.PI;
					var speedX:Number = Math.cos(angle) * speed;
					var speedY:Number = Math.sin(angle) * speed;
					
					tmpParticle.VX = speedX;
					tmpParticle.VY = speedY;
					
					tmpParticle.alpha = 0xFF;
					tmpParticle.green = 0xFF;
					tmpParticle.red = 0xFF;
					
					tmpParticle.x = Asteroids.pOne.thrusterSpawnPoint.x;
					tmpParticle.y = Asteroids.pOne.thrusterSpawnPoint.y;
					
					tmpParticle.recycle = false;
					
					newCount++;
				} else {
					if (tmpParticle.next == null) {
						break;
					} else {
						tmpParticle = tmpParticle.next;
					}
				}
			}
		}
		
		public function update():void
		{
			if(this.readyToUpdate) {
				var particle:Particle = head.next;
		
				this.bmpData.applyFilter(bmpData,bmpData.rect,origin,blur);
				
				this.bmpData.colorTransform(bmpData.rect, colorTrans);
				
				this.bmpData.lock();
				
				while (particle.next != null) {
					
					particle.color = ((particle.alpha << 24) | (particle.red << 16) | (particle.green << 8) | particle.blue);
					
					particle.x += particle.VX; // * (particle.x);
					particle.y += particle.VY; // * (particle.y);
					
					this.bmpData.setPixel32(particle.x, particle.y, particle.color);
					
					if(particle.alpha > 0x00) {
						particle.alpha = particle.alpha - 0x0F;
						particle.red = particle.red - 0x0F;
						particle.green = particle.green - 0x05;
						particle.blue = particle.blue - 0x00;
					} else {
						particle.recycle = true;
					}
					
					particle = particle.next;
				}
				
				this.bmpData.unlock();
			}
		}
	}
	
}