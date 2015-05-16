package cn.edu.whu.liesmars.asPack.util
{
	public class PointOnMap
	{
		private var _id:int;
		private var _x:Number;
		private var _y:Number;
		public function PointOnMap()
		{
		}

		public function get y():Number
		{
			return _y;
		}

		public function set y(value:Number):void
		{
			_y = value;
		}

		public function get x():Number
		{
			return _x;
		}

		public function set x(value:Number):void
		{
			_x = value;
		}

		public function get id():int
		{
			return _id;
		}

		public function set id(value:int):void
		{
			_id = value;
		}

	}
}