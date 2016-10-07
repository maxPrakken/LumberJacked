package {

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.*;


	public class Buttons extends MovieClip {

		public var hasBeenClicked: Boolean = false;
		public function Buttons() {
			// constructor code
			this.addEventListener(MouseEvent.CLICK, isClicked);
			trace("CLICK");
		}

		public function isClicked(e: MouseEvent) {
			hasBeenClicked = true;
			trace(hasBeenClicked);
		}
	}

}