package org.liesmars.flashwebclient.Event
{
	import flash.events.Event;

	public class ConnectEvent extends Event
	{
		public var state:uint = 1;
		
		public static const ConnectComplete:String = "ConnectComplete";
		
		public function ConnectEvent(type:String, _state:int,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			state = _state;
		}
		
	}
}