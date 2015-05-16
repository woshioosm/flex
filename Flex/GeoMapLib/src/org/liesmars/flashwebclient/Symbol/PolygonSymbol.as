package org.liesmars.flashwebclient.Symbol
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.liesmars.flashwebclient.GeoMap;
	import org.liesmars.flashwebclient.GeoShape;
	import org.liesmars.flashwebclient.Symbol;

	public class PolygonSymbol extends Symbol
	{
		public function PolygonSymbol(map:GeoMap,options:Object)
		{
			super(map,options);
		}
        public function onClick(e:MouseEvent):void{
	
        }
		public override function DrawPolygon(shp:GeoShape, arr:Array):void
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

			g.beginFill(this._fillStyle._fillColor,this._fillStyle._fillAlpha);
			g.lineStyle(this._strokeStyle._thickness,this._strokeStyle._color,this._strokeStyle._alpha);
			for(var i:Number=0;i<tmpArr.length-1;i+=2){
				if(i==0)g.moveTo(tmpArr[i],tmpArr[i+1]);
				else g.lineTo(tmpArr[i],tmpArr[i+1]);
			}
			g.endFill();
		}
		public override function DrawPolygon2(shp:GeoShape, arr:Array):void
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
			
//			g.beginFill(this._fillStyle._fillColor,this._fillStyle._fillAlpha);
			var color:uint=0;
			if(shp.colorCode==0){
				color=this._strokeStyle._color;
			}
			else{
				color=0xff0000;
			}
			g.lineStyle(this._strokeStyle._thickness,color,this._strokeStyle._alpha);
			for(var i:Number=0;i<tmpArr.length-1;i+=2){
				if(i==0)g.moveTo(tmpArr[i],tmpArr[i+1]);
				else g.lineTo(tmpArr[i],tmpArr[i+1]);
			}
//			g.endFill();
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
		public override function DrawMultiPolygon(shp:GeoShape, json:Array):void{
			for(var i:int = 0;i<json.length;i++){
				var arr:Array = json[i] as Array;
				var test:Array = null;
				test = arr[0] as Array;
				if(test){
					DrawMultiPolygon(shp,arr);
					test = null;
				}
				else{
					DrawPolygon(shp,arr);
				}
			}
		}
		
		
		    
		          

	}
}