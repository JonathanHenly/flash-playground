package 
{
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.filters.*;
	import flash.events.*;
	
	/**
	 * ...
	 * @author ...
	 */
	public class UnlockPanel extends MovieClip 
	{
		private var panel:MovieClip = new MovieClip();
		private var background:MovieClip = new MovieClip();
		
		public function UnlockPanel()
		{
			this.createUnlockBackground();
			this.createUnlockPanel();
			this.panel.filters = new Array(this.addFilter());
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function onAddedToStage(event:Event):void
		{
			this.background.x = 0;
			this.background.y = 0;
			this.addChild(background);
			this.panel.x = (550 - this.panel.width) / 2;
			this.panel.y = (400 - this.panel.height) / 2;
			this.addChild(panel);
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function createUnlockPanel():void
		{
			this.panel.graphics.lineStyle(2, 0xFFFFFF);
			this.panel.graphics.beginFill(0xFFFFFF, 0.5);
			this.panel.graphics.drawRoundRect(0, 0, 500, 360, 42, 40);
			this.panel.graphics.endFill();
		}
		
		public function createUnlockBackground():void
		{
			this.background.graphics.beginFill(0x1F0FAF, 1);
			this.background.graphics.drawRect(0, 0, 550, 400);
			this.background.graphics.endFill();
		}
		
		public function addFilter():GlowFilter
		{
			var GLOW_COLOR:uint = 0x000000;
			var backGlow:GlowFilter = new GlowFilter();
			backGlow.blurX = 15;
			backGlow.blurY = 15;
			backGlow.alpha = 1.0;
			backGlow.color = GLOW_COLOR;
			backGlow.inner = false;
			backGlow.knockout = false;
			backGlow.quality = 15;
			backGlow.strength = 3;
			
			return backGlow;
		}
		
	}
	
}