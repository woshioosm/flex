package cn.edu.whu.liesmars.asPack.userBaseModel
{
	public class FileContent
	{
		private var _uuid:String="";
		private var _content:String;
		public function FileContent()
		{
			
		}

		public function get uuid():String
		{
			return _uuid;
		}

		public function set uuid(value:String):void
		{
			_uuid = value;
		}

		public function get content():String
		{
			return _content;
		}

		public function set content(value:String):void
		{
			_content = value;
		}

	}
}