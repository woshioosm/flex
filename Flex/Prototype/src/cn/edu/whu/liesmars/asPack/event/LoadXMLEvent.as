package cn.edu.whu.liesmars.asPack.event
{
	import flash.events.Event;

	public class LoadXMLEvent extends Event  // 暂时不用了额。。。。
	{
		public static const LOAD_XML:String="load_xml";
		
		public var xml:XML;           // 加载xml后获取xml
		public var str:String;        //加载xml后获取解析后的str
		public function LoadXMLEvent(xml:XML=null)
		{
			this.xml=xml;
			super(LOAD_XML);
		}
		public override function clone():flash.events.Event
		{
			return new LoadXMLEvent(xml);
		}
	}
}