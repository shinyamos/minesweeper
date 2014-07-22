package view {
	import flash.display.DisplayObject;

	import model.TilePosition;

	import flash.display.Sprite;

	public class GameScreenView {
		private var _baseSpr : Sprite;
		private var _gameBoard : Vector.<Vector.<GameTileView>>;

		public function GameScreenView(baseSpr : Sprite) {
			_baseSpr = baseSpr;
		}

		public function drawBoard(rows : int, columns : int) : void {
			centerBoard(rows, columns);
			var boardColumns : int = columns;
			_gameBoard = new Vector.<Vector.<GameTileView>>();
			for (var row : int = 0; row < rows; row++) {
				var currentRow : Vector.<GameTileView> = new Vector.<GameTileView>();
				_gameBoard.push(currentRow);
				for (var col : int = 0; col < boardColumns; col++) {
					var newTile : GameTileView = new GameTileView(new TilePosition(row, col));
					newTile.x = col * newTile.width;
					newTile.y = row * newTile.height;
					currentRow.push(newTile);
					_baseSpr.addChild(newTile);
				}
			}
		}

		public function centerBoard(rows : int, columns : int) : void {
			var width : int = 600;
			var height : int = 400;
			var tileWidth : int = 46;
			var tileHeight : int = 44;
			_baseSpr.x = (width - (columns * tileWidth)) / 2;
			_baseSpr.y = Math.max(height - (rows * tileHeight)) / 2;
		}

		public function revealTile(tileRow : int, tileCol : int, neighborCount : int, isMined : Boolean) : void {
			_gameBoard[tileRow][tileCol].reveal(neighborCount, isMined);
		}

		public function markTile(tileRow : int, tileCol : int, markAsMine : Boolean) : void {
			_gameBoard[tileRow][tileCol].mark(markAsMine);
		}

		public function clear() : void {
			var tileCount : int = _baseSpr.numChildren;
			for (var tileIdx : int = 0; tileIdx < tileCount; tileIdx++) {
				var curTile : DisplayObject = _baseSpr.getChildAt(0);
				_baseSpr.removeChildAt(0);
				curTile = null;
			}
		}
	}
}