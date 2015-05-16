package org.liesmars.flashwebclient.Symbol
{
	import flash.display.Graphics;
	
	import org.liesmars.flashwebclient.GeoMap;
	import org.liesmars.flashwebclient.GeoShape;
	import org.liesmars.flashwebclient.Symbol;

	public class RectangularSymbol extends Symbol
	{
		public function RectangularSymbol(map:GeoMap,options:Object)
		{
			super(map,options);
		}
		public override function DrawRectangular(shp:GeoShape, arr:Array):void{
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
			
			g.beginFill(this._fillStyle._fillColor,this._fillStyle._fillAlpha);
			g.lineStyle(this._strokeStyle._thickness,this._strokeStyle._color,this._strokeStyle._alpha);
			g.drawRect(tmpArr[0],tmpArr[1],tmpArr[2]-tmpArr[0],tmpArr[3]-tmpArr[1]);
//			for(var i:Number=0;i<tmpArr.length-1;i+=2){
//				if(i==0)g.moveTo(tmpArr[i],tmpArr[i+1]);
//				else g.lineTo(tmpArr[i],tmpArr[i+1]);
//			}
			g.endFill();
		}
	}
}