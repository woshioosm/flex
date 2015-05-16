package cn.edu.whu.liesmars.asPack.util
{
	import mx.collections.ArrayCollection;

	public class DataInMenuObj
	{
		private var _data:String;
		private var _children:ArrayCollection=null;
		public function DataInMenuObj(_data:String=null)
		{
			_data=data;
		}

		public function get data():String
		{
			return _data;
		}

		public function set data(value:String):void
		{
			_data = value;
		}

		public function get children():ArrayCollection
		{
			return _children;
		}

		public function set children(value:ArrayCollection):void
		{
			_children = value;
		}


	}
}