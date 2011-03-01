package {
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;


	public class MouseInput {
		public static var leftButtonPressed:Boolean = false;
		public static var mouseX:Number = 0;
		public static var mouseY:Number = 0;
		private static var listener:Vector.<KeyListener>;
		
		
		public static function Initialize(stage:Stage):void {
			listener = new Vector.<KeyListener>();
			stage.addEventListener(MouseEvent.MOUSE_DOWN, ButtonPress);
			stage.addEventListener(MouseEvent.MOUSE_UP, ButtonRelease);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, Move);
			
			Mouse.hide();
		}
		
		
		private static function ButtonPress(event:MouseEvent):void {
			leftButtonPressed = true;
			var listenerCount:int = listener.length;
			for (var i:int = 0; i < listenerCount; i ++) {
				listener[i].MouseButtonPress();
			}
		}

		
		private static function ButtonRelease(event:MouseEvent):void {
			leftButtonPressed = false;
		}
		
		
		private static function Move(event:MouseEvent):void {
			mouseX = 10+event.localX/2;
			mouseY = 10+event.localY/2;
		}
		
		
		public static function AddListener(newListener:KeyListener):void {
			listener.push(newListener);
			trace("Input.Addlistener: New listener added. "
				+ listener.length + " in list.");
		}
		
		
		public static function RemoveListener(targetListener:KeyListener):void {
			var index:int = listener.lastIndexOf(targetListener);
			trace("Index of target listener is " + index);
			if (index != -1) {
				listener.splice(index, 1);
				trace("Input.RemoveListener: listener " + index + " removed. "
					+ listener.length + " remain.");
			}
		}
	}
}