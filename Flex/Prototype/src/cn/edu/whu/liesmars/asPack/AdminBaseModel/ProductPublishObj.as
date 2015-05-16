package cn.edu.whu.liesmars.asPack.AdminBaseModel
{
	import mx.collections.ArrayCollection;

	public class ProductPublishObj
	{
		protected var  _sequence:int;
		protected var _productID:String="";
		protected var _department:String="";
		protected var _userName:String="";
		protected var _uuid:int;
		protected var _accept:String="";
		protected var _similarityValues:ArrayCollection=new ArrayCollection();
		protected var _bandInfo:String="";
		
		private var  _imageUrl:String="";
		protected var _time:String="";
		protected var _sensor:String="";
		private var _sensorName:String="";
		protected var _spatialResolution:String="";
		protected var _arr:ArrayCollection=new ArrayCollection();
//		public function ProductPublishObj(id:int=-1,sequence:int=-1,productID:String=null,department:String=null,userName:String=null)
//		{
//			this.sequence=sequence;
//			this.productID=productID;
//			this.department=department;
//			this.userName=userName;
//			this.id=id;
//		}

		public function get sensorName():String
		{
			return _sensorName;
		}

		public function set sensorName(value:String):void
		{
			_sensorName = value;
		}

		public function get imageUrl():String
		{
			return _imageUrl;
		}

		public function set imageUrl(value:String):void
		{
			_imageUrl = value;
		}

		public function get bandInfo():String
		{
			return _bandInfo;
		}

		public function set bandInfo(value:String):void
		{
			_bandInfo = value;
		}

		public function get arr():ArrayCollection
		{
			return _arr;
		}

		public function set arr(value:ArrayCollection):void
		{
			_arr = value;
		}

		public function get spatialResolution():String
		{
			return _spatialResolution;
		}

		public function set spatialResolution(value:String):void
		{
			_spatialResolution = value;
		}

		public function get sensor():String
		{
			return _sensor;
		}

		public function set sensor(value:String):void
		{
			_sensor = value;
		}

		public function get time():String
		{
			return _time;
		}

		public function set time(value:String):void
		{
			_time = value;
		}

		public function get similarityValues():ArrayCollection
		{
			return _similarityValues;
		}

		public function set similarityValues(value:ArrayCollection):void
		{
			_similarityValues = value;
		}

		public function get accept():String
		{
			return _accept;
		}

		public function set accept(value:String):void
		{
			_accept = value;
		}

		public function get uuid():int
		{
			return _uuid;
		}

		public function set uuidid(value:int):void
		{
			_uuid = value;
		}

		public function get userName():String
		{
			return _userName;
		}

		public function set userName(value:String):void
		{
			_userName = value;
		}

		public function get department():String
		{
			return _department;
		}

		public function set department(value:String):void
		{
			_department = value;
		}

		public function get productID():String
		{
			return _productID;
		}

		public function set productID(value:String):void
		{
			_productID = value;
		}

		public function get sequence():int
		{
			return _sequence;
		}

		public function set sequence(value:int):void
		{
			_sequence = value;
		}

	}
}