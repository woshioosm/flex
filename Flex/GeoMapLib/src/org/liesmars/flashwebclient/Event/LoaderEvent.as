package org.liesmars.flashwebclient.Event
{
	import flash.events.Event;

	public class LoaderEvent extends Event
	{
		// state 有三个值
		// 1表示请求返回正常
		// 2表示请求返回错误信息
		// 3表示请求未被发送！
		
		public var state:uint = 1;
		
		public static const LoaderComplete:String = "LoaderComplete";
		
		public function LoaderEvent(type:String,_state:int, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			state = _state;
		}
		
	}
}