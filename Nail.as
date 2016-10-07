package  {
	
	import flash.display.MovieClip;
	import flash.events.*;

	
	public class Nail extends MovieClip {
		
		private var nailSpeed:Number = 15;
		public var isEnabled:Boolean = true;
		
		public function Nail() {
			
		}
		
		public function update() {
			var nailAngle:Number = (this.rotation -0)* Math.PI / 180;
			this.x = this.x + 80 * Math.cos(nailAngle);
			this.y = this.y + 80 * Math.sin(nailAngle);
					
		}
	}
	
}
