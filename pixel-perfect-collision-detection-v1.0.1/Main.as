/**
 * Pixel Perfect Collision Detection
 * ---------------------
 * VERSION: 1.0.1
 * DATE: 8/23/2011
 * AS3
 * UPDATES AND DOCUMENTATION AT: http://www.FreeActionScript.com
 **/
package  
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.text.TextField;
	
	import com.freeactionscript.CollisionTest;
	
	/**
	 * Document Class
	 */	
	public class Main extends Sprite
	{
		private var _collisionTest:CollisionTest;
		
		/**
		 * Constructor
		 */
		public function Main() 
		{
			// add listeners
			stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			
			// create an new instance of the CollisionTest class
			_collisionTest = new CollisionTest();
			
			// give shape mouse interactivity
			circleShape.addEventListener(MouseEvent.MOUSE_DOWN, onShapeDownHandler);
			circleShape.addEventListener(MouseEvent.MOUSE_UP, onShapeUpHandler);
			circleShape.buttonMode = true;
			
			// give shape mouse interactivity
			polystarShape.addEventListener(MouseEvent.MOUSE_DOWN, onShapeDownHandler);
			polystarShape.addEventListener(MouseEvent.MOUSE_UP, onShapeUpHandler);
			polystarShape.buttonMode = true;
		}
		
		/**
		 * Function that checks for all possible collisions
		 */
		private function checkForCollisions():void
		{
			// reset all shapes
			resetTint(circleShape)
			resetTint(polystarShape)
			resetTint(plusShape)
			
			// test plusShape vs circleShape
			if (_collisionTest.complex(plusShape, circleShape))
			{
				applyGreenTint(plusShape);
				applyGreenTint(circleShape);
			}
			
			// test plusShape vs polystarShape
			if (_collisionTest.complex(plusShape, polystarShape))
			{
				applyGreenTint(plusShape);
				applyGreenTint(polystarShape);
			}
			
			// test circleShape vs polystarShape
			if (_collisionTest.complex(circleShape, polystarShape))
			{
				applyGreenTint(circleShape);
				applyGreenTint(polystarShape);
			}
			
			// test circleShape vs plusShape
			if (_collisionTest.complex(circleShape, plusShape))
			{
				applyGreenTint(circleShape);
				applyGreenTint(plusShape);
			}
		}
		
		/**
		 * Use this to reset tint on an enemy		 
		 * * @param	clip
		 */
		private function resetTint(clip:DisplayObjectContainer):void
		{
			var colorTint:ColorTransform = clip.transform.colorTransform;
			colorTint.redOffset = 0;
			colorTint.blueOffset = 0;
			colorTint.greenOffset = 0;
			clip.transform.colorTransform = colorTint;
		}
		
		/**
		 * Use this to apply a tint to an enemy
		 * @param	enemy
		 */
		private function applyGreenTint(clip:DisplayObjectContainer):void
		{
			var colorTint:ColorTransform = clip.transform.colorTransform;
			colorTint.redOffset = 0;
			colorTint.blueOffset = 0;
			colorTint.greenOffset = 255;
			clip.transform.colorTransform = colorTint;
		}
		
		//////////////////////////////////////
		// Event Handlers
		//////////////////////////////////////
		
		/**
		 * Enter Frame handler
		 * @param	event	Uses Event
		 */
		private function enterFrameHandler(event:Event):void
		{
			checkForCollisions();
			
			plusShape.rotation += 1;
		}
		
		/**
		 * Shape Mouse Up Handler
		 * @param	e	Takes MouseEvent
		 */
		private function onShapeUpHandler(e:MouseEvent):void 
		{
			// stop drag
			MovieClip(e.target).stopDrag();
		}
		
		/**
		 * Shape Mouse DownHandler
		 * @param	e	Takes MouseEvent
		 */
		private function onShapeDownHandler(e:MouseEvent):void 
		{
			// start drag
			MovieClip(e.target).startDrag();
		}
	}
}