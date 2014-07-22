package events {
	import flash.events.Event;

	public final class ChooseLevelScreenEvent extends Event {
		public static const LEVEL_CHOSEN : String = "level.chosen";
		private var _bubbles : Boolean;
		private var _cancelable : Boolean;
		private var _type : String;
		public var level : int;

		public function ChooseLevelScreenEvent(type : String, level : int) {
			_type = type;
			this.level = level;
			_bubbles = bubbles;
			_cancelable = cancelable;
			super(type, bubbles, cancelable);
		}

		override public function clone() : Event {
			return new ChooseLevelScreenEvent(_type, level);
		}
	}
}