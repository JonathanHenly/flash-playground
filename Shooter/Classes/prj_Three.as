package 
{

	import flash.display.MovieClip;
	import flash.events.*;

	public class prj_Three extends MovieClip implements IProjectile
	{
		private var xVel,yVel,xEnd,yEnd,xScale:int = 0;
		private var remove:Boolean = false;

		public function prj_Three(initX:int, initY:int, xcale:int, xTrig:Number = 0, yTrig:Number = 0)
		{
			
			this.name = "prj_Three";
			this.x = initX;
			this.y = initY;
			this.xScale = xcale;

			trace(xcale);
			this.xVel = xTrig * 20;
			this.yVel = yTrig * 20;
			
			if(this.xScale == -1) {
				this.xVel *= -1;
			}
			
			this.xEnd = this.x + 1200;
			this.yEnd = this.y + 1000;
			addEventListener(Event.ADDED_TO_STAGE, stageAddHandler);
		}

		public function stageAddHandler(e:Event):void
		{
			this.addEventListener("enterFrame", proj_onEnterFrame);
			removeEventListener(Event.ADDED_TO_STAGE, stageAddHandler);
		}

		public function proj_onEnterFrame(e:Event):void
		{
			if (parent != null)
			{
				this.x +=  xVel;
				this.y +=  yVel;
			}
		}

		public function removeProj():void
		{
			this.removeEventListener("enterFrame", proj_onEnterFrame);
			parent.removeChild(this);
		}
	}
}