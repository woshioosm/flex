package org.liesmars.flashwebclient.Symbol
{
	import flash.display.Graphics;
	
	import org.liesmars.flashwebclient.Algorithm.LiangBarskyAlgorithm;
	import org.liesmars.flashwebclient.GeoMap;
	import org.liesmars.flashwebclient.GeoShape;
	import org.liesmars.flashwebclient.Symbol;
	import org.liesmars.flashwebclient.Util;

	public class RailwaySymbol extends Symbol
	{
		public function RailwaySymbol(map:GeoMap, options:Object)
		{
			super(map, options);
		}
		
		public override function DrawLine(shp:GeoShape,arr:Array):void
		{
			var g:Graphics=shp.graphics;
			
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
				g.lineStyle(6,0x000000,1);
				
				var data:Array = new Array();
				for(var i:Number=0;i<tmpArr.length-2;i=i+2){
					var drawData:Array = LiangBarskyAlgorithm.clip_liang_barsky(tmpArr[i],tmpArr[i+1],tmpArr[i+2],tmpArr[i+3],rect);
					if(drawData && drawData.length == 4){
						data.push(drawData[0]);
						data.push(drawData[1]);
						data.push(drawData[2]);
						data.push(drawData[3]);
					}
				}
				for(var i:Number=0;i<data.length;i=i+4){
					g.moveTo(data[i],data[i+1]);
					g.lineTo(data[i+2],data[i+3]);
				}
				var pl:DashLine = new DashLine(g,this._lineStyle.onLengthL,this._lineStyle.offLength);
				//var pl:PolyLine=new PolyLine(g,this._lineStyle.onLengthL,this._lineStyle.onLengthS,this._lineStyle.nS,this._lineStyle.offLength);
				pl.lineStyle(this._strokeStyle._thickness,this._strokeStyle._color,this._strokeStyle._alpha);
				for(var i:Number=0;i<data.length;i=i+4){
					pl.moveTo(data[i],data[i+1]);
					pl.lineTo(data[i+2],data[i+3]);
				}
			}
			else{
				g.lineStyle(6,0x000000,1);
				for(var i:Number=0;i<tmpArr.length-1;i+=2){
					if(i==0){
						g.moveTo(tmpArr[i],tmpArr[i+1]);
					}
					else {
						g.lineTo(tmpArr[i],tmpArr[i+1]);
					}
				}
				
				var pl:DashLine = new DashLine(g,this._lineStyle.onLengthL,this._lineStyle.offLength);
				//var pl:PolyLine=new PolyLine(g,this._lineStyle.onLengthL,this._lineStyle.onLengthS,this._lineStyle.nS,this._lineStyle.offLength);
				pl.lineStyle(this._strokeStyle._thickness,this._strokeStyle._color,this._strokeStyle._alpha);
				for(var i:Number=0;i<tmpArr.length-1;i+=2){
					if(i==0){
						pl.moveTo(tmpArr[i],tmpArr[i+1]);
					}
					else {
						pl.lineTo(tmpArr[i],tmpArr[i+1]);
					}
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