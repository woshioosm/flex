package com.poyanghu.interaction.query.shapequery
{
	import com.poyanghu.entity.*;
	import com.poyanghu.geomapExt.layer.QueryLayer;
	import com.poyanghu.interaction.events.*;
	import com.poyanghu.interaction.query.draw.*;
	import com.poyanghu.interaction.util.*;
	import com.poyanghu.wfs.WFSQuerior;
	import com.poyanghu.wfs.WFSResponse;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequestMethod;
	
	import org.liesmars.flashwebclient.GeoMap;
	
	public class CoordinateQuery
	{
		private var geoMap:GeoMap = null;
		private var wfs:WFSQuerior = null;
		private var queryDrawer:IShapeDrawer = null;
		
		private var eventDispatcher:EventDispatcher = null;
		private var queryFunc:Function = null;
		private var typeName:String = null;
		private var queryLayer:QueryLayer = null;
		
		public function CoordinateQuery(map:GeoMap,newQueryLayer:QueryLayer,epsg:String="900913",url:String="http://localhost:8080/geoserver/wfs")
		{
			this.geoMap = map;	
			this.queryLayer = newQueryLayer;
			if(queryLayer != null)
			{
				this.typeName = queryLayer.featureType;
			}
			else
			{
				this.typeName = "";
			}
			wfs = new WFSQuerior(typeName,loadFinished);
			WFSQuerior.EPSG = epsg;
			wfs.url = url;
			this.eventDispatcher = new EventDispatcher();
		}
		
		public function query(coorList:Array,newRadius:Number,afterQuery:Function,invokeMDFunc:Boolean = true):void
		{
			if(coorList == null || coorList.length == 0)
			{
				return;
			}
			
			var shape:IShape = null;
			if(coorList.length == 1)
			{
				shape = Circle.fromCenterPointAndRadius(coorList[0],newRadius);
			}
			else
			{
				shape = new LineString(coorList,newRadius);
			}
			if(afterQuery!=null)
	        {
		        this.queryFunc = afterQuery;
		        this.eventDispatcher.addEventListener(DrawEvent.DRAW_FINISHED,afterQuery);
         	}
         	wfs.method = URLRequestMethod.POST;
			wfs.queryByShape(shape,"the_geom");
		}
		
		private function loadFinished(event:Event):void
		{	
			//显示shape信息
			var shapeDrawer:DistrictDrawer = DistrictDrawer.getInstance(this.geoMap,this.queryLayer);
			shapeDrawer.wfsResponse = wfs.WfsResponse;
			shapeDrawer.draw();
			onCompleteDrawing(wfs.WfsResponse);
		}
		private function onCompleteDrawing(wfsResponse:WFSResponse):void
        {
        	var drawEvent:DrawEvent = new DrawEvent(wfsResponse);
        	this.eventDispatcher.dispatchEvent(drawEvent);
        }

	}
}