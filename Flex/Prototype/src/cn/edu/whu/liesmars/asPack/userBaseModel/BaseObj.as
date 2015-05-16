package cn.edu.whu.liesmars.asPack.userBaseModel
{
	import cn.edu.whu.liesmars.asPack.util.DataInMenuObj;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;

	public class BaseObj
	{
		protected var _sequence:int;
		protected var _imageDate:ArrayCollection=new ArrayCollection();
		protected var _spacialResolution:ArrayCollection=new ArrayCollection();
		protected var _timeResolution:ArrayCollection=new ArrayCollection();
		protected var _spectrumResolution:ArrayCollection=new ArrayCollection();
		protected var _uuid:String="null";
		public function BaseObj(){
			
		}
//		public function BaseObj(id:int=-1,sequence:int=-1,imageDate:String=null,spacialResolution:String=null,timeResolution:String=null,spectrumResolution:String=null)
//		{
//			this.sequence=sequence;
//			this.imageDate=imageDate;	
//			this.spacialResolution=spacialResolution;
//			this.timeResolution=timeResolution;
//			this.spectrumResolution=spectrumResolution;
//			this.uuid=id;
//		}

		

		public function get imageDate():ArrayCollection
		{
			return _imageDate;
		}

		public function set imageDate(value:ArrayCollection):void
		{
			_imageDate = value;
		}

		public function get uuid():String
		{
			return _uuid;
		}

		public function set uuid(value:String):void
		{
			_uuid = value;
		}

		public function get spectrumResolution():ArrayCollection
		{
			return _spectrumResolution;
		}

		public function set spectrumResolution(value:ArrayCollection):void
		{
			_spectrumResolution = value;
		}

		public function get timeResolution():ArrayCollection
		{
			return _timeResolution;
		}

		public function set timeResolution(value:ArrayCollection):void
		{
			_timeResolution = value;
		}

		public function get spacialResolution():ArrayCollection
		{
			return _spacialResolution;
		}

		public function set spacialResolution(value:ArrayCollection):void
		{
			_spacialResolution = value;
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