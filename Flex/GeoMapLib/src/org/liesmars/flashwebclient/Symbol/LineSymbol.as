package org.liesmars.flashwebclient.Symbol
{
	import flash.display.Graphics;
	
	import mx.events.IndexChangedEvent;
	
	import org.liesmars.flashwebclient.Algorithm.LiangBarskyAlgorithm;
	import org.liesmars.flashwebclient.GeoMap;
	import org.liesmars.flashwebclient.GeoShape;
	import org.liesmars.flashwebclient.Symbol;
	import org.liesmars.flashwebclient.Util;
			
	public class LineSymbol extends Symbol
	{
		public function LineSymbol(map:GeoMap,options:Object)
		{
			super(map,options);
		}
		
		public override function DrawLine(shp:GeoShape,arr:Array):void
		{
			var g:Graphics=shp.graphics;
			
//			var tmpArr:Array = new Array();
//			for(var j:int =0;j<arr.length;j++){
//				tmpArr.push(arr[j]);
//			}
//			tmpArr = PData(tmpArr);
			
			var tmpArr:Array = null;
			if(shp.fromServer){
				tmpArr = arr;
			}
			else{
				tmpArr = new Array();
				for(var j:int =0;j<arr.length;j++){
				    tmpArr.push(arr[j]);
			    }
			}
			tmpArr = PData(tmpArr);
			
			if(Util.UseSymbolization){
				var rect:Array = new Array();
				rect.push(this.map.calculateBounds().left);
				rect.push(this.map.calculateBounds().top);
				rect.push(this.map.calculateBounds().right);
				rect.push(this.map.calculateBounds().bottom);
				rect = this.PData(rect);
				//画线性
				//var pl:PolyLine=new PolyLine(g,this._lineStyle.onLengthL,this._lineStyle.onLengthS,this._lineStyle.nS,this._lineStyle.offLength);
				var pl:PolyLine=new PolyLine(g,16,6,2,4);
				pl.lineStyle(4,0x233323,1);

				for(var i:Number=0;i<tmpArr.length-2;i=i+2){
					var drawData:Array = LiangBarskyAlgorithm.clip_liang_barsky(tmpArr[i],tmpArr[i+1],tmpArr[i+2],tmpArr[i+3],rect);
					if(drawData && drawData.length == 4){
						pl.moveTo(drawData[0],drawData[1]);
						pl.lineTo(drawData[2],drawData[3]);
					}
				}	
			}
			else{
				//不画线性
				g.lineStyle(this._strokeStyle._thickness,this._strokeStyle._color,this._strokeStyle._alpha);
				for(var i:Number=0;i<tmpArr.length-1;i+=2){
					if(i==0)g.moveTo(tmpArr[i],tmpArr[i+1]);
					else g.lineTo(tmpArr[i],tmpArr[i+1]);
				}
			}
            
			tmpArr = null;
		}
		
		public override function DrawMultiLine(shp:GeoShape, json:Array):void{
			for(var i:int = 0;i<json.length;i++){
				var arr:Array = json[i] as Array;
				var test:Array = null;
				test = arr[0] as Array;
				if(test){
					DrawMultiLine(shp,arr);
					test = null;
				}
				else{
					DrawLine(shp,arr);
				}
			}
		}
		
	}
}