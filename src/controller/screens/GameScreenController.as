package controller.screens {
	import controller.BaseController;

	import events.GameOverEvent;
	import events.TileClickEvent;

	import model.GameModel;
	import model.TileData;

	import view.GameScreenView;

	import flash.display.Sprite;

	public final class GameScreenController extends BaseController {
		private var _gameModel : GameModel;
		private var _gameScreenView : GameScreenView;

		public function GameScreenController(baseSpr : Sprite) {
			_gameScreenView = new GameScreenView(baseSpr);
			super(baseSpr);
		}

		public function setModel(gameModel : GameModel) : void {
			_gameModel = gameModel;
		}

		override public function show() : void {
			_gameScreenView.drawBoard(_gameModel.rows, _gameModel.columns);
			eventController.addEventListener(TileClickEvent.TILE_CLICK, onTileClick);
			eventController.addEventListener(TileClickEvent.TILE_SHIFT_CLICK, onShiftTileClick);
		}

		private function onShiftTileClick(tileClickEvent : TileClickEvent) : void {
			var clickedTileData : TileData = _gameModel.getTileModel(tileClickEvent.tilePosition.row, tileClickEvent.tilePosition.col);
			clickedTileData.markedAsMine = !clickedTileData.markedAsMine;
			_gameScreenView.markTile(clickedTileData.row, clickedTileData.col, clickedTileData.markedAsMine);
			checkGameOver();
		}

		private function onTileClick(tileClickEvent : TileClickEvent) : void {
			var clickedTileData : TileData = _gameModel.getTileModel(tileClickEvent.tilePosition.row, tileClickEvent.tilePosition.col);

			if (clickedTileData.isMine) {
				_gameScreenView.revealTile(clickedTileData.row, clickedTileData.col, clickedTileData.minedNeighborCount, clickedTileData.isMine);
				endGameBadly();
			} else {
				clickedTileData.revealed = true;
				_gameScreenView.revealTile(clickedTileData.row, clickedTileData.col, clickedTileData.minedNeighborCount, clickedTileData.isMine);
				if (clickedTileData.minedNeighborCount == 0) {
					openNeighbors(clickedTileData);
				}
			}
			checkGameOver();
		}

		private function checkGameOver() : void {
			if (_gameModel.isGameOver()) {
				eventController.dispatchEvent(new GameOverEvent(GameOverEvent.GAME_OVER_WIN));
				stopListeners();
			}
		}

		private function stopListeners() : void {
			eventController.removeEventListener(TileClickEvent.TILE_CLICK, onTileClick);
			eventController.removeEventListener(TileClickEvent.TILE_SHIFT_CLICK, onShiftTileClick);
		}

		private function openNeighbors(tileData : TileData) : void {
			var neighbors : Vector.<TileData> = _gameModel.getNeighbors(tileData.row, tileData.col);
			for (var i : int = 0; i < neighbors.length; i++) {
				var neighbor : TileData = neighbors[i];
				if (neighbor.revealed == false ) {
					neighbor.revealed = true;
					_gameScreenView.revealTile(neighbor.row, neighbor.col, neighbor.minedNeighborCount, neighbor.isMine);
					if (neighbor.minedNeighborCount == 0) {
						openNeighbors(neighbor);
					}
				}
			}
		}

		private function endGameBadly() : void {
			// reveal board
			for (var row : int = 0; row < _gameModel.rows; row++) {
				for (var col : int = 0; col < _gameModel.columns; col++) {
					var curTileData : TileData = _gameModel.getTileModel(row, col);
					_gameScreenView.revealTile(row, col, curTileData.minedNeighborCount, curTileData.isMine);
				}
			}

			eventController.dispatchEvent(new GameOverEvent(GameOverEvent.GAME_OVER_FAIL));
			stopListeners();
		}

		override public function hide() : void {
		}

		public function clear() : void {
			_gameScreenView.clear();
			_gameScreenView = null;
			_gameModel = null;
		}
	}
}