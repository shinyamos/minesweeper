package controller
{
	import flash.events.EventDispatcher;
	
	public final class EventController extends EventDispatcher
	{
		public static var inst : EventController;
		public function EventController(){}
		
		public static function getInstance():EventController
		{
			if(inst == null) inst = new EventController();
			return inst;
		}
	}
}