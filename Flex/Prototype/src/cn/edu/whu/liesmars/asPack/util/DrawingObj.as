package cn.edu.whu.liesmars.asPack.util
{
	import mx.collections.ArrayCollection;

	public class DrawingObj
	{
		private var _id:String;
		private var _children:ArrayCollection=new ArrayCollection();

		public function DrawingObj()
		{
		}

		public function get children():ArrayCollection
		{
			return _children;
		}

		public function set children(value:ArrayCollection):void
		{
			_children = value;
		}

		public function get id():String
		{
			return _id;
		}

		public function set id(value:String):void
		{
			_id = value;
		}

	}
}