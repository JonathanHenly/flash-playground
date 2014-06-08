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
	public class BrickExplosion extends MovieClip 
	{
		private static const OFFSET:int = 1;
		private var AMOUNT:int = 0;
		
		private var recycleCount:uint = 0;
		public var recycle:Boolean = false;
		
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
		
		private var color:uint = 0x000000;
		
		private var readyToUpdate:Boolean = false;
		
		public function BrickExplosion(newColor:uint = 0xFFFFFF):void
		{
			this.color = newColor;
			
			// trace("R: " + ((this.color >> 16) & 0xFF).toString(16) + " G: " + ((this.color >> 8) & 0xFF).toString(16) + " B: " + (this.color & 0xFF).toString(16));
			
			this.head = new Particle(0x00000000);
			this.iterator = new Particle(0x000000);
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			//Size of the bitmap:
			this.displayWidth = 200; // parent.width;
			this.displayHeight = 200; // parent.height;
			
			AMOUNT = ((displayWidth - 180) / OFFSET) * ((displayHeight - 180) / OFFSET);
			
			//'bitmap' is the bitmap that we will see, 'bmpData' is its bitmapData into which we will draw particles.
			//'bmpData' supports transparent pixels (true) and intially contains completely transparent black pixels (0x00000000). 
			this.bmpData = new BitmapData(displayWidth,displayHeight,true,0x00000000);
			this.bitmap = new Bitmap(bmpData);
			
			this.addChild(bitmap);
			
			this.blur = new BlurFilter(1, 1, 3);
			this.blur.quality = 3;
			// this.colorTrans = new ColorTransform(1, 1, 1, 1, 0, 0, 0, -2);
			this.colorTrans = new ColorTransform(1, 1, 1, 1, 0, 0, 0, -2);
			
			this.origin = new Point(0, 0);
			
			this.startParticleList(AMOUNT);
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function startParticleList(amount:int = 0):void
		{
			var c:uint;	
			var i:int;
			var r:uint;
			var g:uint;
			var b:uint;
			var a:uint = 0xFF;
			
			// Debug
			/*
			for (i = 0; i < 2; i++) {
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
			*/
			
			for (i = 0; i < AMOUNT; i++) {
				r = ((this.color >> 16) & 0xFF); // 0x00; // Math.random() * 0xFF;
				
				g = ((this.color >> 8) & 0xFF); // 0x00; // Math.random() * 0xFF; // Math.random() * 0xFF;
				
				b = (this.color & 0xFF); // 0xFF; // Math.random() * 0xFF;
				
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
			
			this.addParticles(amount);
		}
		
		public function addParticles(amount:int = 0):void
		{
			var newCount:int = 0;
			var tmpParticle:Particle = head.next;
			
			var rowCount:int = 0;
			var colCount:int = 0;
			
			var origColCount:int = displayWidth / 2 - 10; 
			
			colCount = origColCount;
			rowCount += displayHeight / 2 - 10;
			
			while (newCount < amount) {
				if (tmpParticle.recycle) {
					colCount += OFFSET;
					
					// tmpParticle.alpha = 0xFF;
					// tmpParticle.green = 0xFF;
					// tmpParticle.red = 0xFF;
					
					// Debug
					/*
					tmpParticle.x = 400;
					tmpParticle.y = 300;
					
					tmpParticle.origX = 400;
					tmpParticle.origY = 300;
					*/
					
					tmpParticle.x = colCount;
					tmpParticle.y = rowCount;
					
					if ((colCount % (origColCount + OFFSET*Math.sqrt(amount)) == 0) && colCount != 0) {
						rowCount += OFFSET;
						colCount = origColCount;
					}
					
					tmpParticle.recycle = false;
					
					tmpParticle.origX = colCount;
					tmpParticle.origY = rowCount;
					
					tmpParticle.VX = randomNumber(-2, 1);
					tmpParticle.VY = randomNumber(-2, 1);
					
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
		
		private function randomNumber(low:Number = 0, high:Number = 1):Number
		{
			return (1 - Math.random() * 2);
		}
		
		public function update():void
		{
			if(recycleCount < 111) {
				if (this.readyToUpdate) {
					recycleCount += 1;
					var particle:Particle;
					
					if (head.next != null && head.next.recycle) {
						if (head.next.next != null) {
							head.next = head.next.next;
							particle = head.next;
						} else if (head.next.next == null) {
						}
					} else if (head.next != null && !head.next.recycle) {
						particle = head.next;
					}
			
					this.bmpData.applyFilter(bmpData,bmpData.rect,origin,blur);
					
					this.bmpData.colorTransform(bmpData.rect, colorTrans);
					
					this.bmpData.lock();
					
					while (particle.next != null) {
						particle.color = ((particle.alpha << 24) | (particle.red << 16) | (particle.green << 8) | particle.blue);
						
						this.bmpData.setPixel32(particle.x, particle.y, particle.color);
						
						if (particle.red < 255) {
							particle.red += scaleColor(particle.red);
						}
						
						if (particle.blue < 255) {
							particle.blue += scaleColor(particle.blue);
						}
						
						if (particle.green < 255) {
							particle.green += scaleColor(particle.green);
						}
						
						if (particle.red >= 255 && particle.green >= 255 && particle.blue >= 255) {
							particle.x += particle.VX * 1.2;
							particle.y += particle.VY * 1.2;
							
							if (particle.alpha > 10) {
								particle.alpha -= 8;
							}
							
							if (particle.alpha <= 10) {
								particle.recycle = true;
							}
						}
						
						particle = particle.next;
					}
					
					this.bmpData.unlock();
				}
			} else {
				recycle = true;
			}
		}
		
		private function scaleColor(color:Number):Number
		{
			return 255 - color / (255);
		}
		
	}
	
}