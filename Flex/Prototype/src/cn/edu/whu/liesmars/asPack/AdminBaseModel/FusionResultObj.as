package cn.edu.whu.liesmars.asPack.AdminBaseModel
{
	import cn.edu.whu.liesmars.asPack.userBaseModel.BaseObj;
	
	import mx.collections.ArrayCollection;

	public class FusionResultObj extends BaseObj
	{
		protected var _imageWidth:ArrayCollection=new ArrayCollection();
		protected var _imageArea:ArrayCollection=new ArrayCollection();

		protected var _task:String="";
		protected var _sensorName:String="";
		protected var _sensorType:String="";
		
		public function FusionResultObj(){
			super();
		}
//		public function MixResultObj(id:int=-1,sequence:int=-1,imageDate:String=null,imageWidth:String=null,spacialResolution:String=null,timeResolution:String=null,spectrumResolution:String=null)
//		{
//			this.imageWidth=imageWidth;
//			super(id,sequence,imageDate,spacialResolution,timeResolution,spectrumResolution);
//		}

		

		

		public function get sensorType():String
		{
			return _sensorType;
		}

		public function set sensorType(value:String):void
		{
			_sensorType = value;
		}

		public function get sensorName():String
		{
			return _sensorName;
		}

		public function set sensorName(value:String):void
		{
			_sensorName = value;
		}

		public function get task():String
		{
			return _task;
		}

		public function set task(value:String):void
		{
			_task = value;
		}

		public function get imageArea():ArrayCollection
		{
			return _imageArea;
		}

		public function set imageArea(value:ArrayCollection):void
		{
			_imageArea = value;
		}

		public function get imageWidth():ArrayCollection
		{
			return _imageWidth;
		}

		public function set imageWidth(value:ArrayCollection):void
		{
			_imageWidth = value;
		}

	}
}