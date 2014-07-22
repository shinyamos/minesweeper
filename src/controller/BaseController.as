package controller {
	import flash.display.Sprite;

	public class BaseController implements IDisplayable {
		protected var _sprite : Sprite;
		protected var eventController : EventController = EventController.getInstance();

		public function BaseController(spr : Sprite) {
			_sprite = spr;
		}

		public function show() : void {
		}

		public function hide() : void {
		}
	}
}