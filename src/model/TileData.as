package model {
	public class TileData {
		private var _position : TilePosition;
		public var minedNeighborCount : int;
		public var isMine : Boolean = false;
		public var markedAsMine : Boolean = false;
		public var revealed : Boolean = false;

		public function TileData(row : int, col : int) {
			_position = new TilePosition(row, col);
		}

		public function get row() : int {
			return _position.row;
		}

		public function get col() : int {
			return _position.col;
		}

		public function toString() : String {
			return "(" + row + ", " + col + "," + isMine + ", " + minedNeighborCount + "), ";
		}
	}
}