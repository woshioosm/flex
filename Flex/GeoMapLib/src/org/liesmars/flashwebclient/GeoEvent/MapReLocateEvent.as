package org.liesmars.flashwebclient.GeoEvent
{
	import flash.events.Event;
	
	import org.liesmars.flashwebclient.BaseTypes.LonLat;

	public class MapReLocateEvent extends Event
	{
		public static const MAP_RELOCATE:String="map_relocalte";
		
		public var lonLat:LonLat;
		public var level:Number;
		
		public function MapReLocateEvent(type:String,lonLat:LonLat,level:Number)
		{
			super(type);
			this.lonLat=lonLat;
			this.level=level;
		}
	}
}