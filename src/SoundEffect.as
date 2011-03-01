package {
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.utils.ObjectOutput;
	
	public class SoundEffect {
		// embed sounds
		[Embed(source="../lib/death.mp3")]
		private static var deathClass:Class;
		[Embed(source = "../lib/walk.mp3")]
		private static var walkClass:Class;
		[Embed(source = "../lib/fall.mp3")]
		private static var fallClass:Class;
		[Embed(source = "../lib/open.mp3")]
		private static var openClass:Class;
		[Embed(source = "../lib/jump.mp3")]
		private static var jumpClass:Class;
		
		private static var sound:Vector.<Sound>;
		private static var channel:SoundChannel;
		
		public static function initialize():void {
			sound =  new Vector.<Sound>;
			sound.push( new deathClass());
			sound.push(new walkClass());
			sound.push(new fallClass());
			sound.push(new openClass());
			sound.push(new jumpClass());
			channel = new SoundChannel();
		}
		
		public static function play(which:int):void {
			channel = Sound(sound[which]).play();
		}
	} 
}