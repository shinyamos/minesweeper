package {
	import controller.MainController;

	import flash.display.Sprite;

	public class GameStart extends Sprite {
		private var _mainController : MainController;

		public function GameStart() {
			_mainController = new MainController(this);
		}
	}
}