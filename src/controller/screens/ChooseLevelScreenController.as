package controller.screens {
	import assets.ChooseLevelScreen;

	import controller.BaseController;
	import controller.EventController;

	import events.ChooseLevelScreenEvent;

	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class ChooseLevelScreenController extends BaseController {
		private var _chooseLevelScreen : ChooseLevelScreen;

		public function ChooseLevelScreenController(spr : Sprite) {
			super(spr);
		}

		override public function show() : void {
			_chooseLevelScreen = new ChooseLevelScreen();
			_sprite.addChild(_chooseLevelScreen);
			_chooseLevelScreen.playButton.addEventListener(MouseEvent.MOUSE_UP, onLevelChosen);
		}

		private function onLevelChosen(e : MouseEvent) : void {
			var chosenLevel : int;
			switch (_chooseLevelScreen.radio_easy.group.selection) {
				case _chooseLevelScreen.radio_easy:
					chosenLevel = 0;
					break;
				case _chooseLevelScreen.radio_medium:
					chosenLevel = 1;
					break;
				case _chooseLevelScreen.radio_hard:
					chosenLevel = 2;
			}
			EventController.getInstance().dispatchEvent(new ChooseLevelScreenEvent(ChooseLevelScreenEvent.LEVEL_CHOSEN, chosenLevel));
		}

		override public function hide() : void {
			_chooseLevelScreen.playButton.removeEventListener(MouseEvent.MOUSE_UP, onLevelChosen);
			_sprite.removeChild(_chooseLevelScreen);
			_chooseLevelScreen = null;
		}
	}
}