package com.poyanghu.interaction.query.shapequery
{
	import com.poyanghu.entity.Coordinate;
	import com.poyanghu.entity.IShape;
	import com.poyanghu.geomapExt.events.QueryEvent;
	import com.poyanghu.geomapExt.layer.*;
	import com.poyanghu.geomapExt.util.MercatorProjection;
	import com.poyanghu.interaction.CoordinateMgr;
	import com.poyanghu.interaction.DistrictMgr;
	import com.poyanghu.interaction.events.*;
	import com.poyanghu.interaction.query.*;
	import com.poyanghu.interaction.query.draw.*;
	import com.poyanghu.interaction.util.*;
	import com.poyanghu.poi.POIMgr;
	import com.poyanghu.restriction.RestrictionConfig;
	import com.poyanghu.timeseries.district.DistrictTSMgr;
	import com.poyanghu.util.BaseConfig;
	import com.poyanghu.wfs.WFSQuerior;
	import com.poyanghu.wfs.WFSResponse;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequestMethod;
	
	import mx.collections.ArrayCollection;
	import mx.managers.CursorManager;
	
	import org.liesmars.flashwebclient.*;
	import org.liesmars.flashwebclient.BaseTypes.LonLat;
	import org.liesmars.flashwebclient.Layer.Vector;
	
	public class RegionalShapeQuery extends ShapeQuery
	{
		private var wfs:WFSQuerior = null;
		
		private var queryFunc:Function = null;
		
		public var queryMode:int = QueryMode.DISTRICT;
		
		public function RegionalShapeQuery(map:GeoMap, newQueryLayer:QueryLayer,epsg:String="900913",url:String="http://localhost:8080/geoserver/wfs")
		{
			super(map, newQueryLayer);
			wfs = new WFSQuerior(typeName,loadFinished);
			WFSQuerior.EPSG = epsg;
			wfs.url = url;
			
			wfs.outputFormat = BaseConfig.Config[BaseConfig.WFS_OUTPUTFORMAT];
		}
		
		override public function query(queryType:int,afterQuery:Function,invokeMDFunc:Boolean=true):void
		{
			super.query(queryType,afterQuery,invokeMDFunc);
			if(afterQuery!=null)
			{
				this.queryFunc = afterQuery;
				this.eventDispatcher.addEventListener(DrawEvent.DRAW_FINISHED,afterQuery);
			}
		}
		
		override protected function drawerQueryFinished(event:QueryEvent):void
		{
			super.drawerQueryFinished(event);
			if(this.queryMode ==QueryMode.DISTRICT)
			{
				var dMgr:DistrictMgr = DistrictMgr.getInstance();
				if( !dMgr.reachedSelectedLimit )
				{
					//将查询图形绘制到统一的查询层上
					LayerMgr.getInstance(this.geoMap).SelectionLayer.add(event.Shape);
					this.wfsQuery(event.Shape,event.QueryType);
				}
				else{
					dMgr.onReachedSelectionLimit();//发出一个警报
				}
			}
			else if(queryMode == QueryMode.TIMESERIES_DISTRICT || queryMode == QueryMode.POI)
			{
				//将查询图形绘制到统一的查询层上
				LayerMgr.getInstance(this.geoMap).SelectionLayer.add(event.Shape);
				
				var testShape:GeoShape = event.Shape;
				var vec:Vector = this.queryLayer.layer as Vector;
				//做碰撞检测
				var num:int = vec.numChildren;
				var shapeArr:Array = new Array();
				for(var i:int = 0;i<num;++i)
				{
					var shape:GeoShape = vec.getChildAt(i) as GeoShape;
					if(shape.hitTestObject(testShape))
					{
						shapeArr.push(shape);
					}
				}
				
				if(queryMode == QueryMode.TIMESERIES_DISTRICT)
				{
					var dtsMgr:DistrictTSMgr = DistrictTSMgr.getInstance();
					dtsMgr.addSelectedDistricts(shapeArr);
				}
				else if(queryMode == QueryMode.POI)
				{
					var poiMgr:POIMgr = POIMgr.getInstance();
					poiMgr.setSelected(shapeArr);
				}
				
				//做完碰撞检测就删除
				LayerMgr.getInstance(this.geoMap).SelectionLayer.removeChild(event.Shape);
			}
			else if(this.queryMode ==QueryMode.COORDINATE)
			{
				var coorMgr:CoordinateMgr = CoordinateMgr.getInstance();
				var lonLat:LonLat = MercatorProjection.Mercator2Lonlat(event.Shape.coords[0][0],event.Shape.coords[0][1]);
				var coor:Coordinate = new Coordinate(lonLat.lat,lonLat.lon);
				coor.addAtrribute(CoordinateMgr.DISPLAYNAME,coorMgr.generateUniqueName("Coordinate"));
				coorMgr.addSelectedCoordinate(coor);
			}
		}
		//to be overrided
		override protected function onMouseDown(e:Event):void
		{
			DrawingHelper.clearSelection();
		}
		
		override public function stopQuery():void
		{
			if(this.eventDispatcher!=null&&this.queryFunc!=null)
			{
				this.eventDispatcher.removeEventListener(DrawEvent.DRAW_FINISHED,this.queryFunc);
			}
			super.stopQuery();
		}
		
		protected function wfsQuery(geoShape:GeoShape,queryType:int):void
		{
			var shape:IShape = ShapeAdapter.parseGeoShapeToWFSShape(geoShape,queryType);
			wfs.method = URLRequestMethod.POST;
			wfs.queryByShape(shape,"the_geom");
		}
		
		protected function loadFinished(event:Event):void
		{
			//显示shape信息,目前只显示模式为DISTRICT的信息，即行政区的信息，如模式为Coordinate，这里不进行绘制
			if(this.queryMode == QueryMode.DISTRICT&&this.bShowOnMap)
			{
				var shapeDrawer:DistrictDrawer = DistrictDrawer.getInstance(this.geoMap,this.queryLayer);
				shapeDrawer.wfsResponse = wfs.WfsResponse;
				shapeDrawer.draw();
				
				var queryLayer:VectorExt = LayerMgr.getInstance(this.geoMap).SelectionLayer;
				queryLayer.clearShape();
			}
			onCompleteDrawing(wfs.WfsResponse);
		}
		
		protected function onCompleteDrawing(wfsResponse:WFSResponse):void
		{
			var drawEvent:DrawEvent = new DrawEvent(wfsResponse);
			this.eventDispatcher.dispatchEvent(drawEvent);
		}
		
		public function set WFSQueryMode(newWFSQueryMode:int):void
		{
			this.wfs.queryMode = newWFSQueryMode;
		}
		
		public function set QueryProperties(newProperties:ArrayCollection):void
		{
			this.wfs.properties = newProperties;
		}
		
		public function set Url(newUrl:String):void
		{
			this.wfs.url = newUrl;
		}
		
		override public function set QueryLayer(newQueryLayer:QueryLayer):void
		{
			super.QueryLayer = newQueryLayer;
			if(newQueryLayer!=null)
			{
				this.wfs.typename = this.typeName;
				if(newQueryLayer is DistrictLayer)
				{
					this.wfs.maxFeatures = RestrictionConfig.DistrictSelectionLimit[(newQueryLayer as DistrictLayer).level]+1;
				}
			}
		}
	}
}