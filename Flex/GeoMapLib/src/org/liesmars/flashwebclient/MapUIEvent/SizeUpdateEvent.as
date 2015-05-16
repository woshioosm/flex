package org.liesmars.flashwebclient.MapUIEvent
{
	import flash.events.Event;
	public class SizeUpdateEvent extends Event
	{
			static public const SIZE_UPDATE:String = "setNewSize";
			public var data:Object;
					
			public function SizeUpdateEvent(data:Object, bubbles:Boolean=true, cancelable:Boolean=false)
			{
				super(SIZE_UPDATE, bubbles, cancelable);
				this.data = data;
			}			
		

	}
}


