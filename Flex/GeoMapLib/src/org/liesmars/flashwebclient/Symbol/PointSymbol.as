package org.liesmars.flashwebclient.Symbol
{
	import flash.display.Graphics;
	import flash.geom.Point;
	import flash.text.TextField;
	
	import org.liesmars.flashwebclient.GeoMap;
	import org.liesmars.flashwebclient.GeoShape;
	import org.liesmars.flashwebclient.Symbol;
	import org.liesmars.flashwebclient.Util;		
				
	public class PointSymbol extends Symbol
	{
		//private static var arr:Array = new Array(2);
		public function PointSymbol(map:GeoMap,options:Object)
		{
			super(map,options)
		}
		
		public override function DrawPoint(shp:GeoShape, p:Point, radius:Number,name:String):void
		{
			var arr:Array = new Array(2);
			var g:Graphics = shp.graphics;
			arr[0] = p.x;	arr[1]= p.y;
			arr = PData(arr);
			
//			if(name && name!= ""){
//				var txt:TextField=new TextField();
//			    txt.text=name?name:"wangcheng";
//			    txt.textColor=0xff0000;//ff9966
//			    txt.height=txt.textHeight+5;
//			    txt.width=txt.textWidth+5;
//			    // 将文字绘制在点的旁边
//			    txt.x = arr[0]+8;
//			    txt.y = arr[1]-10;
//			    shp.addChild(txt);
//			}
			
			g.lineStyle(this._strokeStyle._thickness,0xff0000);
			g.beginFill(this._strokeStyle._color,this._strokeStyle._alpha);
			//g.drawCircle(p.x,p.y,Util.radius);
//			if(Util.UseSymbolization){
				g.drawCircle(arr[0],arr[1],5);
//			}
//			else{
//				g.moveTo(arr[0],arr[1]-10);
//				g.lineTo(arr[0]-8.5,arr[1]+5);
//				g.lineTo(arr[0]+8.5,arr[1]+5);
//			}
			g.endFill();
		}
		
		//non-regular points, used for the marker 
		public override function DrawMarker(shp:GeoShape, p:Point, size:Number,s:String):void
		{
			var g:Graphics = shp.graphics;
			
			var arr:Array = new Array();
			arr.push(p.x,p.y);
			arr = PData(arr);
			
			g.lineStyle(1,0x000000);
		    g.beginFill(0xf46c4d,1);
		    g.moveTo(arr[0],arr[1]);
		    g.lineTo(arr[0]-size/2,arr[1]-size);
		    g.curveTo(arr[0],arr[1]-size*2,arr[0]+size/2,arr[1]-size);
		    g.lineTo(arr[0],arr[1]);
		    g.endFill();
		    g.beginFill(0x000000,1);
		    g.drawCircle(arr[0],arr[1]-size,3);
		    g.endFill();
		}                                                                                                                                                                                                    
	}
}