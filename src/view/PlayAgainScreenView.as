package view {
	import assets.PlayAgainScreen;

	import controller.EventController;

	import events.GameOverEvent;

	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class PlayAgainScreenView {
		private var _screen : PlayAgainScreen;
		private var _baseSprite : Sprite;

		public function PlayAgainScreenView(baseSprite : Sprite) {
			_baseSprite = baseSprite;
			_screen = new PlayAgainScreen();
		}

		public function show() : void {
			_baseSprite.addChild(_screen);
			_screen.playAgainButton.addEventListener(MouseEvent.MOUSE_UP, onPlayAgain);
		}

		public function setText(newText : String) : void {
			_screen.gameStatus_txt.text = newText;
		}

		private function onPlayAgain(event : MouseEvent) : void {
			EventController.getInstance().dispatchEvent(new GameOverEvent(GameOverEvent.PLAY_AGAIN));
		}

		public function destroy() : void {
			_screen.playAgainButton.removeEventListener(MouseEvent.MOUSE_UP, onPlayAgain);
			_baseSprite.removeChild(_screen);
			_screen = null;
		}
	}
}
