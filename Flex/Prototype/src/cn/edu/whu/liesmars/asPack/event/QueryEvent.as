package cn.edu.whu.liesmars.asPack.event
{
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	import valueObjects.NLSearchResultWithTime;

	public class QueryEvent extends Event
	{
		
		public static const  COMPLETE:String="query_complete";   //查询完成
		public static const QUERYHISTORY_START:String="queryHistory_Start"; //发出事件 要求进行历史查询
		public static const USER_SUGGESTION_START:String="user_suggestion_start"; //发出事件 要求 获取推荐结果
		public static const PRODUCT_PUBLISH:String="product_publish";  // 获取 模拟产品发布
		public var result:NLSearchResultWithTime;
		public var resultArray:ArrayCollection=new ArrayCollection();
		public function QueryEvent(type:String,queryResult:NLSearchResultWithTime,queryResultArr:ArrayCollection)
		{
			super(type);
			this.result=queryResult;
			this.resultArray=resultArray;
		}
		public override function clone():flash.events.Event
		{
			return new QueryEvent(type,result,resultArray);
		}

	}
}