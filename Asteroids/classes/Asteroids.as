package {
	
	import flash.utils.Timer;
	import flash.events.*;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.geom.Rectangle;
	import flash.display.Stage;
	import flash.geom.Point;
	import ships.MediumMotherShip;
	
	public class Asteroids extends MovieClip {
		public static var mainStage:MainStage;
		public static var miniMap:MiniMap;
		
		private static var s:Stage;
		
		private var keyPress:KeyPress;
		private var ableToFire:Boolean = true;
		private var mainGameTimer:Timer;
		private var shootTimer:Timer;
		private var timeTillNextShot:uint = 0;
		private var shootBar:Shape = new Shape();
		
		private var shopButton:ShopButton = new ShopButton();
		
		private static var mainGamePause:Boolean = false;
		
		public var newAsteroids:Boolean = true;
		public var nextWave:Boolean = false;
		
		public static var pOne:Spaceship;
		public var thrusterParticles:ThrusterParticles = null;
		public var oneFour:uint = 0;
		private var closeToShip:Boolean = false;
		public var projectileArray:Array;
		private var removeProjArray:Array = new Array();
		
		public var mediumMotherShip:MediumMotherShip = new MediumMotherShip();
		
		public var asteroidArray:Array;
		private var tmpAddAsteroid:Array = new Array(); // Array used to add asteroids after collision testing
		public var asteroidSpawns:Array = new Array();
		private var removeAstArray:Array = new Array();
		
		public static var updateArray:Array = new Array(); // Array for anything that needs updating
		
		/*
		 * BEGIN ASTEROID ORBIT VARIABLES
		 */
		public var ableToActivateOrbit:Boolean = false;
		/*
		 * END ASTEROID ORBIT VARIABLES
		 */
		public function Asteroids():void
		{
			
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function onAddedToStage(event:Event):void
		{
			s = stage;
			
			
			// Initialize and Add mainStage to Stage
			mainStage = new MainStage();
			mainStage.x = -5000;
			mainStage.y = -5000;
			stage.addChild(mainStage);
			
			mediumMotherShip.x = 5000 - mediumMotherShip.width / 2;
			mediumMotherShip.y = 5000 - mediumMotherShip.height / 2;
			mainStage.addChild(mediumMotherShip);
			// Initialize and Add miniMap to Stage
			miniMap = new MiniMap();
			miniMap.x = 440;
			miniMap.y = 290;
			stage.addChild(miniMap);
			
			this.keyPress = new KeyPress();
			stage.addChild(keyPress);
			
			this.mainGameTimer = new Timer(0);
			
			this.shootTimer = new Timer(1, 30);
			stage.addChild(this.shootBar);
			
			pOne = new Spaceship();
			thrusterParticles = new ThrusterParticles(125, 50);
			this.projectileArray = new Array();
			
			this.asteroidArray = new Array();
			
			
			this.mainGameTimer.addEventListener(TimerEvent.TIMER, mainGameLoop);
			this.shootTimer.addEventListener(TimerEvent.TIMER, shootTimerHandler);
			this.shootTimer.addEventListener(TimerEvent.TIMER_COMPLETE, shootTimerFinishHandler);
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			stage.addChild(thrusterParticles);
			stage.addChild(pOne);
			miniMap.addPlayerToMiniMap();
			miniMap.addItemToMiniMap(mediumMotherShip);
			
			this.mainGameTimer.start();
			
			this.createShopButton();
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function mainGameLoop(event:TimerEvent):void
		{
			if(!mainGamePause) {
				mainStage.graphics.clear();
				// Handle Asteroid Spawns
				if(newAsteroids) {
					for (var asteroidCount:uint = 0; asteroidCount < Constants.MAX_ASTEROIDS; asteroidCount++) {
						var unableToSpawn:Boolean = false;
						var tmpX:int = (4000 + (Math.ceil(Math.random() * (6000 - 4000))));
						var tmpY:int = (4000 + (Math.ceil(Math.random() * (6000 - 4000))));
						
						// Make Sure Asteroids don't Spawn on Top of Each Other
						if(asteroidCount > 0) {
							for (var spawnCount:uint = 0; spawnCount < asteroidCount*2; spawnCount+=2) {
								if ((tmpX > this.asteroidSpawns[spawnCount] - 20) && (tmpX < this.asteroidSpawns[spawnCount] + 20)) {
									if ((tmpY > this.asteroidSpawns[spawnCount + 1] - 20) && (tmpY < this.asteroidSpawns[spawnCount + 1] + 20)) {
										unableToSpawn = true;
										spawnCount = asteroidCount * 2;
										asteroidCount--;
									}
								}
							}
						}
						
						if (!unableToSpawn) {
							var tmpAsteroid:Asteroid = new LargeAsteroid(tmpX, tmpY);
							this.asteroidArray.push(tmpAsteroid);
							
							mainStage.addChild(tmpAsteroid); // Add Asteroid to Scrollable Stage
							
							miniMap.addItemToMiniMap(tmpAsteroid); // Add Asteroid to miniMap
							
							this.asteroidSpawns.push(tmpX);
							this.asteroidSpawns.push(tmpY);
						}
					}
					
					newAsteroids = false;
				}
				
				// Update Player One
				pOne.update();
				thrusterParticles.update();
				miniMap.update();
				mainStage.update();
				
				// Asteroid on Asteroid Collision and Update and Player Proximity
				if (this.asteroidArray.length > 0) {
					for(var aCount:int = 0; aCount < this.asteroidArray.length; aCount++) {
						var shipDX:Number = asteroidArray[aCount].x - pOne.globalX; // X distance between current asteroid and player
						var shipDY:Number = asteroidArray[aCount].y - pOne.globalY; // Y distance between current asteroid and player
						var shipDistance:Number = Math.sqrt(shipDX * shipDX + shipDY * shipDY); // Distance between current asteroid and player
						
						checkPlayerAsteroidProximity(shipDistance, aCount);
						
						this.asteroidArray[aCount].updateAsteroid();
						
						// Handle asteroid health based removal
						if (this.asteroidArray[aCount].isDestroyed && !this.asteroidArray[aCount].ableToRemove) {
							
							tmpAddAsteroid = this.asteroidArray[aCount].splitAsteroid(); // Split Destroyed Asteroid into Smaller Asteroids
							this.asteroidArray[aCount].ableToRemove = true;
							this.removeAstArray.push(aCount); // Remove Asteroid After Destruction
							
						} else { // If Asteroid is Destroyed Skip Almost All Collision Testing
							
							// Check for collision between Asteroid and Player based on bounding box of player one
							if(this.asteroidArray[aCount].hitTestObject(pOne.hitBox))
							{
								// Check for collision between Asteroid and Player based on pixels
								var intersection:Rectangle = CollisionDetection.check(this.asteroidArray[aCount], pOne, 255);
								if (intersection == null) {
									
								} else {
									// PAUSE GAME
									// mainGamePause = true;
								}
							}
							
							// Check for collision between Asteroids
							for (var aCountSub:int = 0; aCountSub < this.asteroidArray.length; aCountSub++) {
								if(aCountSub != aCount && !this.asteroidArray[aCount].isDestroyed && !this.asteroidArray[aCountSub].isDestroyed) {
									var dx:Number = asteroidArray[aCount].x - asteroidArray[aCountSub].x;
									var dy:Number = asteroidArray[aCount].y - asteroidArray[aCountSub].y;
									var asteroidDistance:int = Math.sqrt(dx * dx + dy * dy);
									
									if(Math.abs(asteroidDistance) <= 50) {
										if (asteroidArray[aCount].hitTestObject(asteroidArray[aCountSub])) {
											var asteroidIntersection:Rectangle = CollisionDetection.check(this.asteroidArray[aCount], this.asteroidArray[aCountSub], 255);
											if (asteroidIntersection == null) {
												if (this.asteroidArray[aCount].isColliding) {
													this.asteroidArray[aCount].isColliding = false;
												}
											} else {
												if(!this.asteroidArray[aCount].isColliding) {
													// Particle Effects on Collision if Close to Player One
													if (closeToShip) {
														updateArray.push(stage.addChild(
														new ParticleContainer(asteroidIntersection.x - 50, asteroidIntersection.y - 50, 100, ParticleContainer.A_ON_A)
														));
													}
													var tmpVX:Number = asteroidArray[aCount].vX;
													var tmpVY:Number = asteroidArray[aCount].vY;
													
													
													asteroidArray[aCount].vX = asteroidArray[aCountSub].vX;
													asteroidArray[aCount].vY = asteroidArray[aCountSub].vY;
													
													asteroidArray[aCountSub].vX = tmpVX;
													asteroidArray[aCountSub].vY = tmpVY;
												}
												this.asteroidArray[aCount].isColliding = true;
											}
										}
									}
								}
							}
						}
					}
					// Add New Ateroids to Asteroid Array if an Asteroid has Been Destroyed
					if (tmpAddAsteroid.length > 0) {
						this.addMoreAsteroids();
					}
					
				}
				
				// Projectile Update and Decay
				if(this.projectileArray.length > 0) {					
					this.projectileUpdate(); // Updates Each Projectile in Projectile Array
				}
				

				// Projectile and Asteroid Collisions
				if(this.projectileArray.length > 0) {
					if(this.asteroidArray.length > 0) {
						this.checkProjAstCollision(); // Checks for Projectile and Asteroid Collision
					}
					
					// Remove Collided and Decayed Projectiles
					if(removeProjArray.length > 0) {
						this.removeProjectile(); // Remove Projectile(s) from Stage and Projectile Array
					}
				}
				
				
				// Remove Dead Asteroids
				if(removeAstArray.length > 0) {
					this.removeAsteroid(); // Remove Asteroid(s) from Stage and Asteroid Array
				}
				
			}
		}
		
		private function checkPlayerAsteroidProximity(distance:Number, asteroidIndex:int):void
		{
			if (distance > 300) {
				closeToShip = false;
			} else {
				closeToShip = true;
				if (distance < 50 && this.ableToActivateOrbit) {
					asteroidArray[asteroidIndex].enterOrbit(mediumMotherShip.x, mediumMotherShip.y);
				} else if (distance < 50) {
					asteroidArray[asteroidIndex].closeToPlayer = true;
				} else {
					asteroidArray[asteroidIndex].closeToPlayer = false;
				}
			}
		}
		
		private function checkAstAstCollision():void
		{
			
		}
		
		private function addMoreAsteroids():void
		{
			for (var addAsteroidCount:int = 0; addAsteroidCount < tmpAddAsteroid.length; addAsteroidCount++) {
				this.asteroidArray.push(tmpAddAsteroid[addAsteroidCount]);
				mainStage.addChild(tmpAddAsteroid[addAsteroidCount]);
			}
			this.tmpAddAsteroid = [];
		}
		
		private function projectileUpdate():void
		{
			for (var i:int = 0; i < this.projectileArray.length; i++) {
				this.projectileArray[i].update();
				if (this.projectileArray[i].time > 1000) {
					this.projectileArray[i].isActive = false;
					removeProjArray.push(i);
					this.projectileArray[i].removeProjectile();
				}
			}
		}
		
		private function checkProjAstCollision():void
		{
			for(var projCount:int = 0; projCount < projectileArray.length; projCount++) {
				var collision:Boolean = false;
				var hitNum:Array = new Array();
				
				if(projectileArray[projCount].isActive) {
					for (var astCount:int = 0; astCount < asteroidArray.length; astCount++) {
						if(!this.asteroidArray[astCount].isDestroyed) {
							if(this.projectileArray[projCount].hitTestObject(this.asteroidArray[astCount].hitBox)) {
								hitNum.push(astCount);
								collision = true;
								
								this.projectileArray[projCount].isActive = false;
								this.removeProjArray.push(projCount);
								this.projectileArray[projCount].removeProjectile();
							}
						}
					}
				}
				if (collision) {
					for (var hitNumIter:int = 0; hitNumIter < hitNum.length; hitNumIter++) {
						this.asteroidArray[hitNum[hitNumIter]].health -= 1;
						this.asteroidArray[hitNum[hitNumIter]].modifyHealth();
					}
				}
			}
		}
		
		private function removeProjectile():void
		{
			for(var j:int = 0; j < removeProjArray.length; j++) {
				this.projectileArray.splice(removeProjArray[j], 1);
			}
			this.removeProjArray = [];
		}
		
		private function removeAsteroid():void
		{
			for (var astRemoveCount:int = 0; astRemoveCount < removeAstArray.length; astRemoveCount++) {
 				this.asteroidArray[this.removeAstArray[astRemoveCount]].removeAsteroid();
				miniMap.removeItemFromMiniMap(this.asteroidArray[this.removeAstArray[astRemoveCount]]);
				this.asteroidArray.splice(this.removeAstArray[astRemoveCount], 1);
			}
			this.removeAstArray = [];
		}
				
		public function onEnterFrame(event:Event):void
		{
			if (!mainGamePause) {
				this.oneFour += 1;
				
				if (KeyPress.leftArrow) {
					if (!KeyPress.upArrow) {
						pOne.rotationSpeed = 1;
					} else {
						pOne.rotationSpeed = 3;
					}
					pOne.rotateLeft();
					pOne.thrusterSpawnPoint = thrusterParticles.globalToLocal(pOne.localToGlobal(
											 new Point(pOne.secondThrusterSpawn.x + pOne.secondThrusterSpawn.width / 2,
													   pOne.secondThrusterSpawn.y + pOne.secondThrusterSpawn.height + 2)));
					thrusterParticles.addParticles(2);
				}
				
				if (KeyPress.rightArrow) {
					if(!KeyPress.upArrow) {
						pOne.rotationSpeed = 1;
					} else {
						pOne.rotationSpeed = 3;
					}
					pOne.rotateRight();
					pOne.thrusterSpawnPoint = thrusterParticles.globalToLocal(pOne.localToGlobal(
											 new Point(pOne.thrusterSpawn.x + pOne.thrusterSpawn.width / 2,
													   pOne.thrusterSpawn.y + pOne.thrusterSpawn.height + 2)));
					thrusterParticles.addParticles(1);
				}
				
				if (KeyPress.upArrow) {
					pOne.increaseVelocity();
					thrusterParticles.recyclingOn = true;
					
					if(KeyPress.leftArrow || KeyPress.rightArrow) {
						
						if (KeyPress.rightArrow && !KeyPress.leftArrow) {
							if (this.oneFour % 4 == 0) {
								pOne.thrusterSpawnPoint = thrusterParticles.globalToLocal(pOne.localToGlobal(
											 new Point(pOne.secondThrusterSpawn.x + pOne.secondThrusterSpawn.width / 2,
													   pOne.secondThrusterSpawn.y + pOne.secondThrusterSpawn.height + 2)));
							} else {
								pOne.thrusterSpawnPoint = thrusterParticles.globalToLocal(pOne.localToGlobal(
											 new Point(pOne.thrusterSpawn.x + pOne.thrusterSpawn.width / 2,
													   pOne.thrusterSpawn.y + pOne.thrusterSpawn.height + 2)));
							}
						} else if (KeyPress.leftArrow && !KeyPress.rightArrow) {
							if (this.oneFour % 4 == 0) {
								pOne.thrusterSpawnPoint = thrusterParticles.globalToLocal(pOne.localToGlobal(
											 new Point(pOne.thrusterSpawn.x + pOne.thrusterSpawn.width / 2,
													   pOne.thrusterSpawn.y + pOne.thrusterSpawn.height + 2)));
							} else {
								pOne.thrusterSpawnPoint = thrusterParticles.globalToLocal(pOne.localToGlobal(
											 new Point(pOne.secondThrusterSpawn.x + pOne.secondThrusterSpawn.width / 2,
													   pOne.secondThrusterSpawn.y + pOne.secondThrusterSpawn.height + 2)));
							}
						}
					
					} else {
						if (oneFour % 2 == 0) {
							pOne.thrusterSpawnPoint = thrusterParticles.globalToLocal(pOne.localToGlobal(
												 new Point(pOne.thrusterSpawn.x + pOne.thrusterSpawn.width / 2,
														   pOne.thrusterSpawn.y + pOne.thrusterSpawn.height + 2)));
						} else {
							pOne.thrusterSpawnPoint = thrusterParticles.globalToLocal(pOne.localToGlobal(
												 new Point(pOne.secondThrusterSpawn.x + pOne.secondThrusterSpawn.width / 2,
														   pOne.secondThrusterSpawn.y + pOne.secondThrusterSpawn.height + 2)));

						}
					}
					
					
					thrusterParticles.addParticles(20);
				}
				
				if (KeyPress.downArrow) {
					pOne.decreaseVelocity();
				}
				
				if (KeyPress.spacebar) {
					if(ableToFire) {
						this.projectileArray.push(stage.addChild(pOne.fireProjectile()));
						ableToFire = false;
						timeTillNextShot = 0;
						this.shootBar.graphics.clear();
						this.shootTimer.start();
					}
				}
				
				if(KeyPress.a) {
					// Get Stats on FPS and Memory Usage
					stage.addChild(new BasicInfo());
				}
				
				if (KeyPress.d) {
					this.ableToActivateOrbit = true;
				}
				
				if (KeyPress.s) {
					this.ableToActivateOrbit = false;
					// Asteroids.showAll();
				}
				
				if(KeyPress.w) {
					pOne.refreshModel(3);
				}
				
				if (this.oneFour > 4) {
					this.oneFour = 1;
				}
				
				this.updateUpdateArray();
			}
		}
		
		public function updateUpdateArray():void
		{
			var shiftAmount:int = 0;
			
			for (var x:int = 0; x < updateArray.length; x++) {
				if (updateArray[x].update()) {
					shiftAmount += 1;
				}
			}
			
			for (var y:int = 0; y < shiftAmount; y++) {
				updateArray.shift();
			}
		}
		
		public function shootTimerHandler(e:TimerEvent):void
		{
			timeTillNextShot += 2;
			this.shootBar.graphics.beginFill(0xFFFFFF, 1);
			this.shootBar.graphics.moveTo(30, 390);
			this.shootBar.graphics.lineTo(30 + timeTillNextShot, 390);
			this.shootBar.graphics.lineTo(30 + timeTillNextShot, 385);
			this.shootBar.graphics.lineTo(30, 385);
			this.shootBar.graphics.lineTo(30, 390);
			this.shootBar.graphics.endFill();
		}
		
		public function shootTimerFinishHandler(e:TimerEvent):void
		{
			ableToFire = true;
			this.shootTimer.stop();
			this.shootTimer.reset();
		}
		
		public function createShopButton():void
		{
			this.shopButton.x = 525;
			this.shopButton.y = 25;
			stage.addChild(this.shopButton);
		}
		
		public static function pauseGame():void
		{
			mainGamePause = true;
		}
		
		public static function unPauseGame():void
		{
			mainGamePause = false;
		}
		
		public static function hideAll():void
		{
			for(var x:int = 0; x < s.numChildren; x++) {
				s.getChildAt(x).visible = false;
			}
		}
		
		public static function showAll():void
		{
			for(var y:int = 0; y < s.numChildren; y++) {
				s.getChildAt(y).visible = true;
			}
		}
	}
	
}