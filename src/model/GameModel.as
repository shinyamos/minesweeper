package model {
	public final class GameModel {
		private var _boardArray : Vector.<Vector.<TileData>>;
		private var _gamelevelSettings : GameLevel;

		public function GameModel(gameLevel : GameLevel) {
			_gamelevelSettings = gameLevel;

			// initBoard
			initBoard();

			// randomly select mines
			setMines();

			// set count of neighboring mines for each tile
			setNeighborMineCount();
		}

		private function initBoard() : void {
			_boardArray = new Vector.<Vector.<TileData>>();
			for (var row : int = 0; row < _gamelevelSettings.rows; row++) {
				var currentRow : Vector.<TileData> = new Vector.<TileData>();
				_boardArray.push(currentRow);
				for (var col : int = 0; col < _gamelevelSettings.cols; col++) {
					currentRow.push(new TileData(row, col));
				}
			}
		}

		public function getTileModel(row : int, col : int) : TileData {
			return _boardArray[row][col];
		}

		private function getMineCoordinates(rows : int, columns : int, mines : int) : Vector.<int> {
			var coordinates : Vector.<int> = new Vector.<int>();
			var upperBounds : int = (rows * columns) ;
			do {
				var curMineCoordinate : int = Math.floor(Math.random() * upperBounds);
				if (coordinates.lastIndexOf(curMineCoordinate) == -1 ) {
					coordinates.push(curMineCoordinate);
				}
			} while (coordinates.length <= mines) ;

			return coordinates;
		}

		private function setMines() : void {
			var mineCoordinates : Vector.<int> = getMineCoordinates(_gamelevelSettings.rows, _gamelevelSettings.cols, _gamelevelSettings.mines);
			for (var mineIdx : int = 0; mineIdx < _gamelevelSettings.mines; mineIdx++) {
				var minePosition : int = mineCoordinates[mineIdx];
				var minedRow : int = int(minePosition / _gamelevelSettings.cols);
				var minedCol : int = minePosition % _gamelevelSettings.cols;
				var curData : TileData = _boardArray[minedRow][minedCol];
				curData.isMine = true;
			}
		}

		private function setNeighborMineCount() : void {
			for (var row : int = 0; row < _gamelevelSettings.rows; row++) {
				for (var col : int = 0; col < _gamelevelSettings.cols; col++) {
					for (var neighboringRow : int = row - 1; neighboringRow <= row + 1; neighboringRow++) {
						for (var neighboringColumn : int = col - 1; neighboringColumn <= col + 1; neighboringColumn++) {
							// trace("Looking at neighboring row, cols", neighboringRow, neighboringColumn);
							if (isMined(neighboringRow, neighboringColumn) && !(neighboringColumn == col && neighboringRow == row))
								_boardArray[row][col].minedNeighborCount += 1;
						}
					}
				}
			}
		}

		private function isMined(row : int, col : int) : Boolean {
			// check for out of bounds positions
			if (row < 0 || col < 0)
				return false;
			if (row >= _gamelevelSettings.rows)
				return false;
			if (col >= _gamelevelSettings.cols)
				return false;
			else
				return _boardArray[row][col].isMine;
		}

		public function get columns() : int {
			return _boardArray[0].length;
		}

		public function get rows() : int {
			return _boardArray.length;
		}

		public function isGameOver() : Boolean {
			var playedTileCount : int = 0;
			for (var row : int = 0; row < _gamelevelSettings.rows; row++) {
				for (var col : int = 0; col < _gamelevelSettings.cols; col++) {
					var curTileData : TileData = _boardArray[row][col];
					if (curTileData.markedAsMine || curTileData.revealed)
						playedTileCount++;
				}
			}
			return (playedTileCount == _gamelevelSettings.rows * _gamelevelSettings.cols);
		}

		public function getNeighbors(row : int, col : int) : Vector.<TileData> {
			var neighbors : Vector.<TileData> = new Vector.<TileData>();
			var startRow : int = Math.max(row - 1, 0);
			var endRow : int = Math.min(row + 1, _gamelevelSettings.rows - 1);
			var startCol : int = Math.max(col - 1, 0);
			var endCol : int = Math.min(col + 1, _gamelevelSettings.cols - 1);

			for (var rowIdx : int = startRow; rowIdx <= endRow; rowIdx++) {
				for (var colIdx : int = startCol; colIdx <= endCol; colIdx++) {
					if (!(colIdx == col && row == rowIdx)) {
						neighbors.push(getTileModel(rowIdx, colIdx));
					}
				}
			}
			return neighbors;
		}

		public function clear() : void {
			for (var row : int = 0; row < _gamelevelSettings.rows; row++) {
				for (var col : int = 0; col < _gamelevelSettings.cols; col++) {
					_boardArray[row][col] = null;
				}
			}
			_boardArray = null;
			_gamelevelSettings = null;
		}
	}
}