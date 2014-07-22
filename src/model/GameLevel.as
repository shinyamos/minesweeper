package model {
	public final class GameLevel {
		private static const EASY : GameLevel = new GameLevel(6, 6, 6);
		private static const MEDIUM : GameLevel = new GameLevel(8, 8, 10);
		private static const HARD : GameLevel = new GameLevel(9, 12, 20);
		private static const levelArray : Array = new Array(EASY, MEDIUM, HARD);
		public var rows : int;
		public var cols : int;
		public var mines : int;

		public function GameLevel(r : int, c : int, m : int) {
			rows = r;
			cols = c;
			mines = m;
		}

		static public function getGameLevel(levelIdx : int) : GameLevel {
			return levelArray[levelIdx];
		}
	}
}