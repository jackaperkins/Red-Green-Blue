/* Input
 * This is a keyboard input class which works for two types of input. Other classes
 * can poll at any time to check on the status of a key. Alternately, if a class
 * wants notification when a key is first pressed or released (as seems to often be
 * the case with UI) it can add itself to a list of listeners and it will be notified
 * when keys change their status.
 * */

package {
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	
	public class Input {
		// state of each ascii key
		private static var state:Vector.<Boolean>;
		
		//game controls, soft mapable to ascii keys
		public static var LEFT:Array;
		public static var RIGHT:Array;
		public static var UP:Array;
		public static var DOWN:Array;
		public static var JUMP:Array;
		
		public static function Initialize(stage:Stage):void {
			state = new Vector.<Boolean>();
			for (var i:int = 0; i < 300; i ++) {
				state.push(false);
			}
			stage.addEventListener(KeyboardEvent.KEY_DOWN, KeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, KeyUp);
		}
		
		public static function UpdateControls():void {
			LEFT = [65,37];
			RIGHT = [68,39];
			UP = [87,38];
			DOWN = [83,40];
			JUMP = [90,88,32];
		}
		
		public static function KeyUp(event:KeyboardEvent):void {
			if (state[event.keyCode] == true) {
				state[event.keyCode] = false;
			}
			UpdateControls();
		}
		
		public static function KeyDown(event:KeyboardEvent):void {
			if (state[event.keyCode] == false) {
				state[event.keyCode] = true;
				trace(event.keyCode + " pressed");
			}
			UpdateControls();
		}
		
		public static function GetState(controll:Array):Boolean {
			for (var i:int = 0; i < controll.length; i++) {
				if ( state[controll[i]]) {
					return true;		
				}
			}
			return false;

		}
	}
}