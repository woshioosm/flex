package cn.edu.whu.liesmars.asPack.event
{
	public class EventManager
	{
		import flash.events.*;
		
		public function EventManager()
		{
		}
		public static function dispatchEvent(arg1:flash.events.IEventDispatcher, arg2:flash.events.Event):void
		{
			arg1.dispatchEvent(arg2);
			return;
		}
		
		public static function unregisterEventListener(arg1:flash.events.IEventDispatcher, arg2:String, arg3:Function, arg4:String=""):void
		{
			arg1.removeEventListener(arg2, arg3, false);
			return;
		}
		
		public static function registerEventListener(arg1:flash.events.IEventDispatcher, arg2:String, arg3:Function, arg4:String=""):void
		{
			arg1.addEventListener(arg2, arg3, false, 0, true);
			return;
		}
		
		
//		{
//			debugHandlerHolder = new Object();
//			debugHandlerTargetCounts = new Object();
//		}
//		
//		internal static const DEBUG_HANDLER_PREFIX:String="_handler_";
//		
//		internal static var debugHandlerHolder:Object;
//		
//		internal static var debugHandlerTargetCounts:Object;
	}
}