package com.poyanghu.interaction.query
{
	/**
	 * 反映系统中两种模式，一种是行政区模式，返回均为行政区，而另一种是精确的基于坐标模式
	 * 其返回的是公里格网的数据信息
	 */ 
	public class QueryMode
	{
		
		public static const NONE:int = 0;
		public static const DISTRICT:int = 1;
		public static const COORDINATE:int = 2;
		public static const TIMESERIES:int = 3;
		public static const TIMESERIES_DISTRICT:int = 4;
		public static const POI:int = 5;
		
	}
}