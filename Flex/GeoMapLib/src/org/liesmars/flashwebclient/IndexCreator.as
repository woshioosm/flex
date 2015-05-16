package org.liesmars.flashwebclient
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	import org.liesmars.flashwebclient.GeoEvent.IndexEvent;
	import org.liesmars.flashwebclient.Index.GridIndex;
	import org.liesmars.flashwebclient.Layer.Vector;
	import org.liesmars.flashwebclient.Parser.AMFObjectToSV;
	
	public class IndexCreator
	{
		var map:GeoMap;
		
		// vecs 表示所有的矢量图层
		private var vecs:Array = new Array();
		// names 表示所有矢量图层的名字
		private var names:Array = new Array();
		
		public function IndexCreator(geomap:GeoMap)
		{
			this.map = geomap;
		}
		
		public function createIndexForAllLayers():void{
			for(var i:int=0;i<this.map.layers.length;i++){
				if(this.map.layers[i] is Vector){
					var vec:Vector = this.map.layers[i] as Vector;
					names.push(vec.layername.substring(6,vec.layername.length));
					vecs.push(vec);
				}
			}
			for(var j:int=0;j<vecs.length;j++){
				var vec:Vector = vecs[j];
				var request:String = vec.getFullRequestString(new Object());
				this.LoadAllData(request);
			}
		}
		
		private function LoadAllData(request:String):void{
			var loader:URLLoader=new URLLoader();
	    	var urlrequest:URLRequest = new URLRequest(request);
	    	loader.dataFormat = URLLoaderDataFormat.BINARY;
	    	loader.addEventListener(Event.COMPLETE,completeHandler);
	    	loader.load(urlrequest);
		}
		
		// 所有的数据读到客户端的处理函数
		private function completeHandler(event:Event):void{
			trace("completeHandler invoked!");
	    	if(!event.target.data) {
				trace("event target data is null");
				return;
			}
			
			var byte:ByteArray = event.target.data as ByteArray;
        	var res:Array = byte.readObject() as Array;
        	var amfobj:Array = res.slice(0,res.length-1);
        	var obj:Object = res.pop();
        	var bbox:Array = obj.bbox;
        	var layername:String = obj.layername;

        	var parser:AMFObjectToSV = new AMFObjectToSV(this.map,amfobj);
			var shps:Array = parser.Parse() as Array;
			// 建立该图层的索引
			var unit:Number = (bbox[1] - bbox[0])/10;
			var index:GridIndex = new GridIndex(bbox[0],bbox[2],bbox[1],bbox[3],shps,unit);
			var d1:Date = new Date();
			index.createIndex();
			var d2:Date = new Date();
			trace("The time cost for build index is :",d2.getTime() - d1.getTime());
			for(var i:int=0;i<vecs.length;i++){
				if(layername.indexOf(names[i])>=0){
					vecs[i].index = index;
				}
			}
			// 判断是否所有的图层的索引都建立完成
			if(allIndexCreated()){
				// 如果所有图层的索引都建立完成，则派发事件通知
				this.map.sprite.dispatchEvent(new IndexEvent());
			}
		}
		
		//判断是否所有的图层都有索引
		public function allIndexCreated():Boolean{
			for(var i:int=0;i<this.map.layers.length;i++){
				if(this.map.layers[i] is Vector){
					var tmp:Vector = this.map.layers[i];
					if(!tmp.index){
						return false;
					}
				}
			}
			return true;
		}   
	}
}