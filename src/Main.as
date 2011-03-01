package 
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	
	/*
	 * 
	 * Main is a transition class, switching from loading to the draw loop
	 * 
	 */
	public class Main extends Sprite 
	{
		public function Main(stage:Stage):void 
		{
			Input.Initialize(stage);
			Input.UpdateControls();
			Text.initialize();
			MouseInput.Initialize(stage);
			Blit.initialize();
			SoundEffect.initialize();
			Draw.initialize(stage);
			
			//the game happens here: in Draw.frame()
			addEventListener(Event.ENTER_FRAME, Draw.frame);
			
		}	
	}
}