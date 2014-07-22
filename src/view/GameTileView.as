package view {
	import assets.GameTile;

	import controller.EventController;

	import events.TileClickEvent;

	import model.TilePosition;

	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public final class GameTileView extends Sprite {
		private var _mc : GameTile;
		private var _position : TilePosition;

		public function GameTileView(position : TilePosition) {
			_position = position;
			initDisplay();
			super();
		}

		private function initDisplay() : void {
			_mc = new GameTile();
			this.addChild(_mc);
			_mc.neighborCount_txt.text = "";
			_mc.flagGfx.visible = false;
			_mc.revealBgGfx.visible = false;
			_mc.mineGfx.visible = false;
			_mc.addEventListener(MouseEvent.MOUSE_DOWN, onClick);
		}

		private function onClick(mEvent : MouseEvent) : void {
			if (mEvent.shiftKey) {
				EventController.getInstance().dispatchEvent(new TileClickEvent(TileClickEvent.TILE_SHIFT_CLICK, _position));
			} else
				EventController.getInstance().dispatchEvent(new TileClickEvent(TileClickEvent.TILE_CLICK, _position));
		}

		public function mark(markAsMine : Boolean) : void {
			_mc.flagGfx.visible = markAsMine;
		}

		public function reveal(neighborCount : int, isMine : Boolean) : void {
			_mc.flagGfx.visible = false;
			_mc.revealBgGfx.visible = true;
			if (isMine) {
				_mc.mineGfx.visible = isMine;
			} else if (neighborCount > 0) {
				_mc.neighborCount_txt.text = neighborCount.toString();
			}
			deactivate();
		}

		public function deactivate() : void {
			_mc.removeEventListener(MouseEvent.MOUSE_DOWN, onClick);
		}
	}
}