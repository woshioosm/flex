package cn.edu.whu.liesmars.asPack.util
{
	public class Coordinate
	{
		private　var _lon:String;
		private var _lat:String;
		private var _uuid:String="null";
		public function Coordinate(lon:String,lat:String)
		{
			this._lat=lat;
			this.lon=lon;
		}

		public function get uuid():String
		{
			return _uuid;
		}

		public function set uuid(value:String):void
		{
			_uuid = value;
		}

		public function get lat():String
		{
			return _lat;
		}

		public function set lat(value:String):void
		{
			_lat = value;
		}

		public function get lon():String
		{
			return _lon;
		}

		public function set lon(value:String):void
		{
			_lon = value;
		}

	}
}