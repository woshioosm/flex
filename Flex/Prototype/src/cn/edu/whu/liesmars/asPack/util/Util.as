package cn.edu.whu.liesmars.asPack.util
{
	import mx.formatters.DateFormatter;

	public class Util
	{
		public function Util()
		{
		}
        public static function getTime():String{
			var dateFormatter:DateFormatter = new DateFormatter();    
			dateFormatter.formatString = "YYYY年MM月DD日";   
			var date:Date=new Date();
			var thisDate:String = dateFormatter.format(date);  
			
			var currentTime:String=date.toLocaleTimeString();
			return thisDate+" "+currentTime;
		}
	}
}