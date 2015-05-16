package org.liesmars.flashwebclient.Index
{
	import org.liesmars.flashwebclient.SimpleVector.*;
	import org.liesmars.flashwebclient.GEOTYPES;
	
	public class GridIndex
	{
		// 左上角的坐标
		private var _LB_X:Number;
		private var _LB_Y:Number;
		// 右下角的坐标
		private var _RT_X:Number;
		private var _RT_Y:Number;
		// 所有数据的长、宽
		private var Height:Number;
		private var Width:Number;
		// 单元格宽度，默认的坐标系是经纬度
		private var _UNIT:Number = 1000;
		// 经度和纬度方向上的块的个数
		private var _WIDTH_BLOCKS:int;
		private var _HEIGHT_BLOCKS:int;
		// 要建立索引的矢量对象
		private var objs:Array;
		// 查询结果
		private var result:Array = new Array(4);
		//
		public var DataIndex:Array;
		
		public function GridIndex(x1:Number,y1:Number,x2:Number,y2:Number,arr:Array,unit:Number)
		{
			_LB_X = x1;
			_LB_Y = y1;
			_RT_X = x2;
			_RT_Y = y2;
			objs = arr;
			// 计算所有数据的长、宽
			Width = x2 - x1;
			Height = y2 - y1;
			_UNIT = unit;
			// 适用于各种投影转换
//			if(args){
//				switch(args[0]){
//					case "Mercator":
//						_UNIT = 1000;
//						break;
//					default:
//						
//				}
//			}
			// 计算块的个数
			if(Width%_UNIT==0){
				_WIDTH_BLOCKS = Width / _UNIT;
			}
			else{
				_WIDTH_BLOCKS = Width / _UNIT + 1;
			}
			if(Height%_UNIT==0){
				_HEIGHT_BLOCKS = Height / _UNIT;
			}
			else{
				_HEIGHT_BLOCKS = Height / _UNIT + 1;
			}
			// Util.GeoMapIndex = new Array(_WIDTH_BLOCKS * _HEIGHT_BLOCKS);
			DataIndex = new Array(_WIDTH_BLOCKS * _HEIGHT_BLOCKS);
		}
		
		public function createIndex():void{
			for(var i:int=0;i<objs.length;i++){
				var arr:Array = objs[i] as Array;
				for(var j:int=0;j<arr.length;j++){
					var shp:SVector = arr[j] as SVector;
					if(shp){
						switch(shp.geotype){
							case GEOTYPES.POINT :
								InsertPoint(shp);
								break;
							case GEOTYPES.LINE :
								InsertLine(shp);
								break;
							case GEOTYPES.MULTILINE :
								InsertMultiLine(shp);
								break;
							case GEOTYPES.POLYGON :
								InsertPolygon(shp);
								break;
							case GEOTYPES.MULTIPOLYGON :
								InsertMultiPolygon(shp);
								break;
							default:
								trace("Undefined Type...");
								return ;
						}
					}
				}
			}
		}
		
		public function get LB_X():Number{
			return this._LB_X;
		}
		public function get LB_Y():Number{
			return this._LB_Y
		}
		public function get RT_X():Number{
			return this._RT_X;
		}
		public function get RT_Y():Number{
			return this._RT_Y;
		}
		
		public function get WIDTH_BLOCKS():int{
			return this._WIDTH_BLOCKS;
		}
		public function get HEIGHT_BLOCKS():int{
			return this._HEIGHT_BLOCKS;
		}
		
		public function get UNIT():Number{
			return this._UNIT;
		}
		
		private function InsertPoint(shp:SVector):void{
			var coord:Array = shp.coords;
			var x:Number = coord[0];
			var y:Number = coord[1];
			
			if((x<=_RT_X || (x-_RT_X)<0.000001)&& (x>=_LB_X || (_LB_X - x)<0.000001)&& (y<=_RT_Y || (y - _RT_Y)<0.000001)&& (y>=_LB_Y || (_LB_Y - y)<0.000001)){
				var xIndex:int = Math.floor((x - _LB_X)/UNIT);
				var yIndex:int = Math.floor((y - _LB_Y)/UNIT);
				if(!(DataIndex[xIndex+yIndex*_WIDTH_BLOCKS] as Array)){
					DataIndex[xIndex+yIndex*_WIDTH_BLOCKS] = new Array();
				}
				DataIndex[xIndex+yIndex*_WIDTH_BLOCKS].push(shp);
			}
			else{
				trace("对象超出索引范围");
			}
		}
		
		private function InsertLine(shp:SVector):void{
			var bbox:Array = shp.bbox;
			if(bbox[1]<_LB_X || bbox[0]>_RT_X || bbox[2] > _RT_Y || bbox[3] < _LB_Y){
				trace("对象超出索引范围");
			}
			else{
				var xStartIndex:int = Math.floor((bbox[0] - _LB_X)/UNIT);
				var xEndIndex:int = Math.floor((bbox[1] - _LB_X)/UNIT);
				var yStartIndex:int = Math.floor((bbox[2] - _LB_Y)/UNIT);
				var yEndIndex:int = Math.floor((bbox[3] - _LB_Y)/UNIT);
				for(var i:int = xStartIndex;i<=xEndIndex;i++){
					for(var j:int = yStartIndex;j<=yEndIndex;j++){
						if(!(DataIndex[i+j*_WIDTH_BLOCKS] as Array)){
							DataIndex[i+j*_WIDTH_BLOCKS] = new Array();
						}
						DataIndex[i+j*_WIDTH_BLOCKS].push(shp);
					}
				}
			}
		}
		
		private function InsertMultiLine(shp:SVector):void{
			var bbox:Array = shp.bbox;
			if(bbox[1]<_LB_X || bbox[0]>_RT_X || bbox[2] > _RT_Y || bbox[3] < _LB_Y){
				trace("对象超出索引范围");
			}
			else{
				var xStartIndex:int = Math.floor((bbox[0] - _LB_X)/UNIT);
				var xEndIndex:int = Math.floor((bbox[1] - _LB_X)/UNIT);
				var yStartIndex:int = Math.floor((bbox[2] - _LB_Y)/UNIT);
				var yEndIndex:int = Math.floor((bbox[3] - _LB_Y)/UNIT);
				for(var i:int = xStartIndex;i<=xEndIndex;i++){
					for(var j:int = yStartIndex;j<=yEndIndex;j++){
						if(!(DataIndex[i+j*_WIDTH_BLOCKS] as Array)){
							DataIndex[i+j*_WIDTH_BLOCKS] = new Array();
						}
						DataIndex[i+j*_WIDTH_BLOCKS].push(shp);
					}
				}
			}
		}
		
		private function InsertPolygon(shp:SVector):void{
			var bbox:Array = shp.bbox;
			if(bbox[1]<_LB_X || bbox[0]>_RT_X || bbox[2] > _RT_Y || bbox[3] < _LB_Y){
				trace("对象超出索引范围");
			}
			else{
				var xStartIndex:int = Math.floor((bbox[0] - _LB_X)/UNIT);
				var xEndIndex:int = Math.floor((bbox[1] - _LB_X)/UNIT);
				var yStartIndex:int = Math.floor((bbox[2] - _LB_Y)/UNIT);
				var yEndIndex:int = Math.floor((bbox[3] - _LB_Y)/UNIT);
				for(var i:int = xStartIndex;i<=xEndIndex;i++){
					for(var j:int = yStartIndex;j<=yEndIndex;j++){
						if(!(DataIndex[i+j*_WIDTH_BLOCKS] as Array)){
							DataIndex[i+j*_WIDTH_BLOCKS] = new Array();
						}
						DataIndex[i+j*_WIDTH_BLOCKS].push(shp);
					}
				}
			}
		}
		
		private function InsertMultiPolygon(shp:SVector):void{
			var bbox:Array = shp.bbox;
			if(bbox[1]<_LB_X || bbox[0]>_RT_X || bbox[2] > _RT_Y || bbox[3] < _LB_Y){
				trace("对象超出索引范围");
			}
			else{
				var xStartIndex:int = Math.floor((bbox[0] - _LB_X)/UNIT);
				var xEndIndex:int = Math.floor((bbox[1] - _LB_X)/UNIT);
				var yStartIndex:int = Math.floor((bbox[2] - _LB_Y)/UNIT);
				var yEndIndex:int = Math.floor((bbox[3] - _LB_Y)/UNIT);
				for(var i:int = xStartIndex;i<=xEndIndex;i++){
					for(var j:int = yStartIndex;j<=yEndIndex;j++){
						if(!(DataIndex[i+j*_WIDTH_BLOCKS] as Array)){
							DataIndex[i+j*_WIDTH_BLOCKS] = new Array();
						}
						DataIndex[i+j*_WIDTH_BLOCKS].push(shp);
					}
				}
			}
		}
		
		public function getVectorsInArea(rt_x:Number,lb_x:Number,rt_y:Number,lb_y:Number):Array{
			if(rt_x < _LB_X || lb_x > _RT_X || rt_y < _LB_Y || lb_y > _RT_Y){
				return null;
			}
			else{
				result[0] = Math.floor(((lb_x-_LB_X)>0?(lb_x-_LB_X):0)/_UNIT);
				result[1] = Math.floor(((_RT_X-rt_x)>0?(rt_x-_LB_X):_WIDTH_BLOCKS*_UNIT)/_UNIT);
				result[2] = Math.floor(((lb_y-_LB_Y)>0?(lb_y-_LB_Y):0)/_UNIT);
				result[3] = Math.floor(((_RT_Y-rt_y)>0?(rt_y-_LB_Y):_HEIGHT_BLOCKS*_UNIT)/_UNIT);
				var objs:Array = new Array();
				for(var i:int=result[0];i<=result[1];i++){
					for(var j:int=result[2];j<=result[3];j++){
						var arr:Array = DataIndex[i+j*_WIDTH_BLOCKS] as Array;
						if(arr){
							for(var k:int=0;k<arr.length;k++){
								objs.push(arr[k]);
							}
						}
					}
				}
				return objs;
			}
		}
	}
}