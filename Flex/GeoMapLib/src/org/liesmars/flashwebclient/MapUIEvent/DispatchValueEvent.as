package org.liesmars.flashwebclient.MapUIEvent
{
	import flash.events.Event;
	
	public class DispatchValueEvent extends Event
	{
		public static const GET_COMPOVALUE:String = "get_Dispatch_Value";
		public static const GET_WHEELVALUE:String = "get_Map_WheelZoom_Value";
		public var _value:Number;
		public function DispatchValueEvent(type:String,value:Number,bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type,bubbles,cancelable);
			this._value = value;
			
		}

	}
}