package cn.edu.whu.liesmars.asPack.AdminBaseModel
{
	public class SuggestionDetailObj
	{
		public function SuggestionDetailObj()
		{
		}
		protected var _typeName:String;
		protected var _productParam:String;
		protected var _taskParam:String;
		protected var _similarity:String;
		
		public function get similarity():String
		{
			return _similarity;
		}

		public function set similarity(value:String):void
		{
			_similarity = value;
		}

		public function get taskParam():String
		{
			return _taskParam;
		}

		public function set taskParam(value:String):void
		{
			_taskParam = value;
		}

		public function get productParam():String
		{
			return _productParam;
		}

		public function set productParam(value:String):void
		{
			_productParam = value;
		}

		public function get typeName():String
		{
			return _typeName;
		}

		public function set typeName(value:String):void
		{
			_typeName = value;
		}

	}
}