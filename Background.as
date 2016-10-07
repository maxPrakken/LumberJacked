package  {
	
	import flash.display.MovieClip;
	
	
	public class Background extends MovieClip {
		
		var up: Boolean;
		var down: Boolean;
		var left: Boolean;
		var right: Boolean;
		
		var position: Vector2;
		var velocity: Vector2;
		var acceleration: Vector2;
		var speed: Number = 80;
		
		public function Background() {
			// constructor code
			position = new Vector2(0, 0);
			velocity = new Vector2();
			
			up = false;
			down = false;
			left = false
			right = false;
		}
		
		public function update() {
			move();
		}
		
		public function move() {

			var vec:Vector2 = new Vector2();
			if(up) {
				vec.add( new Vector2(0, 1));
			}
			
			if(down) {
				vec.add( new Vector2(0, -1));
			}
			
			if(right) {
				vec.add( new Vector2(-1, 0));
			}
			
			if(left) {
				vec.add(  new Vector2(1, 0));
			}
			
			vec.normalize();
			vec.multS(speed);
			velocity.add(vec);
			position.add(velocity);
			velocity.multS(0);
			x = position.x;
			y = position.y;
		}
		
		public function addForce(force: Vector2) {
			var f: Vector2 = force.copy();
			acceleration.add(f);
		}
	}
	
}
