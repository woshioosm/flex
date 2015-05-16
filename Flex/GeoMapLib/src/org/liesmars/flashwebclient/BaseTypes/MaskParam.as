package org.liesmars.flashwebclient.BaseTypes
{
	public class MaskParam
	{
		public function MaskParam(orignX:Number, orignY:Number, sizeW:Number, sizeH:Number)
		{
	    	this.orignX = orignX; // relative to layer, not px in map view 
	    	this.orignY = orignY;
	    	this.sizeW = sizeW;
	    	this.sizeH = sizeH;
		}
	    	// "orignX" "orignY" "sizeW" "sizeH"
	    public var orignX:Number = 0; // relative to layer, not px in map view 
	    public var orignY:Number = 0; 
		public var sizeW:Number = 0;
		public var sizeH:Number = 0;
			
	}
}