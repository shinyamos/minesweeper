package controller.screens {
	import assets.IntroductionScreen;

	import controller.BaseController;
	import controller.EventController;

	import events.IntroScreenEvent;

	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class InstructionScreenController extends BaseController {
		private var introScreen : IntroductionScreen;

		public function InstructionScreenController(spr : Sprite) {
			super(spr);
		}

		override public function show() : void {
			introScreen = new IntroductionScreen();
			_sprite.addChild(introScreen);
			introScreen.continueButton.addEventListener(MouseEvent.MOUSE_UP, onContinue);
		}

		override public function hide() : void {
			introScreen.continueButton.removeEventListener(MouseEvent.MOUSE_UP, onContinue);
			_sprite.removeChild(introScreen);
			introScreen = null;
		}

		private function onContinue(event : MouseEvent) : void {
			EventController.getInstance().dispatchEvent(new IntroScreenEvent(IntroScreenEvent.INTRO_SCREEN_DONE));
		}
	}
}