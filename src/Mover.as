package  
{
	/**
	 * ...
	 * @author jack
	 */
	public class Mover
	{
		public var x:Number;
		public var y:Number;
		public var remove:Boolean;
		
		
		public function Mover(xx:Number, yy:Number) 
		{
			x = xx;
			y = yy;
			remove = false;
		}
		
		public function go():void
		{
			
		}
		
		public function display():void
		{
			
		}
		
		public static function hit(m1:Mover, m2:Mover):Boolean {
			if ( Math.sqrt( sq(m1.x-m2.x) + sq(m1.y-m2.y) ) < 13) {
				return true;
			} else {
				return false;
			}
		}
		
		public static function sq(number:Number):Number {
			return(number * number);
		}
	}

}