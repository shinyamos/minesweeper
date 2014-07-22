package events {
	import flash.events.Event;

	public final class IntroScreenEvent extends Event {
		public static const INTRO_SCREEN_DONE : String = "intro.done";
		private var _bubbles : Boolean;
		private var _cancelable : Boolean;
		private var _type : String;

		public function IntroScreenEvent(type : String) {
			_type = type;
			_bubbles = bubbles;
			_cancelable = cancelable;
			super(type, bubbles, cancelable);
		}

		override public function clone() : Event {
			return new IntroScreenEvent(_type);
		}
	}
}