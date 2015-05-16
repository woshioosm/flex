package org.liesmars.flashwebclient.GeoEvent
{
	import flash.events.Event;

	public class DrawResultEvent extends Event
	{ 
		
		public static const DRAW_END:String="darw_end";
		
		public var x:Number;
		public var y:Number;
		public var resultType:String="";
		public var state:String
		public function DrawResultEvent(type:String,x:Number,y:Number,resultType:String,state:String)
		{
			this.x=x;
			this.y=y;
			this.resultType=resultType;
			this.state=state;
			super(type);
		}
	}
}