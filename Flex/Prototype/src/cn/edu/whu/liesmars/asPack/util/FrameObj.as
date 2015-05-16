package cn.edu.whu.liesmars.asPack.util
{
	import mx.collections.ArrayCollection;

	public class FrameObj
	{
		private var _content:String="";   // 读取xml最底级内容值
		private var _changeContent:String="";   //修改后的xml最底级内容值 原content值不变
		private var _name:String="";      // 显示额标签值
		private var _canInput:Boolean=false;  //是否有输入框 
		private var _unit:String="";   // 单位
		private var _children:ArrayCollection=new ArrayCollection();  // 保存可以显示的children
		private var _unvisiableChildren:ArrayCollection=new ArrayCollection(); // 存在不可见的children 但是还是要保存下来 ==！
		private var _show:String="";
		private var _tagName:String="";
		
		public function FrameObj()
		{
		}

		public function get unit():String
		{
			return _unit;
		}

		public function set unit(value:String):void
		{
			_unit = value;
		}

		public function get unvisiableChildren():ArrayCollection
		{
			return _unvisiableChildren;
		}

		public function set unvisiableChildren(value:ArrayCollection):void
		{
			_unvisiableChildren = value;
		}

		public function get tagName():String
		{
			return _tagName;
		}

		public function set tagName(value:String):void
		{
			_tagName = value;
		}

		public function get show():String
		{
			return _show;
		}

		public function set show(value:String):void
		{
			_show = value;
		}

		public function get children():ArrayCollection
		{
			return _children;
		}

		public function set children(value:ArrayCollection):void
		{
			_children = value;
		}

		public function get canInput():Boolean
		{
			return _canInput;
		}

		public function set canInput(value:Boolean):void
		{
			_canInput = value;
		}

		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
		}

		public function get changeContent():String
		{
			return _changeContent;
		}

		public function set changeContent(value:String):void
		{
			_changeContent = value;
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