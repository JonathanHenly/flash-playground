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
	public class ParticleContainer extends EMovieClip 
	{
		private const MAX_PARTICLES:int = 0;
		private var readyToRemove:Boolean = false;
		
		private var readyToUpdate:Boolean = false;
		
		// Linking Particles
		private var head:Particle;
		private var iterator:Particle;
		
		private var startX:int = 400;
		private var startY:int = 0;
		
		private var particleCount:int = 0;
		
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
			super();
			
			this.head = new Particle(0x00000000);
			this.iterator = new Particle(0x000000);
		}
		
		override protected function onAddedToStage(e:Event):void
		{
			super.onAddedToStage(e);
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
			
			iterator = head;
		}
		
		public function addParticles():void
		{
			if (particleCount <= MAX_PARTICLES) {
				var c:uint;	
				var i:int;
				var r:uint;
				var g:uint;
				var b:uint;
				var a:uint=0xFF;

				r = 0xFF; // Math.random()*0xFF;
				g = 0xFF; // Math.random() * 0xFF;
				b = 0xFF; // Math.random()*0x99;
				
				c=((a << 24) | (r << 16) | (g << 8) | b);
				
				var newP:Particle = new Particle(c);
				
				newP.x = startX;
				newP.y = startY;
				
				iterator.next = newP;
				
				iterator = newP;
				
				particleCount++;
				
				this.readyToUpdate = true;
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
					
					this.bmpData.setPixel32(particle.x, particle.y, particle.color);
					
					if (particle.y < 558) {
						particle.y += 1;
					}
					
					particle = particle.next;
				}
				
				this.bmpData.unlock();
			}
		}
	}
	
}