package org.liesmars.flashwebclient.MapUIEvent
{
	import flash.events.Event;
	
	public class LayerMaskEvent extends Event
	{
		static public const MASK_LAYER:String = "maskLayer";
		public var data:Object;
		
		public function LayerMaskEvent(data:Object, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(MASK_LAYER, bubbles, cancelable);
			this.data = data;
		}

	}
}