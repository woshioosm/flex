package org.liesmars.flashwebclient.GeoEvent
{
	import org.liesmars.flashwebclient.GeoEvent;

	public class IndexEvent extends GeoEvent
	{
		public static const ALL_INDEX_FINISHED:String = "all index is finished!";
		
		public function IndexEvent()
		{
			super(IndexEvent.ALL_INDEX_FINISHED, false, false);
		}
		
	}
}