package org.liesmars.flashwebclient
{
	import flash.events.Event;
	
	/*
	 *自定义事件的抽象类 
	 */
	public class GeoEvent extends Event
	{
		
		public function GeoEvent(type:String,bubbles:Boolean,cancelable:Boolean)
		{
			super(type,bubbles,cancelable);
		}
	}
}