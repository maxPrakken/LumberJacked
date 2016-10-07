package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.ui.Keyboard;
	
	
	public class Jack extends MovieClip {
		
		var up: Boolean;
		var down: Boolean;
		var left: Boolean;
		var right: Boolean;
		
		var position: Vector2;
		var velocity: Vector2;
		var acceleration: Vector2;
		var mouse: Vector2;
		var v: Vector2;
		var speed: Number = 10;
		
		public function update(msX,msY) {
			mouse.x = msX;
			mouse.y = msY;
			
			x = position.x;
			y = position.y;
			
			v.calDis(position, mouse);
			
			rotate();
		}
		
		public function Jack() {
			
			position = new Vector2(0, 0);
			velocity = new Vector2();
			mouse = new Vector2();
			v = new Vector2();
			
			up = false;
			down = false;
			left = false
			right = false;
		}
		
		public function rotate() {

			this.rotation = v.getAngle();
		}
		
		public function addForce(force: Vector2) {
			var f: Vector2 = force.copy();
			acceleration.add(f);
		}
	}
}
