package 
{
	import flash.display.Bitmap;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Jonathan henly
	 */
	public class Layout extends EMovieClip 
	{
		[Embed(source = "../img/stoneTablet.jpg")]
		private var StoneTablet:Class;
		private var stJPEG:Bitmap = new StoneTablet();
		
		private var PC:ParticleContainer;
		private var SG:SquareGrid;
		
		public function Layout():void
		{
			super();
			
			PC = new ParticleContainer();
			PC.x = 0;
			PC.y = 0;
			
			SG = new SquareGrid();
			SG.y = 0;
			SG.x = 25;
			
			this.addChild(PC);
			this.addChild(SG);
			
			stJPEG.width = 800;
			stJPEG.height = 200;
			stJPEG.x = 0;
			stJPEG.y = 400;
			this.addChild(stJPEG);
		}
		
		override protected function onAddedToStage(e:Event):void
		{
			super.onAddedToStage(e);
			
		}
		
		public function update():void
		{
			PC.addParticles();
			PC.update();
		}
		
	}
	
}