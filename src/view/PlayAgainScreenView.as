package view {
	import assets.PlayAgainScreen;

	import controller.EventController;

	import events.GameOverEvent;

	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class PlayAgainScreenView extends BaseScreenView {
		private var _screen : PlayAgainScreen;

		public function PlayAgainScreenView(baseSpr : Sprite) {
			_screen = new PlayAgainScreen();
			super(baseSpr);
		}

		public function show() : void {
			_baseSpr.addChild(_screen);
			_screen.playAgainButton.addEventListener(MouseEvent.MOUSE_UP, onPlayAgain);
		}

		public function setText(newText : String) : void {
			_screen.gameStatus_txt.text = newText;
		}

		private function onPlayAgain(event : MouseEvent) : void {
			EventController.getInstance().dispatchEvent(new GameOverEvent(GameOverEvent.PLAY_AGAIN));
		}

		override public function clear() : void {
			_screen.playAgainButton.removeEventListener(MouseEvent.MOUSE_UP, onPlayAgain);
			super.clear();
		}
	}
}
