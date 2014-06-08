package  
{
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Jonathan Henly
	 */
	public class Main extends MovieClip
	{
		public static var spaceship:MovieClip = new MovieClip();
		public static var thrusterSpawns:Shape = new Shape();
		public static var secondThrusterSpawns:Shape = new Shape();
		public static var thrusterSpawnPoint:Point = null;
		
		private var oneFour:int = 0;
		private var background:Shape = new Shape();
		private var thrusterParticle:ThrusterParticles;
		private var UP_KEY:Boolean = false;
		private var RIGHT_KEY:Boolean = false;
		private var LEFT_KEY:Boolean = false;
		
		private var count:int = 0;
		
		public function Main() 
		{
			background.graphics.beginFill(0x000000, 1);
			background.graphics.drawRect(0, 0, 550, 400);
			background.graphics.endFill();
			this.addChild(background);
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function onAddedToStage(event:Event):void
		{
			this.drawGraphics();
			spaceship.x = 275;
			spaceship.y = 200;
			this.thrusterParticle = new ThrusterParticles(0, 0, 1000);
			this.addChild(thrusterParticle);
			
			thrusterSpawnPoint = spaceship.localToGlobal(new Point(thrusterSpawns.x + thrusterSpawns.width/2, thrusterSpawns.y + thrusterSpawns.height));
			
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function onEnterFrame(event:Event):void
		{
			this.oneFour += 1;
			
			// spaceship.rotation += 1;
			if (UP_KEY) {
				count++;
				this.thrusterParticle.recyclingOn = true;
				
				if (this.RIGHT_KEY || this.LEFT_KEY) {
					if (this.RIGHT_KEY && !this.LEFT_KEY) {
						if (this.oneFour % 4 == 0) {
							thrusterSpawnPoint = spaceship.localToGlobal(new Point(secondThrusterSpawns.x + secondThrusterSpawns.width/2, secondThrusterSpawns.y + secondThrusterSpawns.height+2));
						} else {
							thrusterSpawnPoint = spaceship.localToGlobal(new Point(thrusterSpawns.x + thrusterSpawns.width/2, thrusterSpawns.y + thrusterSpawns.height+2));
						}
					} else if(this.LEFT_KEY && !this.RIGHT_KEY) {
						if (this.oneFour % 4 == 0) {
							thrusterSpawnPoint = spaceship.localToGlobal(new Point(thrusterSpawns.x + thrusterSpawns.width/2, thrusterSpawns.y + thrusterSpawns.height+2));
						} else {
							thrusterSpawnPoint = spaceship.localToGlobal(new Point(secondThrusterSpawns.x + secondThrusterSpawns.width/2, secondThrusterSpawns.y + secondThrusterSpawns.height+2));
						}
					}
				} else {
					if (this.oneFour % 2 == 0) {
						thrusterSpawnPoint = spaceship.localToGlobal(new Point(thrusterSpawns.x + thrusterSpawns.width/2, thrusterSpawns.y + thrusterSpawns.height+2));
					} else {
						thrusterSpawnPoint = spaceship.localToGlobal(new Point(secondThrusterSpawns.x + secondThrusterSpawns.width/2, secondThrusterSpawns.y + secondThrusterSpawns.height+2));
					}
				}
				
				this.thrusterParticle.addParticles(10);
				
				if (count < 10) {
					
				} else {
					if(this.thrusterParticle.MAX_SPEED < 2.1) {
						this.thrusterParticle.MAX_SPEED += 1;
					}
					count = 0;
				}
			} else {
				this.thrusterParticle.recyclingOn = false;
			}
			
			if (RIGHT_KEY) {
				this.thrusterParticle.recyclingOn = true;
				if (RIGHT_KEY && UP_KEY) {
					spaceship.rotation += 3;
				} else {
					spaceship.rotation += 1;
					
					thrusterSpawnPoint = spaceship.localToGlobal(
					new Point(thrusterSpawns.x + thrusterSpawns.width / 2,
							  thrusterSpawns.y + thrusterSpawns.height + 2));
					
					this.thrusterParticle.addParticles(1);
				}
			} else {
				this.thrusterParticle.recyclingOn = false;
			}
			
			if (LEFT_KEY) {
				this.thrusterParticle.recyclingOn = true;
				if (LEFT_KEY && UP_KEY) {
					spaceship.rotation -= 3;
				} else {
					spaceship.rotation -= 1;
					
					thrusterSpawnPoint = spaceship.localToGlobal(
					new Point(secondThrusterSpawns.x + secondThrusterSpawns.width / 2,
							  secondThrusterSpawns.y + secondThrusterSpawns.height + 2));
					
					this.thrusterParticle.addParticles(1);
				}
			} else {
				this.thrusterParticle.recyclingOn = false;
			}
			
			this.thrusterParticle.update();
			
			if (this.oneFour > 4) {
				this.oneFour = 1;
			}
		}
		
		public function onKeyDown(event:KeyboardEvent):void
		{
			if (event.keyCode == 38) {
				UP_KEY = true;
			}
			
			if (event.keyCode == 37) {
				RIGHT_KEY = true;
			}
			
			if (event.keyCode == 39) {
				LEFT_KEY = true;
			}
		}
		
		public function onKeyUp(event:KeyboardEvent):void
		{
			if (event.keyCode == 38) {
				UP_KEY = false;
			}
			
			if (event.keyCode == 37) {
				RIGHT_KEY = false;
			}
			
			if (event.keyCode == 39) {
				LEFT_KEY = false;
			}
		}
		
		public function drawGraphics():void
		{
			spaceship.graphics.lineStyle(0.1, 0xFFFFFF);
			spaceship.graphics.beginFill(0x000000, 1);
			spaceship.graphics.moveTo(0, -3);
			spaceship.graphics.lineTo(3, 3);
			spaceship.graphics.lineTo( -3, 3);
			spaceship.graphics.lineTo(0, -3);
			spaceship.graphics.endFill();
			
			thrusterSpawns.graphics.beginFill(0xFFFFFF, 1);
			thrusterSpawns.graphics.drawRect(0, 0, 1, 1);
			thrusterSpawns.graphics.endFill();
			
			secondThrusterSpawns.graphics.beginFill(0xFFFFFF, 1);
			secondThrusterSpawns.graphics.drawRect(0, 0, 1, 1);
			secondThrusterSpawns.graphics.endFill();
			
			thrusterSpawns.x = -3;
			thrusterSpawns.y = 5;
			
			secondThrusterSpawns.x = 3;
			secondThrusterSpawns.y = 5;
			
			spaceship.addChild(thrusterSpawns);
			spaceship.addChild(secondThrusterSpawns);
			
			stage.addChild(spaceship);
		}
		
	}

}