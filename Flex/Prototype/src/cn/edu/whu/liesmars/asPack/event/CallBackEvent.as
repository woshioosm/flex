package cn.edu.whu.liesmars.asPack.event
{
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;

	public class CallBackEvent extends Event
	{
		public static const  OK_CLICK:String="ok";
		public static const CANCEL_CLICK:String="cancel";
		
		public var callBackArr:ArrayCollection;
		public var  callBackString:String;
		public function CallBackEvent(type:String,callBackArr:ArrayCollection)
		{
			super(type);
			this.callBackArr=callBackArr;
		}
		
	}
}