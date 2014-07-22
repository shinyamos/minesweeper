package events {
	import flash.events.Event;

	public final class GameOverEvent extends Event {
		public static const GAME_OVER_FAIL : String = "game.over.fail";
		public static const GAME_OVER_WIN : String = "game.over.win";
		public static const PLAY_AGAIN : String = "play.again";
		private var _bubbles : Boolean;
		private var _cancelable : Boolean;
		private var _type : String;

		public function GameOverEvent(type : String) {
			_type = type;
			_bubbles = bubbles;
			_cancelable = cancelable;
			super(type, bubbles, cancelable);
		}

		override public function clone() : Event {
			return new GameOverEvent(_type);
		}
	}
}