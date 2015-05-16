package cn.edu.whu.liesmars.asPack.componentsData
{
	import mx.collections.ArrayCollection;

	public class DataHandler
	{
		protected var dataFromServer:Object=new Object(); //其中存放的类型为TDeepframework
		public function DataHandler(result:Object)
		{
			dataFromServer=result;
		}
		public function bindData(bindingData:ArrayCollection):void{  //获得数据绑定到控件对应的ArrayColletion
			
		}
	
	}
}