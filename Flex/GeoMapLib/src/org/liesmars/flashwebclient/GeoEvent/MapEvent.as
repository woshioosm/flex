package org.liesmars.flashwebclient.GeoEvent
{
	import org.liesmars.flashwebclient.GeoEvent
	public class MapEvent extends GeoEvent
	{
		//20080710 by zhangxu
		public static const MAP_DRAG_START:String="mapdragstart";
		public static const MAP_DRAG_MOVE:String="mapdragmove";	
		public static const MAP_DRAG_STOP:String="mapdragstop";
		public static const MAP_MOVE_START:String="mapmovestart";
		public static const MAP_MOVE_MOVE:String="mapmovemove";		
		public static const MAP_MOVE_STOP:String="mapmovestop";
		public static const MAP_ZOOM:String="mapzoom";
		//
		public function MapEvent(type:String,bubbles:Boolean,cancelable:Boolean)
		{
			super(type,bubbles,cancelable);
		}
	}
}