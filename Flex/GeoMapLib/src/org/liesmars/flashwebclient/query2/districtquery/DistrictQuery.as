package com.poyanghu.interaction.query.districtquery
{
	import com.poyanghu.entity.*;
	import com.poyanghu.geomapExt.layer.DistrictLayer;
	import com.poyanghu.geomapExt.layer.LayerMgr;
	import com.poyanghu.geomapExt.layer.QueryLayer;
	import com.poyanghu.geomapExt.layer.VectorExt;
	import com.poyanghu.interaction.DistrictMgr;
	import com.poyanghu.interaction.events.*;
	import com.poyanghu.interaction.query.QueryMode;
	import com.poyanghu.interaction.query.draw.*;
	import com.poyanghu.interaction.query.shapequery.*;
	import com.poyanghu.interaction.util.*;
	import com.poyanghu.restriction.RestrictionConfig;
	import com.poyanghu.timeseries.district.DistrictTSMgr;
	import com.poyanghu.util.BaseConfig;
	import com.poyanghu.wfs.WFSQuerior;
	import com.poyanghu.wfs.WFSResponse;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequestMethod;
	
	import mx.collections.ArrayCollection;
	
	import org.liesmars.flashwebclient.GeoMap;
	import org.liesmars.flashwebclient.GeoShape;
	
	public class DistrictQuery
	{
		private var geoMap:GeoMap = null;
		private var wfs:WFSQuerior = null;
		private var queryDrawer:IShapeDrawer = null;
		
		private var eventDispatcher:EventDispatcher = null;
		private var queryFunc:Function = null;
		private var queryLayer:QueryLayer = null;
		private var typeName:String = null;
		
		public var queryMode:int = QueryMode.DISTRICT;
		public var bShowOnMap:Boolean = false;
		
		public function DistrictQuery(map:GeoMap,newQueryLayer:QueryLayer,epsg:String="900913")
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
			var layerMgr:LayerMgr = LayerMgr.getInstance(null);
			if(BaseConfig.Config["wfsproxy"] == "false")
			{
				wfs.url = BaseConfig.Config[BaseConfig.GEOSERVER_ADDRESS];
			}else{
				wfs.url = BaseConfig.Config[BaseConfig.REPORT_SERVICE_ADDRESS]+"/RequestWFS";
			}	
			wfs.outputFormat = BaseConfig.Config[BaseConfig.WFS_OUTPUTFORMAT];
			wfs.method =  URLRequestMethod.POST;
			this.eventDispatcher = new EventDispatcher();
		}
		
		public function queryByCode(districtArr:Array,afterQuery:Function):void
		{
			var layerMgr:LayerMgr = LayerMgr.getInstance(null);
			var queryMode:int = layerMgr.SelectionMode;
			
			if(queryMode == QueryMode.DISTRICT)
			{
				if(afterQuery!=null)
				{
					this.queryFunc = afterQuery;
					this.eventDispatcher.addEventListener(DrawEvent.DRAW_FINISHED,afterQuery);
				}
				var propertyName:String = this.queryLayer.idField;
				this.wfs.queryByDistricts(districtArr,propertyName,false);
			}
			else if(queryMode == QueryMode.TIMESERIES_DISTRICT)
			{
			}
		}
		
		private function loadFinished(event:Event):void
		{
			//显示shape信息,目前只显示模式为DISTRICT的信息，即行政区的信息，如模式为Coordinate，这里不进行绘制
			if(this.queryMode == QueryMode.DISTRICT&&this.bShowOnMap)
			{
				//显示shape信息
				var shapeDrawer:DistrictDrawer = DistrictDrawer.getInstance(this.geoMap,this.queryLayer);
				shapeDrawer.wfsResponse = wfs.WfsResponse;
				shapeDrawer.draw();
			}
			
			this.geoMap.EvtObjMoveAway();
			onCompleteDrawing(wfs.WfsResponse);
		}
		private function onCompleteDrawing(wfsResponse:WFSResponse):void
        {
        	var drawEvent:DrawEvent = new DrawEvent(wfsResponse);
        	this.eventDispatcher.dispatchEvent(drawEvent);
        }
        
        public function set QueryLayer(newQueryLayer:QueryLayer):void
        {
        	if(newQueryLayer!=null)
        	{
	        	this.queryLayer = newQueryLayer;
	        	this.typeName = this.queryLayer.featureType;
	        	this.wfs.typename = this.typeName;
				if(newQueryLayer is DistrictLayer)
				{
					this.wfs.maxFeatures = RestrictionConfig.DistrictSelectionLimit[(newQueryLayer as DistrictLayer).level]+1;
				}
	        }
	    }
        
        public function set WFSQueryMode(newWFSQueryMode:int):void
        {
        	this.wfs.queryMode = newWFSQueryMode;
        }
        
        public function set QueryProperties(newProperties:ArrayCollection):void
        {
        	this.wfs.properties = newProperties;
        }
	}
}