package cn.edu.whu.liesmars.asPack.event
{
	import flash.events.Event;

	public class LocateEvent extends Event
	{
		public static const  LOCATE:String="locate";   //查询完成
		public  var coords:String="";
		
		public function LocateEvent(type:String, coordsStr:String)
		{
			coords=coordsStr;
			super(type);
		}
		public override function clone():flash.events.Event
		{
			return new LocateEvent(type,coords);
		}
	}
}