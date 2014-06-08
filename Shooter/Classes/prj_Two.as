package 
{

	import flash.display.MovieClip;
	import flash.events.*;

	public class prj_Two extends MovieClip implements IProjectile
	{
		private var xTrag,yTrag,xEnd,yEnd,xScale:int = 0;
		private var remove:Boolean = false;

		public function prj_Two(initX:int, initY:int, xcale:int, xTrig:Number = 0, yTrig:Number = 0)
		{
			this.name = "prj_Two";
			this.x = initX;
			this.y = initY;
			this.xScale = xcale;

			this.xEnd = this.x + 1200;
			this.yEnd = this.y + 400;
			
			this.addEventListener(Event.ADDED_TO_STAGE, stageAddHandler);
		}

		public function stageAddHandler(e:Event):void
		{
			this.xTrag = 15 * this.xScale;
			if(Math.ceil(Math.random() * 1.5) < 2) {
				this.yTrag = -1 * Math.ceil(Math.random()  * 1.5);
			} else {
				this.yTrag = Math.ceil(Math.random() * 1.5);
			}
			this.addEventListener("enterFrame", proj_onEnterFrame);
			removeEventListener(Event.ADDED_TO_STAGE, stageAddHandler);
		}

		public function proj_onEnterFrame(e:Event):void
		{
			if (parent != null)
			{
				this.x += this.xTrag;
				this.y += this.yTrag;
			}
		}

		public function removeProj():void
		{
			this.removeEventListener("enterFrame", proj_onEnterFrame);
			parent.removeChild(this);
		}

	}

}