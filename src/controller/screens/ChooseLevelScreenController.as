package controller.screens {
	import controller.BaseController;

	import view.ChooseLevelScreenView;

	import flash.display.Sprite;

	public class ChooseLevelScreenController extends BaseController {
		private var _chooseLevelView : ChooseLevelScreenView;

		public function ChooseLevelScreenController(spr : Sprite) {
			_chooseLevelView = new ChooseLevelScreenView(spr);
			super(spr);
		}

		override public function show() : void {
			_chooseLevelView.show();
		}

		override public function hide() : void {
			_chooseLevelView.clear();
			_chooseLevelView = null;
		}
	}
}