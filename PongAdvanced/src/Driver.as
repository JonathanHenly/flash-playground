package 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip
	import flash.display.Stage;
	import flash.text.Font;
	import flash.events.*;
	
	/**
	 * ...
	 * @author Jonathan Henly
	 */
	public class Driver extends MovieClip 
	{	
		public static const COMPUTER_SCORE:int = 0;
		public static const HUMAN_SCORE:int = 1;
		
		public static var startScreen:StartingScreen;
		public static var mainDisplay:MainDisplay;
		public static var ball:Ball;
		public static var paddleHum:Paddle;
		public static var paddleComp:Paddle;
		
		public static var startScreenUpdate:Boolean = true;
		public static var mainDisplayUpdate:Boolean = false;
		public static var ballUpdate:Boolean = false;
		public static var paddleHumUpdate:Boolean = false;
		public static var paddleCompUpdate:Boolean = false;
		
		public static var readyToStart:Boolean = false;
		
		private var particleArray:Array;
		private var thrusterParticle:ParticleContainer;
		
		private var W:Boolean = false;
		private var UP:Boolean = false;
		private var A:Boolean = false;
		private var S:Boolean = false;
		private var DOWN:Boolean = false;
		private var D:Boolean = false;
		private var SPACE:Boolean = false;
		
		private var firstRun:Boolean = true;
		
		private var paddleHumHit:Boolean = false;
		private var paddleCompHit:Boolean = false;
		
		public function Driver():void 
		{
			startScreen = new StartingScreen();
			mainDisplay = new MainDisplay();
			ball = new Ball();
			paddleHum = new Paddle();
			paddleComp = new Paddle();
			particleArray = new Array();
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			[Embed(source="../fonts/Capture_it.ttf", 
                fontName = "myFont", 
                mimeType = "application/x-font", 
                fontWeight="normal", 
                fontStyle="normal", 
                unicodeRange="U+0020-U+007E", 
                advancedAntiAliasing="false", 
                embedAsCFF = "false")]
			var capture_it:Class;
			
			this.initiateListeners();
			this.addChildren();
		}
		
		private function initiateListeners():void
		{
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		private function addChildren():void
		{
			stage.addChild(startScreen);
			Utils.centerChild(stage, startScreen, Utils.CENTERED);
			stage.addChild(mainDisplay);
			mainDisplay.visible = false;
			Utils.centerChild(stage, mainDisplay, Utils.CENTERED);
			stage.addChild(paddleHum);
			paddleHum.visible = false;
			paddleHum.x = (stage.stageWidth - 50);
			Utils.centerChild(stage, paddleHum, Utils.VERTICAL);
			stage.addChild(paddleComp);
			paddleComp.visible = false;
			paddleComp.x = 50;
			Utils.centerChild(stage, paddleComp, Utils.VERTICAL);
			stage.addChild(ball);
			ball.visible = false;
		}
		
		private function onEnterFrame(event:Event):void
		{
			this.updateClasses();
			this.checkForKeys();
			
			for (var i:int = 0; i < particleArray.length; i++) {
				particleArray[i].update();
			}
		}
		
		private function runGame():void
		{
			if (firstRun) {
				ball.visible = true;
				Utils.centerChild(stage, ball, Utils.CENTERED);
				
				paddleComp.visible = true;
				paddleHum.visible = true;
				
				Utils.fixIndex(ball, stage);
				Utils..fixIndex(paddleComp, stage);
				Utils..fixIndex(paddleHum, stage);
				ballUpdate = true;
				paddleCompUpdate = true;
				paddleHumUpdate = true;
				
				firstRun = false;
			}
			
			if (ball.y < 20 || ball.y > 580) {
				ball.invertVY();
			}
			
			if (ball.x > (paddleHum.x + 20)) {
				updateScore(Driver.COMPUTER_SCORE);
			} else if (ball.x < (paddleComp.x - 20)) {
				updateScore(Driver.HUMAN_SCORE);
			}
							
			if (paddleHum.hitTestObject(ball)) {
				paddleHumHit = true;
			} else {
				paddleHumHit = false;
			}
			
			if (paddleComp.hitTestObject(ball)) {
				paddleCompHit = true;
			} else {
				paddleCompHit = false;
			}
			
			if (paddleHumHit) {
				thrusterParticle = new ParticleContainer( paddleHum.x, paddleHum.y, 100, 0);
				stage.addChild(thrusterParticle);
				particleArray.push(thrusterParticle);
				ball.updateVelocity(paddleHum.momentum);
				ball.invertVX();
			}
			
			if (paddleCompHit) {
				thrusterParticle = new ParticleContainer( paddleComp.x, paddleHum.y, 100, 0);
				stage.addChild(thrusterParticle);
				particleArray.push(thrusterParticle);
				ball.updateVelocity(paddleComp.momentum);
				ball.invertVX();
			}
			
		}
		
		private function updateClasses():void
		{
			if (startScreenUpdate) {
				startScreen.update();
			} else if (mainDisplayUpdate) {
				mainDisplay.update();
			}
			
			if (ballUpdate) {
				ball.update();
			}
			
			if (paddleHumUpdate) {
				paddleHum.update();
			}
			
			if (paddleCompUpdate) {
				paddleComp.update();
			}
			
			if (Driver.readyToStart) {
				this.runGame();
			}
		}
		
		private function onKeyDown(event:KeyboardEvent):void
		{
			if (event.keyCode == 87 || event.keyCode == 38) {
				W = true;
			}
			if (event.keyCode == 65 || event.keyCode == 37) {
				A = true;
			}
			if (event.keyCode == 83 || event.keyCode == 40) {
				S = true;
			}
			if (event.keyCode == 68 || event.keyCode == 39) {
				D = true;
			}
			if (event.keyCode == 32) {
				SPACE = true;
			}
		}
		
		private function onKeyUp(event:KeyboardEvent):void
		{
			if (event.keyCode == 87 || event.keyCode == 38) {
				W = false;
			}
			if (event.keyCode == 65 || event.keyCode == 37) {
				A = false;
			}
			if (event.keyCode == 83 || event.keyCode == 40) {
				S = false;
			}
			if (event.keyCode == 68 || event.keyCode == 39) {
				D = false;
			}
			if (event.keyCode == 32) {
				SPACE = false;
			}
		}
		
		private function checkForKeys():void
		{
			if(ballUpdate) {
				if (W) {
					paddleHum.moveUp();
					paddleComp.moveUp();
				}
				if (A) {
					ball.moveBall();
				}
				if (S) {
					paddleHum.moveDown();
					paddleComp.moveDown();
				}
				if (D) {
					
				}
			}
			if (SPACE) {
				if (startScreenUpdate) {
					startGame();
				}
			}
		}
		
		private function startGame():void
		{
			startScreen.closeScreen();
			startScreenUpdate = false;
			mainDisplayUpdate = true;
			mainDisplay.visible = true;
		}
		
		private function resetBall():void
		{
			Utils.centerChild(stage, ball, Utils.CENTERED);
		}
		
		private function updateScore(which:int):void
		{
			if (which) {
				mainDisplay.increaseComputerScore();
			} else {
				mainDisplay.increaseHumanScore();
			}
			
			resetBall();
		}
		
	}
	
}