package events {
	import model.TilePosition;

	import flash.events.Event;

	public final class TileClickEvent extends Event {
		public static var TILE_CLICK : String = "tile.click";
		public static var TILE_SHIFT_CLICK : String = "tile.shift.click";
		public var tilePosition : TilePosition;

		public function TileClickEvent(type : String, tileData : TilePosition) {
			super(type, bubbles, cancelable);
			this.tilePosition = tileData;
		}

		override public function clone() : Event {
			return new TileClickEvent(type, tilePosition);
		}
	}
}