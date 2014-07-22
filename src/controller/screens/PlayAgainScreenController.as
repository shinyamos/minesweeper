package controller.screens {
	import controller.BaseController;

	import view.PlayAgainScreenView;

	import flash.display.Sprite;

	public final class PlayAgainScreenController extends BaseController {
		private var _playAgainView : PlayAgainScreenView;
		public var gameSuccessful : Boolean;

		public function PlayAgainScreenController(spr : Sprite) {
			_playAgainView = new PlayAgainScreenView(spr);
			super(spr);
		}

		override public function show() : void {
			if (gameSuccessful) {
				_playAgainView.setText("You have Won, congrats!");
			} else {
				_playAgainView.setText("You have lost, thanks for playing!");
			}
			_playAgainView.show();
		}

		override public function hide() : void {
			_playAgainView.clear();
			_playAgainView = null;
		}
	}
}