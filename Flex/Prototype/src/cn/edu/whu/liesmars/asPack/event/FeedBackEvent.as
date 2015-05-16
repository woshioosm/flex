package cn.edu.whu.liesmars.asPack.event
{
	import flash.events.Event;
	
	import valueObjects.TDeepframework;
	import valueObjects.TShallowframework;

	public class FeedBackEvent extends Event  //目前作废
	{
		public static const  FEEDBACK:String="feedBack";
		
		public var deepFrameWork:TDeepframework=new TDeepframework();
		public var shallowFrameWork:TShallowframework=new TShallowframework();
		public var inputStr:String;
		public var uuid:String;
		
		public function FeedBackEvent(type:String,deepFrameWork:TDeepframework,shallowFrameWork:TShallowframework,uuid:String,inputStr:String):void{
			super(type);
			this.deepFrameWork=deepFrameWork;
			this.shallowFrameWork=shallowFrameWork;
			this.uuid=uuid;
			this.inputStr=inputStr;
			
		}
		public override function clone():flash.events.Event
		{
			return new FeedBackEvent(FEEDBACK,deepFrameWork,shallowFrameWork,uuid,inputStr);
		}

	}
}