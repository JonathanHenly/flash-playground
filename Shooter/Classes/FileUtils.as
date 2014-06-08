package 
{

	import flash.events.*;
	import flash.net.*;

	public class FileUtils
	{

		private var myTextLoader:URLLoader;
		private var variables:URLVariables;
		private var varSend:URLRequest;
		private var varLoader:URLLoader;

		private var currentUpgrades:String = "";

		public function FileUtils()
		{
			this.variables = new URLVariables();
			this.varSend = new URLRequest("write.php");
			this.varLoader = new URLLoader  ;

			this.varSend.method = URLRequestMethod.POST;
			this.varSend.data = variables;
		}

		public function readFile(inFile:String):void
		{
			this.myTextLoader = new URLLoader();

			this.myTextLoader.addEventListener(IOErrorEvent.IO_ERROR, fileTest_errorHandler);
			this.myTextLoader.addEventListener(Event.COMPLETE, onLoaded);

			this.myTextLoader.load(new URLRequest(inFile + ".txt"));

			function fileTest_errorHandler(event:Event):void
			{
				newFile(inFile);
				setCurrentUpgrades("100000");
			}

		}

		public function onLoaded(e:Event):void
		{
			var myArrayOfLines:Array = e.target.data.split(/\n/);
			this.setCurrentUpgrades(myArrayOfLines.toString());
			// trace(this.currentUpgrades);
		}
		
		private function setCurrentUpgrades(that:String):void
		{
			this.currentUpgrades = that;
		}
		
		public function getCurrentUpgrades():String
		{
			return this.currentUpgrades;
		}
		
		public function isLoaded():Boolean
		{
			if(this.currentUpgrades == "") {
				return false;
			} else {
				return true;
			}
		}

		public function writeFile(outFile:String)
		{
			variables.upgrades = "101101";
			variables.filename = outFile + ".txt";
			varLoader.load(varSend);
		}

		public function newFile(outFile:String)
		{
			variables.upgrades = "ABCDEFG";
			variables.filename = outFile + ".txt";
			varLoader.load(varSend);
		}

	}
}// Clean up and close the file stream 