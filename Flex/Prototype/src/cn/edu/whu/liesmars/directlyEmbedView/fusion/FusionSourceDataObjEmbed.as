package cn.edu.whu.liesmars.directlyEmbedView.fusion
{
	import cn.edu.whu.liesmars.asPack.userBaseModel.BaseObj;
	
	import mx.collections.ArrayCollection;
	
	public class FusionSourceDataObjEmbed extends BaseObj
	{
		protected var _naturalLang:String;
		protected var _sensorType:String;
		protected var _sensorName:String;
		protected var _task:String;
		protected var _imageArea:ArrayCollection=new ArrayCollection();
		protected var _srcUUID:String;
		
		public function FusionSourceDataObjEmbed()
		{
			super();
		}
		
		public function get srcUUID():String
		{
			return _srcUUID;
		}
		
		public function set srcUUID(value:String):void
		{
			_srcUUID = value;
		}

		public function get imageArea():ArrayCollection
		{
			return _imageArea;
		}

		public function set imageArea(value:ArrayCollection):void
		{
			_imageArea = value;
		}

		public function get task():String
		{
			return _task;
		}

		public function set task(value:String):void
		{
			_task = value;
		}

		public function get sensorName():String
		{
			return _sensorName;
		}

		public function set sensorName(value:String):void
		{
			_sensorName = value;
		}

		public function get sensorType():String
		{
			return _sensorType;
		}

		public function set sensorType(value:String):void
		{
			_sensorType = value;
		}

		public function get naturalLang():String
		{
			return _naturalLang;
		}

		public function set naturalLang(value:String):void
		{
			_naturalLang = value;
		}

	}
}