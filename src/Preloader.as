package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.geom.Rectangle;
	import flash.utils.getDefinitionByName;
	
	/**
	 * ...
	 * @author jack
	 */
	public class Preloader extends MovieClip 
	{
		public static var buffer:BitmapData;
		public static var loader:int;
		
		public function Preloader() 
		{
			addEventListener(Event.ENTER_FRAME, checkFrame);
			buffer = new BitmapData(200, 150, false, 0x000000);
			var temp:Bitmap = new Bitmap(buffer);
			temp.scaleX = temp.scaleY = 4;
			stage.addChild(temp);
			
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, progress);
		}
		
		private function progress(e:ProgressEvent):void 
		{
			//flash the screen random colors while we load
			buffer.fillRect(new Rectangle(0,0,200,150),Math.random()*0xFFFFFF);

		}
		
		private function checkFrame(e:Event):void 
		{
			trace(currentFrame + " and " + totalFrames);
			if (currentFrame == totalFrames) 
			{
				removeEventListener(Event.ENTER_FRAME, checkFrame);
				startup();
			}
		}
		
		private function startup():void 
		{
			// hide loader
			stop();
			stage.removeChildAt(1);
			
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, progress);
			
			//boot up into the Main class
			var mainClass:Class = getDefinitionByName("Main") as Class;
			addChild(new mainClass(stage) as DisplayObject);
		}
		
	}
	
}