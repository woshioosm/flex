package org.liesmars.flashwebclient.Symbol
{
	import flash.display.Graphics;
	import flash.geom.Point;
	import flash.text.TextField;
	
	import org.liesmars.flashwebclient.Algorithm.LiangBarskyAlgorithm;
	import org.liesmars.flashwebclient.GeoMap;
	import org.liesmars.flashwebclient.GeoShape;
	import org.liesmars.flashwebclient.Layer.*;
	import org.liesmars.flashwebclient.Symbol;
	import org.liesmars.flashwebclient.Util;
		
	public class Default extends Symbol
	{
		
		public function Default(map:GeoMap,options:Object)
		{
			super(map,options);
		}
		public override function DrawPoint(shp:GeoShape, p:Point, radius:Number,name:String):void
		{
			var g:Graphics = shp.graphics;
			
			var arr:Array = new Array();
			arr.push(p.x,p.y);
			arr = PData(arr);
			
			if(name && name!= ""){
				var txt:TextField=new TextField();
			    txt.text=name?name:"wangcheng";
			    txt.textColor=0xff0000;//ff9966
			    txt.height=txt.textHeight+5;
			    txt.width=txt.textWidth+5;
			    // 将文字绘制在点的旁边
			    txt.x = arr[0]+8;
			    txt.y = arr[1]-10;
			    shp.addChild(txt);
			}
			
			g.lineStyle(1,0xff0000);
			g.beginFill(Util.color.point,Util.transLevel.point);
			//g.drawCircle(p.x,p.y,Util.radius);
			if(Util.UseSymbolization){
//				g.moveTo(arr[0],arr[1]-8);
//				g.lineTo(arr[0]-6.8,arr[1]+4);
//				g.lineTo(arr[0]+6.8,arr[1]+4);
				g.moveTo(arr[0],arr[1]+6);
				
			}
			else{
				g.drawCircle(arr[0],arr[1],Util.radius);
			}
			g.endFill();
		}
		
		public override function DrawLine(shp:GeoShape,arr:Array):void
		{
			//var d1:Date = new Date();
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
			//var d3:Date = new Date();
			tmpArr = PData(tmpArr);
			//var d4:Date = new Date();
			
			if(Util.UseSymbolization){
				//画线性
				//var pl:PolyLine=new PolyLine(g,this._lineStyle.onLengthL,this._lineStyle.onLengthS,this._lineStyle.nS,this._lineStyle.offLength);
				var pl:PolyLine=new PolyLine(g,16,6,2,4);
				pl.lineStyle(4,0x233323,1);
				var rect:Array = new Array();
				rect.push(this.map.calculateBounds().left);
				rect.push(this.map.calculateBounds().top);
				rect.push(this.map.calculateBounds().right);
				rect.push(this.map.calculateBounds().bottom);
				rect = this.PData(rect);

				for(var i:Number=0;i<tmpArr.length-2;i=i+2){
//					if(i==0)pl.moveTo(tmpArr[i],tmpArr[i+1]);
//					else pl.lineTo(tmpArr[i],tmpArr[i+1]);
					var drawData:Array = LiangBarskyAlgorithm.clip_liang_barsky(tmpArr[i],tmpArr[i+1],tmpArr[i+2],tmpArr[i+3],rect);
					if(drawData){
						if(drawData.length == 4){
							pl.moveTo(drawData[0],drawData[1]);
							pl.lineTo(drawData[2],drawData[3]);
						}
					}
				}
			}
			else{
				//不画线性
				//g.lineStyle(this._strokeStyle._thickness,this._strokeStyle._color,this._strokeStyle._alpha);
				g.lineStyle(3,0x0000ff,1);
				for(var i:Number=0;i<tmpArr.length-1;i+=2){
					if(i==0)g.moveTo(tmpArr[i],tmpArr[i+1]);
					else g.lineTo(tmpArr[i],tmpArr[i+1]);
				}
			}
		}
		public override function DrawPolygon(shp:GeoShape,arr:Array):void
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
			
			g.beginFill(Util.color.polygon,Util.transLevel.polygon);
			g.lineStyle(2,0x555555,1);
			for(var i:Number=0;i<tmpArr.length-1;i+=2){
				if(i==0)g.moveTo(tmpArr[i],tmpArr[i+1]);
				else g.lineTo(tmpArr[i],tmpArr[i+1]);
			}
			g.endFill();	
			
		}
		public override function DrawMultiLine(shp:GeoShape, arr:Array):void
		{
			var g:Graphics=shp.graphics;
			g.lineStyle(Util.thick.line,Util.color.line,Util.transLevel.line);			
			
			for(var i:int=0;i<arr.length;i++)
			{
				var a:Array=arr[i] as Array;
				g.lineStyle(Util.thick.line+1,0x000000,Util.transLevel.line);
				for(var j:int=0;j<a.length-1;j+=2)
				{
					if(j==0)g.moveTo(a[j],a[j+1]);
					else g.lineTo(a[j],a[j+1]);
				}
				g.lineStyle(Util.thick.line,Util.color.line,Util.transLevel.line);
				for(var j:int=0;j<a.length-1;j+=2)
				{
					if(j==0)g.moveTo(a[j],a[j+1]);
					else g.lineTo(a[j],a[j+1]);
				}
			}
		}
		public override function DrawMultiPolygon(shp:GeoShape, json:Array):void
		{
			var g:Graphics=shp.graphics;
			//g.lineStyle(Util.thick.line,Util.color.line,Util.transLevel.line);
			g.lineStyle(2,0x555555,1);
			g.beginFill(Util.color.polygon,Util.transLevel.polygon);
			var arr:Array=json;
			for(var i:int=0;i<arr.length;i++)
			{
				var a:Array=arr[i] as Array;
				var tmpArr:Array = new Array();
				for(var j:int =0;j<a.length;j++){
					tmpArr.push(a[j]);
				}
				tmpArr = PData(tmpArr);
				for(var j:int=0;j<tmpArr.length-1;j+=2)
				{
					if(j==0)g.moveTo(tmpArr[j],tmpArr[j+1]);
					else g.lineTo(tmpArr[j],tmpArr[j+1]);
				}
			}
			g.endFill();
		}
		
	}

}