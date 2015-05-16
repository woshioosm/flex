package org.liesmars.flashwebclient.MapUIEvent
{
	import flash.events.Event;
		
	public class LayerCheckEvent extends Event
	{
		static public const CHECK_LAYER:String = "checkLayer";
		public var data:Object;
				
		public function LayerCheckEvent(data:Object, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(CHECK_LAYER, bubbles, cancelable);
			this.data = data;
		}
	
	}
}
