package view {
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	public class BaseScreenView {
		protected var _baseSpr : Sprite;

		public function BaseScreenView(baseSpr : Sprite) {
			_baseSpr = baseSpr;
		}

		public function clear() : void {
			var assetCount : int = _baseSpr.numChildren;
			for (var assetIdx : int = 0; assetIdx < assetCount; assetIdx++) {
				var curAsset : DisplayObject = _baseSpr.getChildAt(0);
				_baseSpr.removeChildAt(0);
				curAsset = null;
			}
		}
	}
}
