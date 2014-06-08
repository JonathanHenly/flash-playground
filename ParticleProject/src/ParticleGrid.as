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
	public class ParticleGrid extends MovieClip 
	{
		private var oldBDist:Number =  0;
		
		private static const OFFSET:int = 200;
		private static const AMOUNT:int = (800 / OFFSET) * (600 / OFFSET); // 19200:5 , 4800:10
		
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
		
		private var readyToUpdate:Boolean = false;
		
		public function ParticleGrid():void
		{
			this.head = new Particle(0x00000000);
			this.iterator = new Particle(0x000000);
			
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
			
			this.blur = new BlurFilter(2, 2, 3);
			this.blur.quality = 1;
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
			var a:uint = 0x00;
			
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
			
			for (i=0; i<AMOUNT; i++) {
				r = Math.random()* 0xFF; // 0xFF;
				
				g = Math.random() * 0x00; // 0xFF;
				
				b = Math.random()* 0x00; // 0xFF;
				
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
			
			this.addParticles();
		}
		
		public function addParticles(amount:int = AMOUNT):void
		{
			var newCount:int = 0;
			var tmpParticle:Particle = head.next;
			
			var rowCount:int = 0;
			var colCount:int = 0;
			
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
					
					if ((colCount % 800 == 0 || colCount % 801 == 0 || colCount % 802 == 0) && colCount != 0) {
						rowCount += OFFSET;
						colCount = 0;
					}
					
					tmpParticle.recycle = false;
					
					tmpParticle.origX = colCount;
					tmpParticle.origY = rowCount;
					
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
					var origDist:Number = getOrigDistance(particle);
					var pDX:Number = (particle.origX - particle.x);
					var pDY:Number = (particle.origY - particle.y);
					
					if (origDist > 0) {
						if(origDist > 1) {
							particle.x += pDX * 0.9;//easing: inching coefficient
							particle.y += pDY * 0.9;
						} else {
							particle.x = particle.origX;
							particle.y = particle.origY;
						}
					}
					
					var closest:Number = this.getBallDistance(Driver.ballArray[0], particle);
					var index:int = 0;
					for (var x:int = 1; x < Driver.ballArray.length; x++) {
						var newDist:Number = this.getBallDistance(Driver.ballArray[x], particle);
						if (newDist < closest) {
							closest = newDist;
							index = x;
						}
					}
					
					this.repulsion(Driver.ballArray[index], particle);
					this.messWithBallColor(Driver.ballArray[index], particle);
					
					/*
					if (this.getPaddleDistance(Driver.paddle, particle) < 50) {
						this.paddleRepulsion(Driver.paddle, particle);
						this.messWithPaddleColor(Driver.paddle, particle);
					}
					*/
					
					particle.color = ((particle.alpha << 24) | (particle.red << 16) | (particle.green << 8) | particle.blue);
					
					this.bmpData.setPixel32(particle.x, particle.y, particle.color);
					
					particle = particle.next;
				}
				
				this.bmpData.unlock();
			}
		}
		
		private function messWithBallColor(b:PongBall, p:Particle):void
		{
			var bDist:Number = getBallDistance(b, p);
			var magnitude:Number = 100;
			var alphaScaled:Number = 0;
			
			p.red = 255;
			p.blue = 0;
			p.green = 0;
			
			if (bDist == 0) {
				bDist = 0.0001;
			}
			
			magnitude = Math.pow(magnitude, 1/(bDist/20));
			
			if(magnitude > 800) {
				magnitude = 800;
			}
			
			var ballVelocity:Number = Math.sqrt((b.VX * b.VX) + (b.VY * b.VY));
			
			if((p.alpha + this.scaleColor(magnitude) * ballVelocity/5) < 255) {
				p.alpha += this.scaleColor(magnitude * ballVelocity/5);
			}
			
			if (magnitude < 50 && (p.alpha - 10 > 0)) {
				p.alpha -= 10;
			} else if (magnitude < 50) {
				p.alpha = 0;
			}
			
			if (p.alpha < 0x22) {
				p.alpha = 0;
			}
			// p.green = this.scaleColor(magnitude);
			// p.blue = this.scaleColor(magnitude / 2);
		}
		
		private function messWithPaddleColor(pd:Paddle, p:Particle):void
		{
			var pDist:Number = getPaddleDistance(pd, p);
			var magnitude:Number = 100;
			var alphaScaled:Number = 0;
			
			p.green = 200;
			p.red = 200;
			p.blue = 255;
			
			if (pDist == 0) {
				pDist = 0.0001;
			}
			
			magnitude = Math.pow(magnitude, 1/(pDist/20)) * Driver.paddle.VX;
			
			if(magnitude > 800) {
				magnitude = 800;
			}
			
			if((p.alpha + this.scaleColor(magnitude)) < 255) {
				p.alpha += this.scaleColor(magnitude);
			}
			
			if (magnitude < 50 && (p.alpha - 10 > 0)) {
				p.alpha -= 10;
			} else if (magnitude < 50) {
				p.alpha = 0;
				p.blue = 0;
				p.red = 255;
			}
			
			if (p.alpha < 0x22) {
				p.alpha = 0;
			}
			// p.green = this.scaleColor(magnitude);
			// p.blue = this.scaleColor(magnitude / 2);
		}
		
		private function repulsion(b:PongBall, p:Particle):Boolean
		{
			var angle:Number = this.getAngle(b, p);
			var oppAngle:Number = angle - Math.PI / 180;
			var bDist:Number = getBallDistance(b, p);
			var magnitude:Number = 2;
			
			if (bDist == 0) {
				bDist = 0.0001;
			} 
			
			magnitude = Math.pow(magnitude, 1 / (bDist / 30)) + 3;
			
			magnitude *= 5;
			
			if (magnitude > 10) {
				magnitude = 10;
			}
			
			var oppAngleX:Number = Math.cos(oppAngle);
			var oppAngleY:Number = Math.sin(oppAngle);
			
			p.x += oppAngleX * magnitude;
			p.y += oppAngleY * magnitude;
			
			return true;
		}
		
		private function paddleRepulsion(pd:Paddle, p:Particle):Boolean
		{
			var angle:Number = this.getPaddleAngle(pd, p);
			var oppAngle:Number = angle - Math.PI / 180;
			var bDist:Number = getPaddleDistance(pd, p);
			var magnitude:Number = 2;
			
			if (bDist == 0) {
				bDist = 0.0001;
			} 
			
			magnitude = Math.pow(magnitude, 1 / (bDist / 30)) + 3;
			
			magnitude *= 5;
			
			if (magnitude > 10) {
				magnitude = 10;
			}
			
			var oppAngleX:Number = Math.cos(oppAngle);
			var oppAngleY:Number = Math.sin(oppAngle);
			
			p.x += oppAngleX * magnitude;
			p.y += oppAngleY * magnitude;
			
			return true;
		}
		
		private function getOrigDistance(p:Particle):Number
		{
			var dx:Number = p.origX - p.x;
			var dy:Number = p.origY - p.y;
			var dist:Number = Math.sqrt(dx * dx + dy * dy);
			
			return dist;
		}
		
		private function getBallDistance(ball:PongBall, p:Particle):Number
		{
			var dx:Number = ball.x - p.x;
			var dy:Number = ball.y - p.y;
			var dist:Number = Math.sqrt(dx * dx + dy * dy);
			
			return dist;
		}
		
		private function getPaddleDistance(pd:Paddle, p:Particle):Number
		{
			var dx:Number = (pd.x + pd.width/2) - p.x;
			var dy:Number = (pd.y + pd.height/2) - p.y;
			var dist:Number = Math.sqrt(dx * dx + dy * dy);
			
			return dist;
		}
		
		private function getAngle(ball:PongBall, p:Particle):Number
		{
			var pDX:Number = p.x - ball.x;
			var pDY:Number = p.y - ball.y;
			return Math.atan2(pDY, pDX);
		}
		
		private function getPaddleAngle(pd:Paddle, p:Particle):Number
		{
			var pDX:Number = p.x - pd.x;
			var pDY:Number = p.y - pd.y;
			return Math.atan2(pDY, pDX);
		}
		
		private function scaleColor(value:Number):Number
		{
			return (255) * (value) / (800);
		}
		
	}
	
}