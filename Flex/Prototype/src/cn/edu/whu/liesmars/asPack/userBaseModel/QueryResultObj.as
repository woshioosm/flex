package cn.edu.whu.liesmars.asPack.userBaseModel
{
	import mx.collections.ArrayCollection;
	
	import valueObjects.AdvancedFrame;
	import valueObjects.PrimaryFrame;

	public class QueryResultObj extends BaseObj
	{
		public function QueryResultObj(){
			
		}
//		public function QueryResultObj(sequence:int=-1, queryTime:String=null,field:String=null,imageDate:String=null,imageArea:String=null,spacialResolution:String=null,timeResolution:String=null,spectrumResolution:String=null,id:int=-1)
//		{
//			this.queryTime=queryTime;
//			this.field=field;
//			this.imageArea=imageArea;
//			super(id,sequence,imageDate,spacialResolution,timeResolution,spectrumResolution);
//		}
		
		protected var _queryTime:String;
		protected var _field:String;
		protected var _imageArea:ArrayCollection=new ArrayCollection();
		protected var _deepFrame:String;
		protected var _shallowFrame:String;
		protected var _inputStr:String;

		private var _advancedFrame:AdvancedFrame=null; // 最初前后台框架都是用xml交换的 后来才有的后台把xml转换成类  所以后来也用类
		private var _primaryFrame:PrimaryFrame=null;
        private var _sensors:ArrayCollection=new ArrayCollection();
		
		public function get sensors():ArrayCollection
		{
			return _sensors;
		}

		public function set sensors(value:ArrayCollection):void
		{
			_sensors = value;
		}

		public function get primaryFrame():PrimaryFrame
		{
			return _primaryFrame;
		}

		public function set primaryFrame(value:PrimaryFrame):void
		{
			_primaryFrame = value;
		}

		public function get advancedFrame():AdvancedFrame
		{
			return _advancedFrame;
		}

		public function set advancedFrame(value:AdvancedFrame):void
		{
			_advancedFrame = value;
		}

		public function get inputStr():String
		{
			return _inputStr;
		}

		public function set inputStr(value:String):void
		{
			_inputStr = value;
		}

		public function get shallowFrame():String
		{
			return _shallowFrame;
		}

		public function set shallowFrame(value:String):void
		{
			_shallowFrame = value;
		}

		public function get deepFrame():String
		{
			return _deepFrame;
		}

		public function set deepFrame(value:String):void
		{
			_deepFrame = value;
		}

		public function get imageArea():ArrayCollection
		{
			return _imageArea;
		}

		public function set imageArea(value:ArrayCollection):void
		{
			_imageArea = value;
		}

		public function get field():String
		{
			return _field;
		}

		public function set field(value:String):void
		{
			_field = value;
		}

		public function get queryTime():String
		{
			return _queryTime;
		}

		public function set queryTime(value:String):void
		{
			_queryTime = value;
		}

	}
}