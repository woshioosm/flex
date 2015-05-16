package org.liesmars.flashwebclient.Handler 
{
	//点击时候才进入编辑状态，mouseover之类的只表示选取了
	
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;	
	import org.liesmars.flashwebclient.Handler;
	import org.liesmars.flashwebclient.GeoMap;
	import org.liesmars.flashwebclient.GeoShape;	
	import org.liesmars.flashwebclient.BaseTypes.*;
	
	/*
	 *矢量的编辑 
	 */
	public class Edit extends Handler
	{
		public var controlPts:Array=[];
		public var target:GeoShape;		
		public var filters:Array=[new DropShadowFilter()];		
		public var color:uint=0xcc0101;
		public var transLevel:Number=0.4;
		public var raduis:int=10;
		
		public function Edit(map:GeoMap,options:Object)
		{
			super(map,options);			
		}
		//如果把图层也抽象出来的话，就需要修改这一部分
		
		//coordsz中存储的都是局部坐标
		/////////////////////////////control points//////////////////////////////////
		//控制点和编辑对象在一个层里，所以是一套共同的局部坐标系
		
		public function removeControlPts():void
		{
			for(var i:int =0;i<this.controlPts.length;i++){
				var p:Sprite = this.controlPts[i] as Sprite;
				
				trace(p.x+" "+p.y);
			}
			
			for(var i:int=0;i<this.controlPts.length;i++)
			{
				var p:Sprite=this.controlPts[i] as Sprite;
				p.parent.removeChild(p);
			   
			}
			this.controlPts=[];
		}
		
		public function antiPMultiData(arr:Array):Array
		{
			var r:Array=[];
			for(var i:int=0;i<arr.length;i++)
			{
				r.push(this.antiPData(arr[i]));
			}
			return r;
		}
		
		//buffer参数暂时留着而已
		public function antiPData(pts:Array):Array{
        	
        	for(var i:uint=0;i<pts.length-1;i=i+2)
        	{   
        		var px:LonLat = this.map.getLonLatFromLayerPx(new Pixel(pts[i], pts[i+1]));
        		pts[i] = px.lon;
        		pts[i+1] = px.lat;
        	}			
        	return pts;
	    }	
	    
		public function PData(pts:Array):Array{
//			var bfr:uint=0;
//        	var x:Number=bounds.x-bounds.width*bfr;
//        	var y:Number=bounds.y-bounds.height*bfr;        	
//        	var realRec:Rectangle=new Rectangle(x,y,(2*bfr+1)*bounds.width,(2*bfr+1)*bounds.height);
//        	var proportion:Number=Math.min(Math.abs(realRec.width/bbox.width),Math.abs(realRec.height/bbox.height));
//        	
//        	var dx:Number=0.001745;
//        	var dy:Number=-0.000860;
//        	for(var i:uint=0;i<pts.length-1;i=i+2)
//        	{   
//        		pts[i]=(pts[i]-bbox.x+dx)*proportion + realRec.x;
//        		pts[i+1]=-(pts[i+1]-bbox.y+dy)*proportion + realRec.bottom;
//        	}
        	for(var i:uint=0;i<pts.length-1;i=i+2)
        	{   
        		var px:Pixel = this.map.getLayerPxFromLonLat(new LonLat(pts[i], pts[i+1]));
        		pts[i] = px.x;
        		pts[i+1] = px.y;
        	}			
        	return pts;
	    }
	    
		public function PMultiData(arr:Array):Array
		{
			var r:Array=[];
			for(var i:int=0;i<arr.length;i++)
			{
				r.push(this.PData(arr[i]));
			}
			return r;
		}
		
	}
}