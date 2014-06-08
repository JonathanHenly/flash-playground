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
	 * @author Jonathan Henly
	 */
	public class ParticleContainer extends MovieClip 
	{
		public static const A_ON_A:int = 0; // Asteroid on Asteroid Collision
		public static const P_ON_A:int = 1; // Projectile on Asteroid Collision
		public static const S_ON_A:int = 2; // Ship on Asteroid Collision
		
		private var typeOfCollision:int = 0;
		private var readyToRemove:Boolean = false;
		private var numParticles:int = 0;
		private var particleRotation:Number = 0;
		
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
		
		public function ParticleContainer():void
		{
			this.head = new Particle(0x00000000);
			this.iterator = new Particle(0x000000);
			
			this.numParticles = amount;
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function onAddedToStage(event:Event):void
		{
			//Size of the bitmap:
			this.displayWidth = 800; // parent.width;
			this.displayHeight = 600; // parent.height;
			
			//'bitmap' is the bitmap that we will see, 'bmpData' is its bitmapData into which we will draw particles.
			//'bmpData' supports transparent pixels (true) and intially contains completely transparent black pixels (0x00000000). 
			this.bmpData = new BitmapData(displayWidth,displayHeight,true,0x00000000);
			this.bitmap = new Bitmap(bmpData);
			
			this.addChild(bitmap);
			
			this.blur = new BlurFilter(3,3);
			this.blur.quality = 3;
			// this.colorTrans = new ColorTransform(1, 1, 1, 1, 0, 0, 0, -2);
			this.colorTrans = new ColorTransform(1, 1, 1, 1, 0, 0, 0, -2);
			
			this.origin = new Point(0, 0);
			
			this.addParticles();
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function addParticles():void
		{
			var c:uint;	
			var i:int;
			var r:uint;
			var g:uint;
			var b:uint;
			var a:uint=0xFF;
			
			for (i=0; i<this.numParticles; i++) {
				
				r = 0xFF; // Math.random()*0xFF;
				
				g = 0xFF; // Math.random() * 0xFF;
				
				b = 0xFF; // Math.random()*0x99;
				
				c=((a << 24) | (r << 16) | (g << 8) | b);
				
				var newP:Particle = new Particle(c);
				
				newP.x = Math.floor(Math.random() * 801);
				newP.y = Math.floor(Math.random() * 601);
				
				stage.addChild(newP);
				
				if (i < 1) {
					head.next = newP;
				} else {
					iterator.next = newP;
				}
				
				iterator = newP;
			}
			
			this.readyToUpdate = true;
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
					
					this.bmpData.setPixel32(particle.x, particle.y, particle.color);
					
					if(particle.alpha > 0x00) {
						particle.alpha = particle.alpha - 0x05;
						particle.green = particle.green - 0x05;
						particle.red = particle.red - 0x05;
						
						this.readyToRemove = false;
					} else {
						this.readyToRemove = true;
					}
					
					particle = particle.next;
				}
				
				this.bmpData.unlock();
			}
		}
	}
	
}