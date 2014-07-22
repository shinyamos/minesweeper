package controller {
	import controller.screens.ChooseLevelScreenController;
	import controller.screens.GameScreenController;
	import controller.screens.InstructionScreenController;
	import controller.screens.PlayAgainScreenController;

	import events.ChooseLevelScreenEvent;
	import events.GameOverEvent;
	import events.IntroScreenEvent;

	import model.GameLevel;
	import model.GameModel;

	import flash.display.Sprite;

	public class MainController {
		private var _baseSprite : Sprite;
		private var _instructionScreenSprite : Sprite;
		private var _chooseLevelScreenSprite : Sprite;
		private var _gameSprite : Sprite;
		private var _playAgainSprite : Sprite;
		private var _eventController : EventController = EventController.getInstance();
		private var _introController : InstructionScreenController;
		private var _chooseLevelScreenController : ChooseLevelScreenController;
		private var _gameController : GameScreenController;
		private var _playAgainController : PlayAgainScreenController;
		private var _gameModel : GameModel;

		public function MainController(baseSprite : Sprite) {
			_baseSprite = baseSprite;

			_instructionScreenSprite = new Sprite();
			_introController = new InstructionScreenController(_instructionScreenSprite);
			_baseSprite.addChild(_instructionScreenSprite);

			// Intro only shown once
			initControllers();
			_introController.show();
		}

		private function initControllers() : void {
			_chooseLevelScreenSprite = new Sprite();
			_gameSprite = new Sprite();
			_playAgainSprite = new Sprite();
			_baseSprite.addChild(_chooseLevelScreenSprite);
			_baseSprite.addChild(_gameSprite);
			_baseSprite.addChild(_playAgainSprite);

			_chooseLevelScreenController = new ChooseLevelScreenController(_chooseLevelScreenSprite);
			_gameController = new GameScreenController(_gameSprite);
			_playAgainController = new PlayAgainScreenController(_playAgainSprite);

			_eventController.addEventListener(IntroScreenEvent.INTRO_SCREEN_DONE, onIntroDone);
		}

		private function onIntroDone(e : IntroScreenEvent) : void {
			_eventController.removeEventListener(IntroScreenEvent.INTRO_SCREEN_DONE, onIntroDone);
			_introController.hide();

			showChooseLevelScreen();
		}

		private function showChooseLevelScreen() : void {
			_eventController.addEventListener(ChooseLevelScreenEvent.LEVEL_CHOSEN, onLevelChosen);
			_chooseLevelScreenController.show();
		}

		private function onLevelChosen(levelChosenEvent : ChooseLevelScreenEvent) : void {
			_eventController.removeEventListener(ChooseLevelScreenEvent.LEVEL_CHOSEN, onLevelChosen);
			_chooseLevelScreenController.hide();

			_gameModel = new GameModel(GameLevel.getGameLevel(levelChosenEvent.level));
			_eventController.addEventListener(GameOverEvent.GAME_OVER_FAIL, onGameOver);
			_eventController.addEventListener(GameOverEvent.GAME_OVER_WIN, onGameOver);
			_gameController.setModel(_gameModel);
			_gameController.show();
		}

		private function onGameOver(e : GameOverEvent) : void {
			_eventController.removeEventListener(GameOverEvent.GAME_OVER_FAIL, onGameOver);
			_eventController.removeEventListener(GameOverEvent.GAME_OVER_WIN, onGameOver);

			_playAgainController.gameSuccessful = (e.type == GameOverEvent.GAME_OVER_WIN); 

			_playAgainController.show();
			_eventController.addEventListener(GameOverEvent.PLAY_AGAIN, onReplay);
		}

		private function onReplay(e : GameOverEvent) : void {
			_playAgainController.hide();
			_eventController.removeEventListener(GameOverEvent.PLAY_AGAIN, onReplay);
			restart();
		}

		private function restart() : void {
			_gameController.clear();
			_gameModel.clear();
			var displayObjectsCount : int = _baseSprite.numChildren;
			for (var spriteIdx : int = 0; spriteIdx < displayObjectsCount; spriteIdx++) {
				_baseSprite.removeChildAt(0);
			}
			_instructionScreenSprite = null;
			_chooseLevelScreenSprite = null;
			_gameSprite = null;
			_playAgainSprite = null;
			_introController = null;
			_chooseLevelScreenController = null;
			_gameController = null;
			_playAgainController = null;

			_eventController.addEventListener(IntroScreenEvent.INTRO_SCREEN_DONE, onIntroDone);
			initControllers();
			showChooseLevelScreen();
		}
	}
}