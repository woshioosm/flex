package cn.edu.whu.liesmars.asPack.userBaseModel
{
	import valueObjects.SensorBandInfo;

	public class SensorChooseObj
	{
		
		protected var _checked:Boolean=false;
		protected var _sensorName:String="";
		protected var _sensorBandInfo:SensorBandInfo;
		public function SensorChooseObj()
		{
		}
		
		
		public function get sensorName():String
		{
			return _sensorName;
		}

		public function set sensorName(value:String):void
		{
			_sensorName = value;
		}

		public function get checked():Boolean
		{
			return _checked;
		}

		public function set checked(value:Boolean):void
		{
			_checked = value;
		}

		public function get sensorBandInfo():SensorBandInfo
		{
			return _sensorBandInfo;
		}

		public function set sensorBandInfo(value:SensorBandInfo):void
		{
			_sensorBandInfo = value;
		}

	}
}