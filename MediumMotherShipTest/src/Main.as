package  
{
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Jonathan Henly
	 */
	public class Main extends MovieClip 
	{
		public var turretCircle:MovieClip = new MovieClip();
		public var turretCircleMask:Shape = new Shape();
		public var turretCircleLines:Shape = new Shape();
		public var turret:MovieClip = new MovieClip();
		public var turretLoader:MovieClip = new MovieClip();
		
		public var turretArray:Array = new Array();
		public var rearRightPort:RearTurretPort = new RearTurretPort();
		public var test:int = 0;
		
		
		
		// Test Variables
		public static var testCountOne:int = 0;
		public var testCountOneMax:int = 20;
		public static var plusMinusCount:int = 0;
		
		public function Main() 
		{
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		public function onAddedToStage(event:Event):void
		{
			
			this.drawGraphics();
			turretArray.push(new MotherShipTurret(400, 400, 0, 0));
			
			this.addChild(turretArray[0]);
			rearRightPort.x = 400;
			rearRightPort.y = 400;
			this.addChild(rearRightPort);
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function onEnterFrame(event:Event):void
		{
			var turretCount:int = 0;
			testCountOne += 1;
			
			turretLoader.x = -27 + plusMinusCount;
			while (turretCount < turretArray.length)
			{
				turretArray[turretCount].update();
				turretCount += 1;
			}
			
			
			
			
			if (testCountOne <= testCountOneMax) {
				if (testCountOne <= testCountOneMax / 2) {
					plusMinusCount += 1;
				} else {
					plusMinusCount -= 1;
				}
			} else {
				testCountOne = 0;
			}
			
			turretCircle.rotation += 1;
			// turretCircleLines.graphics.drawRect( -3, -10, 4, 20);
		}
		
		public function drawGraphics():void
		{
			var SCALE_AMOUNT:int = -3;
			var MOVE_AMOUNT:int = 200;
			
			this.graphics.lineStyle(0.1, 0xFFFFFF);
			this.graphics.beginFill(0x000000, 1);
			this.graphics.moveTo( 30 + MOVE_AMOUNT, -150 + MOVE_AMOUNT);
			this.graphics.lineTo( 60 + MOVE_AMOUNT, -120 + MOVE_AMOUNT);
			this.graphics.lineTo( 60 + MOVE_AMOUNT, -90 + MOVE_AMOUNT);
			this.graphics.lineTo(45 + MOVE_AMOUNT, -90 + MOVE_AMOUNT);
			this.graphics.lineTo(60 + MOVE_AMOUNT, -60 + MOVE_AMOUNT);
			this.graphics.lineTo(45 + MOVE_AMOUNT, -45 + MOVE_AMOUNT);
			this.graphics.lineTo(30 + MOVE_AMOUNT, -45 + MOVE_AMOUNT);
			// New Section
			this.graphics.lineTo(20 + MOVE_AMOUNT, -40 + MOVE_AMOUNT);
			this.graphics.lineTo(20 + MOVE_AMOUNT, -30 + MOVE_AMOUNT);
			this.graphics.lineTo(35 + MOVE_AMOUNT, -30 + MOVE_AMOUNT);
			this.graphics.lineTo(40 + MOVE_AMOUNT, -20 + MOVE_AMOUNT);
			this.graphics.lineTo(40 + MOVE_AMOUNT, 20 + MOVE_AMOUNT);
			this.graphics.lineTo(35 + MOVE_AMOUNT, 30 + MOVE_AMOUNT);
			this.graphics.lineTo(20 + MOVE_AMOUNT, 30 + MOVE_AMOUNT);
			this.graphics.lineTo(20 + MOVE_AMOUNT, 40 + MOVE_AMOUNT);
			// End New Section
			this.graphics.lineTo(30 + MOVE_AMOUNT, 45 + MOVE_AMOUNT)
			this.graphics.lineTo(45 + MOVE_AMOUNT, 45 + MOVE_AMOUNT);
			this.graphics.lineTo(60 + MOVE_AMOUNT, 60 + MOVE_AMOUNT);
			this.graphics.lineTo(60 + MOVE_AMOUNT, 105 + MOVE_AMOUNT);
			this.graphics.lineTo(90 + MOVE_AMOUNT, 135 + MOVE_AMOUNT);
			this.graphics.lineTo(135 + MOVE_AMOUNT, 150 + MOVE_AMOUNT);
			this.graphics.lineTo(150 + MOVE_AMOUNT, 180 + MOVE_AMOUNT);
			this.graphics.lineTo( 120 + MOVE_AMOUNT, 210 + MOVE_AMOUNT);
			this.graphics.lineTo( 120 + MOVE_AMOUNT, 240 + MOVE_AMOUNT);
			this.graphics.lineTo( 30 + MOVE_AMOUNT, 300 + MOVE_AMOUNT);
			// Mirror Bottom Begin
			this.graphics.lineTo( -30 + MOVE_AMOUNT, 300 + MOVE_AMOUNT);
			this.graphics.lineTo(-120 + MOVE_AMOUNT, 240 + MOVE_AMOUNT);
			this.graphics.lineTo(-120+ MOVE_AMOUNT, 210 + MOVE_AMOUNT);
			this.graphics.lineTo(-150 + MOVE_AMOUNT, 180 + MOVE_AMOUNT);
			this.graphics.lineTo(-135 + MOVE_AMOUNT, 150 + MOVE_AMOUNT);
			this.graphics.lineTo(-90 + MOVE_AMOUNT, 135 + MOVE_AMOUNT);
			this.graphics.lineTo(-60 + MOVE_AMOUNT, 105 + MOVE_AMOUNT);
			this.graphics.lineTo(-60 + MOVE_AMOUNT, 60 + MOVE_AMOUNT);
			this.graphics.lineTo(-45 + MOVE_AMOUNT, 45 + MOVE_AMOUNT);
			this.graphics.lineTo( -30 + MOVE_AMOUNT, 45 + MOVE_AMOUNT);
			// New Section
			this.graphics.lineTo( -20 + MOVE_AMOUNT, 40 + MOVE_AMOUNT);
			this.graphics.lineTo( -20 + MOVE_AMOUNT, 30 + MOVE_AMOUNT);
			this.graphics.lineTo( -35 + MOVE_AMOUNT, 30 + MOVE_AMOUNT);
			this.graphics.lineTo( -40 + MOVE_AMOUNT, 20 + MOVE_AMOUNT);
			this.graphics.lineTo( -40 + MOVE_AMOUNT, -20 + MOVE_AMOUNT);
			this.graphics.lineTo( -35 + MOVE_AMOUNT, -30 + MOVE_AMOUNT);
			this.graphics.lineTo(-20 + MOVE_AMOUNT, -30 + MOVE_AMOUNT);
			this.graphics.lineTo(-20 + MOVE_AMOUNT, -40 + MOVE_AMOUNT);
			// End New Section
			this.graphics.lineTo(-30 + MOVE_AMOUNT, -45 + MOVE_AMOUNT);
			this.graphics.lineTo(-45 + MOVE_AMOUNT, -45 + MOVE_AMOUNT);
			this.graphics.lineTo(-60 + MOVE_AMOUNT, -60 + MOVE_AMOUNT);
			this.graphics.lineTo(-45 + MOVE_AMOUNT, -90 + MOVE_AMOUNT);
			this.graphics.lineTo(-60 + MOVE_AMOUNT, -90 + MOVE_AMOUNT);
			this.graphics.lineTo(-60 + MOVE_AMOUNT, -120  + MOVE_AMOUNT);
			this.graphics.lineTo(-30 + MOVE_AMOUNT, -150 + MOVE_AMOUNT);
			this.graphics.lineTo( 30 + MOVE_AMOUNT, -150 + MOVE_AMOUNT);
			this.graphics.endFill();
			
			// Bottom Right New Section
			// this.graphics.beginFill(0xFFFFFF, 0.8);
			this.graphics.moveTo(150 + MOVE_AMOUNT, 180 + MOVE_AMOUNT);
			this.graphics.lineTo(150 + MOVE_AMOUNT, 190 + MOVE_AMOUNT);
			this.graphics.lineTo(128 + MOVE_AMOUNT, 212 + MOVE_AMOUNT);
			this.graphics.lineTo(128 + MOVE_AMOUNT, 235 + MOVE_AMOUNT);
			this.graphics.lineTo(120 + MOVE_AMOUNT, 240 + MOVE_AMOUNT);
			this.graphics.lineTo(120 + MOVE_AMOUNT, 210 + MOVE_AMOUNT);
			this.graphics.lineTo(150 + MOVE_AMOUNT, 180 + MOVE_AMOUNT);
			this.graphics.endFill();
			// End Bottom Right New Section
			
			// Bottom Left New Section
			// this.graphics.beginFill(0xFFFFFF, 0.1);
			this.graphics.moveTo(-150 + MOVE_AMOUNT, 180 + MOVE_AMOUNT);
			this.graphics.lineTo(-150 + MOVE_AMOUNT, 190 + MOVE_AMOUNT);
			this.graphics.lineTo(-128 + MOVE_AMOUNT, 212 + MOVE_AMOUNT);
			this.graphics.lineTo(-128 + MOVE_AMOUNT, 235 + MOVE_AMOUNT);
			this.graphics.lineTo( -120 + MOVE_AMOUNT, 240 + MOVE_AMOUNT);
			this.graphics.lineTo(-120 + MOVE_AMOUNT, 210 + MOVE_AMOUNT);
			this.graphics.lineTo(-150 + MOVE_AMOUNT, 180 + MOVE_AMOUNT);
			this.graphics.endFill();
			// End Bottom Left New Section
			
			// Draw Turret Section
			turretCircle.x = -180 + MOVE_AMOUNT;
			turretCircle.y = 150 + MOVE_AMOUNT;
			turretCircle.graphics.beginFill(0xFFFFFF, 1);
			turretCircle.graphics.lineStyle(0.1, 0xFFFFFF);
			turretCircle.graphics.drawCircle( 0, 0, 10);
			turretCircle.graphics.endFill();
			// turretCircle.graphics.lineTo(0, -10);
			stage.addChild(turretCircle);
			
			turretCircleMask.x = 0;
			turretCircleMask.y = 0;
			turretCircleMask.graphics.beginFill(0x000000, 1);
			turretCircleMask.graphics.drawCircle(0, 0, 10);
			turretCircleMask.graphics.endFill();
			turretCircle.addChild(turretCircleMask);
			
			turretCircleLines.x = 0;
			turretCircleLines.y = 0;
			turretCircleLines.graphics.beginFill(0x000000, 1);
			turretCircleLines.graphics.drawRect(0, -10, 0, 20);
			turretCircleLines.graphics.endFill();
			turretCircleLines.mask = turretCircleMask;
			turretCircle.addChild(turretCircleLines);
			
			
			// Under Base
			turret.graphics.lineStyle(0.1, 0xFFFFFF);
			turret.graphics.drawCircle(-5, 0, 10);
			// Top Base
			turret.graphics.lineStyle(0.1, 0xFFFFFF);
			turret.graphics.beginFill(0x000000, 1);
			turret.graphics.moveTo( -10, -12);
			turret.graphics.lineTo( -0, -12);
			turret.graphics.lineTo( -0, 0);
			turret.graphics.lineTo( -10, 0);
			turret.graphics.lineTo( -10, -12);
			turret.graphics.endFill();
			// Rear Base
			turret.graphics.moveTo( -30, -8);
			turret.graphics.lineTo( -25, -8);
			turret.graphics.lineTo( -25, 8);
			turret.graphics.lineTo( -30, 8);
			turret.graphics.lineTo( -30, -8);
			// Barrel
			turret.graphics.beginFill(0x000000, 1);
			turret.graphics.moveTo( -20, -2);
			turret.graphics.lineTo(20, -2);
			turret.graphics.lineTo(24, -5);
			turret.graphics.lineTo(26, -2);
			turret.graphics.lineTo(26, 2);
			turret.graphics.lineTo(24, 5);
			turret.graphics.lineTo(20, 2);
			turret.graphics.lineTo( -20, 2);
			turret.graphics.lineTo( -20, -2);
			turret.graphics.endFill();
			
			stage.addChild(turret);
			turret.x = 500;
			turret.y  = 400;
			
			// Turret Loader
			turretLoader.graphics.lineStyle(0.1, 0xFFFFFF);
			turretLoader.graphics.beginFill(0x000000, 1);
			turretLoader.graphics.moveTo(0, 0);
			turretLoader.graphics.lineTo(15, 0);
			turretLoader.graphics.lineTo(15, 8);
			turretLoader.graphics.lineTo(0, 8);
			turretLoader.graphics.lineTo(0, 0);
			turretLoader.graphics.endFill();
			
			turret.addChild(turretLoader);
			turretLoader.x = -27;
			turretLoader.y = -4;
		}
		
	}

}