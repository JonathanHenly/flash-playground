package 
{

	// import flash.display.MovieClip;
	import flash.events.*;

	public interface IProjectile
	{
		/*************************************************
		 * PRIVATE CLASS VARIABLES
		 *************************************************
		 * private var xVel,yVel,xEnd,yEnd,xScale:int = 0;
		 * private var remove:Boolean = false;
		**/
		
		/*************************************************
		 * CONSTRUCTOR
		 *************************************************
		 * public *(initX:int, initY:int, xcale:int)
		**/
		
		/*************************************************
		 * PUBLIC METHODS
		 ************************************************/
		/*************************************************
		 * function stageAddHandler(e:event);
		 *
		 * Event to listen for a projectile added to the
		 * stage.
		*************************************************/
		function stageAddHandler(e:Event):void;
		/*************************************************
		 * function proj_onEnterFrame(e:event);
		 *
		 * Event to update the projectile every frame.
		*************************************************/
		function proj_onEnterFrame(e:Event):void;
		/*************************************************
		 * function removeProj():void;
		 *
		 * Method to remove a projectil from the stage.
		*************************************************/
		function removeProj():void;

	}

}