package 
{

	import flash.display.MovieClip;
	import flash.events.*;


	public class Death_Knight extends MovieClip
	{
		private var player:Object;

		public function Death_Knight()
		{
			addEventListener(Event.ADDED_TO_STAGE, stageAddHandler);
		}

		private function stageAddHandler(e:Event):void
		{
			this.player = parent.getChildByName("p1");
			stage.addEventListener(Event.ENTER_FRAME, stage_onEnterFrame);
			removeEventListener(Event.ADDED_TO_STAGE, stageAddHandler);
		}

		private function stage_onEnterFrame(event:Event):void
		{
			if (this != null)
			{
				if (this.x < player.x)
				{
					if (this.scaleX == -1)
					{
						this.scaleX *=  -1;
					}
					this.x++;
				}
				else
				{
					if (this.scaleX == 1)
					{
						this.scaleX *=  -1;
					}
					this.x--;
				}
			}
		}

		public function remove():void
		{
			this.removeEventListener(Event.ENTER_FRAME, stage_onEnterFrame);
			parent.removeChild(this);
		}
	}

}