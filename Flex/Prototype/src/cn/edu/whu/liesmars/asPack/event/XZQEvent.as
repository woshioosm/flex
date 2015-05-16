package cn.edu.whu.liesmars.asPack.event
{
	import flash.events.Event;

	public class XZQEvent extends Event
	{
		public static const XZQCHOOSEDONE="XZQChooseDone";
		
		public var XZQName:String="";
		public var XZQLayer:String="";
		public var XZQFeacode:String="";
		public function XZQEvent(type:String,XZQName:String,XZQLayer:String,XZQFeacode:String)
		{
			super(type);
			this.XZQName=XZQName;
			this.XZQLayer=XZQLayer;
			this.XZQFeacode=XZQFeacode;
		}
		public override function clone():flash.events.Event
		{
			return new XZQEvent(type,XZQName,XZQLayer,XZQFeacode);
		}
	}
}