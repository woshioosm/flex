package cn.edu.whu.liesmars.asPack.util
{
	import mx.collections.ArrayCollection;

	public class ListUtil
	{
		public function ListUtil()
		{
		}
		public static function ListToString(arr:ArrayCollection):String{
			var listStr:String="";
			for each(var str:String in arr){
				listStr+=str+"\n";
			}
			return listStr;
		}
	}
}