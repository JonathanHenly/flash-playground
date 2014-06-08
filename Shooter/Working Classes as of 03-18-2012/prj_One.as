package 
{

	import flash.display.MovieClip;
	import flash.events.*;

	public class prj_One extends MovieClip
	{
		private var xVel,yVel,xEnd,yEnd,xScale:int = 0;
		private var remove:Boolean = false;

		public function prj_One(initX:int, initY:int, xcale:int)
		{
			this.x = initX;
			this.y = initY;
			this.xScale = xcale;

			this.xVel = 30;
			this.yVel = 0;

			if (this.xScale < 0)
			{
				this.xVel *=  -1;
			}

			this.xEnd = this.x + 1000;
			this.yEnd = this.y + 1000;
			addEventListener(Event.ADDED_TO_STAGE, stageAddHandler);
		}

		private function stageAddHandler(e:Event):void
		{
			this.addEventListener("enterFrame", proj_onEnterFrame);
			removeEventListener(Event.ADDED_TO_STAGE, stageAddHandler);
		}

		private function proj_onEnterFrame(e:Event)
		{
			if (parent != null)
			{
				if (this.x >= this.xEnd || this.x <= -(this.xEnd))
				{
					this.removeProj();
				}

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