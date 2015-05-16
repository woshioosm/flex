package cn.edu.whu.liesmars.asPack.AdminBaseModel
{
	import mx.collections.ArrayCollection;
	import cn.edu.whu.liesmars.asPack.userBaseModel.BaseObj;

	public class ProductSeperateObj extends BaseObj
	{
		protected var _productId:String;
		protected var _field:String;
		protected var _task:String;
		protected var _imageArea:ArrayCollection=new ArrayCollection();
		public function ProductSeperateObj(){
			
		}
//		public function ProductSeperateObj(id:int=-1,sequence:int=-1,productId:String=null,field:String=null,task:String=null,imageDate:String=null,imageArea:String=null,spacialResolution:String=null,timeResolution:String=null,spectrumResolution:String=null)
//		{
//			this.productId=productId;
//			this.field=field;
//			this.task=task;
//			this.imageArea=imageArea;
//			super(id,sequence,imageDate,spacialResolution,timeResolution,spectrumResolution);
//		}

		

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

		public function get field():String
		{
			return _field;
		}

		public function set field(value:String):void
		{
			_field = value;
		}

		public function get productId():String
		{
			return _productId;
		}

		public function set productId(value:String):void
		{
			_productId = value;
		}

	}
}