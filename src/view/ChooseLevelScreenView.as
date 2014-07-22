package view {
	import events.ChooseLevelScreenEvent;

	import controller.EventController;

	import flash.events.MouseEvent;
	import flash.display.Sprite;

	import assets.ChooseLevelScreen;

	public class ChooseLevelScreenView extends BaseScreenView {
		private var _chooseLevelScreen : ChooseLevelScreen;

		public function ChooseLevelScreenView(baseSpr : Sprite) {
			super(baseSpr);
		}

		public function show() : void {
			_chooseLevelScreen = new ChooseLevelScreen();
			_baseSpr.addChild(_chooseLevelScreen);
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

		override public function clear() : void {
			_chooseLevelScreen.playButton.removeEventListener(MouseEvent.MOUSE_UP, onLevelChosen);
			super.clear();
		}
	}
}
