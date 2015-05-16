package cn.edu.whu.liesmars.asPack.AdminBaseModel
{
	import mx.collections.ArrayCollection;

	public class PageResult
	{
		
		protected var _result:ArrayCollection=new ArrayCollection();
		protected var _curPage:int;
		
		public function PageResult()
		{
		}

		public function get result():ArrayCollection
		{
			return _result;
		}

		public function set result(value:ArrayCollection):void
		{
			_result = value;
		}

		public function get curPage():int
		{
			return _curPage;
		}

		public function set curPage(value:int):void
		{
			_curPage = value;
		}

	}
}