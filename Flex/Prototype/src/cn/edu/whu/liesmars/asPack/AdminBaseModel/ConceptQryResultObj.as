package cn.edu.whu.liesmars.asPack.AdminBaseModel
{
	import mx.collections.ArrayCollection;

	public class ConceptQryResultObj
	{
		public function ConceptQryResultObj()
		{
		}
		protected var _conceptName:String="";
		protected var _conceptExists:String="";
		protected var _location:String="";
		protected var _children:ArrayCollection=null;
		
		public function get location():String
		{
			return _location;
		}

		public function set location(value:String):void
		{
			_location = value;
		}

		public function get conceptName():String
		{
			return _conceptName;
		}

		public function set conceptName(value:String):void
		{
			_conceptName = value;
		}

		public function get conceptExists():String
		{
			return _conceptExists;
		}

		public function set conceptExists(value:String):void
		{
			_conceptExists = value;
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