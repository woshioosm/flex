package com.poyanghu.wfs.events
{
	import com.poyanghu.wfs.WFSQuerior;
	
	import flash.events.Event;

	public class WFSEvent extends Event
	{
		public var querior:WFSQuerior;
		public static const WFS_LOADED:String = "WFS_LOADED"; 
		public static const WFS_IO_ERROR:String = "WFS_IO_ERROR"; 
		
		public function WFSEvent(querior:WFSQuerior,type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.querior = querior;
			super(type, bubbles, cancelable);
		}
		
	}
}