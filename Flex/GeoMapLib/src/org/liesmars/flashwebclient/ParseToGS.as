package org.liesmars.flashwebclient
{
	public class ParseToGS
	{
		public function ParseToGS(map:GeoMap, obj:Object)
		
		
		/**
		 * 传入的对象可能是GML、GeoJSON或者AMF
		 * 将传入的对象均转为GeoShape对象
		 * 也就是将对象的解析从Symbol中提出来,Symbol只负责绘制
		*/
		public function Parse():Object{return null;}

	}
}